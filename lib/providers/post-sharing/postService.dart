import 'dart:convert';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderverse_app/providers/authentication/authService.dart';
import 'package:wanderverse_app/providers/models.dart';
import 'package:wanderverse_app/utils/env.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

part 'postService.g.dart';
part 'postService.freezed.dart';

final _baseUrl = environment['api_url'];

@freezed
class PostsState with _$PostsState {
  PostsState._();
  factory PostsState(
      {@Default([]) List<Post> posts,
      @Default(false) bool isLoading,
      String? errorMessage,
      @Default(0) int currentPage,
      @Default(12) int pageSize,
      @Default(true) bool hasMore}) = _PostsState;
}

@Riverpod(keepAlive: true)
class PostService extends _$PostService {
  @override
  PostsState build() {
    // delay async task after initializing it
    Future.microtask(() => getPosts());
    return PostsState(currentPage: 0, pageSize: 5);
  }

  Future<String?> _getToken() async {
    // Try from state first
    final authState = ref.read(authServiceProvider);
    String? token = authState.token;

    // Fallback to SharedPreferences if null
    if (token == null) {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('auth_token');
      ref.read(authServiceProvider.notifier).updateToken(token ?? "");
      print("Retrieved token from SharedPreferences: $token");
    }

    return token;
  }

