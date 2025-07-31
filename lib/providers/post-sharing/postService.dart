// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderverse_app/providers/authentication/authService.dart';
import 'package:wanderverse_app/providers/models.dart';
import 'package:wanderverse_app/providers/post-sharing/likeService.dart';
import 'package:wanderverse_app/providers/post-sharing/userService.dart';
import 'package:wanderverse_app/router/appState.dart';
import 'package:wanderverse_app/utils/env.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

part 'postService.g.dart';
part 'postService.freezed.dart';

final _baseUrl = environment['api_url'];

enum PostApiType { sharing, discussion }

extension PostApiTypeExtension on PostApiType {
  String get endpoint {
    switch (this) {
      case PostApiType.sharing:
        return "sharing";
      case PostApiType.discussion:
        return "discussion";
    }
  }
}

@freezed
class PostsState with _$PostsState {
  PostsState._();
  factory PostsState({
    @Default([]) List<Post> posts,
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(0) int currentPage,
    @Default(12) int pageSize,
    @Default(true) bool hasMore,
  }) = _PostsState;
}

// final sharingPostsProvider = postServiceProvider(PostApiType.sharing);
// final discussionPostsProvider = postServiceProvider(PostApiType.discussion);

@Riverpod(keepAlive: true)
class PostService extends _$PostService {
  @override
  PostsState build(PostApiType type, String destinationId) {
    // Initialize with the specific post type
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

  PostType _convertPostType(String postType) {
    switch (postType) {
      case "post":
        return PostType.post;
      case "experience":
        return PostType.experience;
      case "questions":
        return PostType.questions;
      case "tips":
        return PostType.tips;
      default:
        return PostType.post;
    }
  }

  // GET post with paginations from backend
  Future<void> getPosts() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // Access the type parameter using the property 'type'
      final url = Uri.parse(
        '$_baseUrl/api/post/${type.endpoint}?destinationId=$destinationId&page=${state.currentPage}&size=${state.pageSize}',
      );

      final response = await http.get(url, headers: await _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> postsJson = data['content'] ?? [];
        final bool hasMorePages = !data['last'];

        // print(data);

        final newPosts = postsJson
            .map((json) {
              try {
                // Initialize like data with count from post
                ref
                    .read(likeServiceProvider(json["id"]).notifier)
                    .initWithPostData(json["likesCount"]);

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
                  creator: User(
                    id: json["creator"]["id"].toString(),
                    username: json["creator"]["username"],
                    email: json["creator"]["email"],
                    description: json["creator"]["description"],
                    profilePicUrl: json["creator"]["profilePicUrl"],
                    gamePoints: json["creator"]["gamePoints"],
                    createdAt: _parseDateTime(json["creator"]["createdAt"]),
                    updatedAt: _parseDateTime(json["creator"]["updatedAt"]),
                    badgesUrls: (json["creator"]["badgesUrls"] as List<dynamic>)
                        .map((url) => url.toString())
                        .toList(),
                  ),
                  likesCount: json["likesCount"],
                  commentsCount: json["commentsCount"],
                  destination: Destination(
                    id: json["destination"]["id"].toString(),
                    name: json["destination"]["name"],
                    description: json["destination"]["description"],
                    imageUrl: json["destination"]["imageUrl"],
                    createdAt: _parseDateTime(json["destination"]["createdAt"]),
                    updatedAt: _parseDateTime(json["destination"]["updatedAt"]),
                  ),
                  postType: _convertPostType(json["postType"]),
                );
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
        // print("DEBUG: allPost = $allPosts");
        // allPosts
        //     .sort((post1, post2) => post2.createdAt.compareTo(post1.createdAt));

        state = state.copyWith(
          posts: allPosts,
          isLoading: false,
          hasMore: hasMorePages,
          currentPage: state.currentPage,
        );
      } else {
        if (response.statusCode == 401) {
          await ref.read(authServiceProvider.notifier).logout();
        }
        _handleError("Failed to load posts. Status: ${response.statusCode}");
      }
    } catch (e) {
      _handleError('Network error: ${e.toString()}');
    }
  }

  Future<List<Post>> getRecommendedPosts() async {
    print("starting to get recommend posts");
    try {
      // CORRECT: Only READ the user state. Do not watch or trigger updates.
      final user = ref.read(userServiceProvider).user;
      var userId;
      if (user != null) {
        userId = user.id;
      }

      // If the user is not logged in or not yet loaded, we can't get recommendations.
      if (user == null) {
        print("Cannot get recommendations: User not available.");
        // ref.read(authServiceProvider.notifier);
        print("user from current: ${ref.read(authServiceProvider).userData}");
        userId = ref.read(authServiceProvider).userData["id"];
        // return []; // Return an empty list gracefully.
      }

      final url = Uri.parse(
        '$_baseUrl/api/post/sharing/recommend?userId=$userId',
      );

      final response = await http.get(url, headers: await _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("got data from recommend: $data");
        // Minor fix: handle null data case safely
        final List<dynamic> postsJson = data is List ? data : [];

        final recommendedPosts = postsJson
            .map((json) {
              try {
                // Initialize like data with count from post
                ref
                    .read(likeServiceProvider(json["id"]).notifier)
                    .initWithPostData(json["likesCount"]);

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
                  creator: User(
                    id: json["creator"]["id"].toString(),
                    username: json["creator"]["username"],
                    email: json["creator"]["email"],
                    description: json["creator"]["description"],
                    profilePicUrl: json["creator"]["profilePicUrl"],
                    gamePoints: json["creator"]["gamePoints"],
                    createdAt: _parseDateTime(json["creator"]["createdAt"]),
                    updatedAt: _parseDateTime(json["creator"]["updatedAt"]),
                    badgesUrls: (json["creator"]["badgesUrls"] as List<dynamic>)
                        .map((url) => url.toString())
                        .toList(),
                  ),
                  likesCount: json["likesCount"],
                  commentsCount: json["commentsCount"],
                  destination: Destination(
                    id: json["destination"]["id"].toString(),
                    name: json["destination"]["name"],
                    description: json["destination"]["description"],
                    imageUrl: json["destination"]["imageUrl"],
                    createdAt: _parseDateTime(json["destination"]["createdAt"]),
                    updatedAt: _parseDateTime(json["destination"]["updatedAt"]),
                  ),
                  postType: _convertPostType(json["postType"]),
                );
              } catch (e) {
                print("Error parsing post: $e");
                return null;
              }
            })
            .where((post) => post != null)
            .cast<Post>()
            .toList();

        print(
          "Recommended post: ${recommendedPosts.isEmpty ? "None" : "have"}",
        );

        return recommendedPosts;
      } else {
        if (response.statusCode == 401) {
          await ref.read(authServiceProvider.notifier).logout();
          ref.read(appstateProvider.notifier).changeAppRoute('/auth');
        }
        print(
          "Failed to load recommended posts. Status: ${response.statusCode}",
        );
        return [];
      }
    } catch (e) {
      print('Network error: ${e.toString()}');
      return [];
    }
  }