  Future<Map<String, String>> get _headers async {
    final token = await _getToken();
    print("DEBUG: $token");
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  void _handleError(String message) {
    state = state.copyWith(isLoading: false, errorMessage: message);
  }

  // GET post with paginations from backend
  Future<void> getPosts() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      String? token = await _getToken();
      if (token == null) {
        token = await _getToken();
        print("DEBUG: new token: $token");
        // _handleError("Authentication required");
        // return;
      }

      print("DEBUG: current page: ${state.currentPage}");

      final url = Uri.parse(
          '$_baseUrl/api/post/listPosts?page=${state.currentPage}&size=${state.pageSize}');

      final response = await http.get(url, headers: await _headers);

      print("DEBUG - Requesting URL: $url with token: $token");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> postsJson = data['content'] ?? [];
        final bool hasMorePages = !data['last'];

        print(data);

        final newPosts = postsJson
            .map((json) {
              try {
                final destination = json["destination"];
                final name = destination["name"];
                print("Destination name: $name");

                return Post(
                    id: json["id"].toString(),
                    title: json["title"],
                    content: json["content"],
                    imageUrls: (json["imageUrls"] as List<dynamic>)
                        .map((url) => url.toString())
                        .toList(),
                    // Safe date parsing with fallback
                    createdAt: _parseDateTime(json["createdAt"]),
                    updatedAt: _parseDateTime(json["updatedAt"]),
                    creatorId: json["creator"]["username"],
                    likesCount: json["likesCount"],
                    commentsCount: json["commentsCount"],
                    destinationId: name);
              } catch (e) {
                print("Error parsing post: $e");
                return null;
              }
            })
            .where((post) => post != null)
            .cast<Post>()
            .toList();

        print("New post: ${newPosts.isEmpty ? "None" : "have"}");

        final allPosts = [...state.posts, ...newPosts];
        print("DEBUG: allPost = $allPosts");
        allPosts
            .sort((post1, post2) => post2.updatedAt.compareTo(post1.updatedAt));

        state = state.copyWith(
            posts: allPosts,
            isLoading: false,
            hasMore: hasMorePages,
            currentPage: state.currentPage + 1);
      } else {
        _handleError("Failed to load posts. Status: ${response.statusCode}");
      }
    } catch (e) {
      _handleError('Network error: ${e.toString()}');
    }
  }

  Future<void> loadMorePosts() async {
    if (!state.isLoading && state.hasMore) {
      await getPosts();
    }
  }

  Future<void> refreshPosts() async {
    state = state
        .copyWith(posts: [], currentPage: 0, hasMore: true, isLoading: false);
    await getPosts();
  }

  // Create post
  Future<bool> createPost(String title, String content, String destination,
      {List<Uint8List>? imageFiles}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    // Upload images
    List<String> imageUrls = [];
    if (imageFiles != null && imageFiles.isNotEmpty) {
      imageUrls = await _uploadImages(imageFiles);
      if (imageUrls.isEmpty) {
        state = state.copyWith(
            isLoading: false, errorMessage: "Failed to upload image");
        return false;
      }
    }

    // create post metadata
    try {
      print(
          "DEBUG: User data from auth: ${ref.read(authServiceProvider).userData}");
      final userId = ref.read(authServiceProvider).userData['id'];
      final response = await http.post(Uri.parse('$_baseUrl/api/post/create'),
          headers: await _headers,
          body: jsonEncode({
            'title': title,
            'content': content,
            'destinationId': 1,
            'creatorId': userId,
            'imageUrls': imageUrls,
            // 'tags': tags
          }));

      // Print detailed error info for debugging
      if (response.statusCode != 201) {
        print("Create post failed with status: ${response.statusCode}");
        print("Response body: ${response.body}");
        print("Request payload: ${jsonEncode({
              'title': title,
              'content': content,
              'destinationId': destination,
              'creatorId': userId,
              'imageUrls': imageUrls,
            })}");
      }

      if (response.statusCode == 201) {
        try {
          final data = json.decode(response.body);

          // Check if required nested objects exist
          if (data['creator'] == null || data['destination'] == null) {
            print("Error: Missing creator or destination in response");
            print("Response data: $data");
            _handleError('Invalid response data from server');
            return false;
          }

          final transformedData = {
            'id': data['id'].toString(),
            'title': data['title'],
            'content': data['content'],
            'imageUrls': data['imageUrls'] ?? [],
            'createdAt': data['createdAt'],
            'updatedAt': data['updatedAt'],
            'likesCount': data['likesCount'] ?? 0,
            'commentsCount': data['commentsCount'] ?? 0,
            'creatorId': data['creator']['username'],
            'destinationId': data['destination']['name']
          };

          final newPost = Post.fromJson(transformedData);
          final allPosts = [newPost, ...state.posts];
          allPosts.sort(
              (post1, post2) => post2.updatedAt.compareTo(post1.updatedAt));

          state = state.copyWith(posts: allPosts, isLoading: false);

          print("DEBUG: Successfully created post");
          return true;
        } catch (e) {
          print("Error processing create post response: $e");
          _handleError('Failed to process server response');
          return false;
        }
      } else {
        _handleError('Failed to create post. Status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      _handleError('Network error: ${e.toString()}');
      return false;
    }
  }

  Future<List<String>> _uploadImages(List<Uint8List> images) async {
    try {
      List<String> uploadedUrls = [];

      // upload images one by one
      for (var imageBytes in images) {
        // Compress image before upload
        final compressedImage = await FlutterImageCompress.compressWithList(
          imageBytes,
          minHeight: 1080,
          minWidth: 1080,
          quality: 85,
        );
        final uploadedUrl = await _uploadSingleImage(compressedImage);
        if (uploadedUrl != null) {
          uploadedUrls.add(uploadedUrl);
        }
      }

      return uploadedUrls;
    } catch (e) {
      print("Error uploading images: $e");
      return [];
    }
  }

  Future<String?> _uploadSingleImage(Uint8List imageBytes) async {
    try {
      final token = await _getToken();
      if (token == null) return null;

      final url = Uri.parse("$_baseUrl/api/storage/upload");
      final request = http.MultipartRequest('POST', url);

      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      // Add file (can set the filename here if needed)
      request.files.add(
        http.MultipartFile.fromBytes('image', imageBytes,
            filename: 'image_${DateTime.now().millisecondsSinceEpoch}.jpg',
            contentType: MediaType('image', 'jpeg')),
      );

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        print("Success image url uploaded: ${responseData['imageUrl']}");
        return responseData['imageUrl'] ?? responseData['url'];
      } else {
        print("Upload image failed with status: ${response.statusCode}");
        print("Response body: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error uploading single image: $e");
      return null;
    }
  }

  // Update and delete posts mthods here

  // Add this helper method to your PostService class
  DateTime _parseDateTime(String? dateString) {
    if (dateString == null) return DateTime.now();

    try {
      return DateTime.parse(dateString);
    } catch (e) {
      print("Error parsing date: $dateString");
      return DateTime.now();
    }
  }
}