  Future<List<Post>> getSearchPosts(String query) async {
    print("🔍 PostService.getSearchPosts called with query: '$query'");

    try {
      if (query.isEmpty) {
        print("🔍 Empty search query");
        return [];
      }

      // Encode the query parameter to handle special characters
      final encodedQuery = Uri.encodeComponent(query);
      final url = Uri.parse(
        '$_baseUrl/api/post/sharing/search?query=$encodedQuery',
      );

      print("🔍 Sending request to: ${url.toString()}");

      final response = await http.get(url, headers: await _headers);

      print("🔍 Search response status code: ${response.statusCode}");
      print("🔍 Response body preview: ${response.body}...");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Debug the response structure
        print("🔍 Data type: ${data.runtimeType}");
        if (data is List) {
          print("🔍 Data is a List with ${data.length} items");
        } else if (data is Map) {
          print("🔍 Data is a Map with keys: ${data.keys.toList()}");
          if (data.containsKey('content')) {
            print("🔍 'content' has ${(data['content'] as List).length} items");
          }
        } else {
          print("🔍 Unknown data format");
        }

        // Handle both array and paginated object responses
        final List<dynamic> postsJson;
        if (data is List) {
          postsJson = data;
        } else if (data is Map && data.containsKey('content')) {
          postsJson = data['content'] as List<dynamic>;
        } else {
          postsJson = [];
          print("🔍 Could not extract posts from response");
        }

        if (postsJson.isEmpty) {
          print("🔍 No posts found in response");
          return [];
        }

        final searchResults = postsJson
            .map((json) {
              try {
                // Initialize like data with count from post
                ref
                    .read(likeServiceProvider(json["id"]).notifier)
                    .initWithPostData(json["likesCount"]);

                return Post(
                  id: json["id"].toString(),
                  title: json["title"],
                  content: json["content"],
                  imageUrls: (json["imageUrls"] as List<dynamic>)
                      .map((url) => url.toString())
                      .toList(),
                  createdAt: _parseDateTime(json["createdAt"]),
                  updatedAt: _parseDateTime(json["updatedAt"]),
                  creator: User(
                    id: json["creator"]["id"].toString(),
                    username: json["creator"]["username"],
                    email: json["creator"]["email"],
                    description: json["creator"]["description"],
                    profilePicUrl: json["creator"]["profilePicUrl"],
                    gamePoints: json["creator"]["gamePoints"],
                    createdAt: _parseDateTime(json["creator"]["createdAt"]),
                    updatedAt: _parseDateTime(json["creator"]["updatedAt"]),
                    badgesUrls: (json["creator"]["badgesUrls"] as List<dynamic>)
                        .map((url) => url.toString())
                        .toList(),
                  ),
                  likesCount: json["likesCount"],
                  commentsCount: json["commentsCount"],
                  destination: Destination(
                    id: json["destination"]["id"].toString(),
                    name: json["destination"]["name"],
                    description: json["destination"]["description"],
                    imageUrl: json["destination"]["imageUrl"],
                    createdAt: _parseDateTime(json["destination"]["createdAt"]),
                    updatedAt: _parseDateTime(json["destination"]["updatedAt"]),
                  ),
                  postType: _convertPostType(json["postType"]),
                );
              } catch (e) {
                print("Error parsing search result: $e");
                return null;
              }
            })
            .where((post) => post != null)
            .cast<Post>()
            .toList();

        print("Parsed search results: ${searchResults.length} posts");
        return searchResults;
      } else {
        print("🔍 Search failed with status: ${response.statusCode}");
        print("🔍 Response body: ${response.body}");
        return [];
      }
    } catch (e) {
      print("🔍 Search network error: ${e.toString()}");
      return [];
    }
  }

  // Method to refresh posts
  Future<void> refreshPosts() async {
    state = state.copyWith(
      currentPage: 0,
      hasMore: true,
      posts: [],
      isLoading: false,
    );
    await getPosts();
  }

  // Method to load more posts
  Future<void> loadMorePosts() async {
    if (!state.isLoading && state.hasMore) {
      state = state.copyWith(currentPage: state.currentPage + 1);
      await getPosts();
    }
  }

  // Create post
  Future<bool> createPost(
    String title,
    String content,
    String destinationId, {
    List<Uint8List>? imageFiles,
    PostType postType = PostType.post,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    // Upload images
    List<String> imageUrls = [];
    if (imageFiles != null && imageFiles.isNotEmpty) {
      imageUrls = await _uploadImages(imageFiles);
      if (imageUrls.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: "Failed to upload image",
        );
        return false;
      }
    }

    // create post metadata
    try {
      print(
        "DEBUG: User data from auth: ${ref.read(authServiceProvider).userData}",
      );
      final userId = ref.read(authServiceProvider).userData['id'];
      final response = await http.post(
        Uri.parse('$_baseUrl/api/post'),
        headers: await _headers,
        body: jsonEncode({
          'title': title,
          'content': content,
          'destinationId': destinationId,
          'creatorId': userId,
          'imageUrls': imageUrls,
          'postType': postType.toJson(),
        }),
      );

      // Print detailed error info for debugging
      if (response.statusCode != 201) {
        print("Create post failed with status: ${response.statusCode}");
        print("Response body: ${response.body}");
        print(
          "Request payload: ${jsonEncode({'title': title, 'content': content, 'destinationId': destinationId, 'creatorId': userId, 'imageUrls': imageUrls, 'postType': postType})}",
        );
      }

      if (response.statusCode == 201) {
        try {
          final data = json.decode(response.body);

          // Initialize like data with count from post
          ref
              .read(
                likeServiceProvider(int.parse(data["id"].toString())).notifier,
              )
              .initWithPostData(data["likesCount"]);

          final newPost = Post(
            id: data["id"].toString(),
            title: data["title"],
            content: data["content"],
            imageUrls: (data["imageUrls"] as List<dynamic>)
                .map((url) => url.toString())
                .toList(),
            createdAt: _parseDateTime(data["createdAt"]),
            updatedAt: _parseDateTime(data["updatedAt"]),
            creator: User(
              id: data["creator"]["id"].toString(),
              username: data["creator"]["username"],
              email: data["creator"]["email"],
              description: data["creator"]["description"],
              profilePicUrl: data["creator"]["profilePicUrl"],
              gamePoints: data["creator"]["gamePoints"],
              createdAt: _parseDateTime(data["creator"]["createdAt"]),
              updatedAt: _parseDateTime(data["creator"]["updatedAt"]),
              badgesUrls: (data["creator"]["badgesUrls"] as List<dynamic>)
                  .map((url) => url.toString())
                  .toList(),
            ),
            likesCount: data["likesCount"],
            commentsCount: data["commentsCount"],
            destination: Destination(
              id: data["destination"]["id"].toString(),
              name: data["destination"]["name"],
              description: data["destination"]["description"],
              imageUrl: data["destination"]["imageUrl"],
              createdAt: _parseDateTime(data["destination"]["createdAt"]),
              updatedAt: _parseDateTime(data["destination"]["updatedAt"]),
            ),
            postType: _convertPostType(data["postType"]),
          );

          final List<Post> allPosts = [newPost, ...state.posts];
          // allPosts.sort(
          //     (post1, post2) => post2.createdAt.compareTo(post1.createdAt));
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

      request.headers.addAll({'Authorization': 'Bearer $token'});

      // Add file (can set the filename here if needed)
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          imageBytes,
          filename: 'image_${DateTime.now().millisecondsSinceEpoch}.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
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

  void updatePostLikeCount(String postId, int change) {
    // Find the post
    final posts = state.posts;
    final index = posts.indexWhere((post) => post.id == postId);

    if (index != -1) {
      // Create updated post with new like count
      final post = posts[index];
      final updatedPost = post.copyWith(likesCount: post.likesCount + change);

      // Create new posts list with updated post
      final newPosts = List<Post>.from(posts);
      newPosts[index] = updatedPost;

      // Update state
      state = state.copyWith(posts: newPosts);
    }
  }

  void updatePostCommentCount(String postId, int change) {
    // Find the post
    final posts = state.posts;
    final index = posts.indexWhere((post) => post.id == postId);

    if (index != -1) {
      // Create updated post with new comment count
      final post = posts[index];
      final updatedPost = post.copyWith(
        commentsCount: post.commentsCount + change,
      );

      // Create new posts list with updated post
      final newPosts = List<Post>.from(posts);
      newPosts[index] = updatedPost;

      // Update state
      state = state.copyWith(posts: newPosts);
    }
  }
}
