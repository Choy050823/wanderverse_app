// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderverse_app/providers/authentication/authService.dart';
import 'package:wanderverse_app/providers/models.dart';
import 'package:wanderverse_app/providers/post-sharing/postService.dart';
import 'package:wanderverse_app/utils/env.dart';
import 'package:http/http.dart' as http;

part 'commentService.g.dart';

final _baseUrl = environment['api_url'];

@Riverpod(keepAlive: true)
class CommentService extends _$CommentService {
  @override
  Future<List<Comment>> build(int postId) async {
    return getComments(postId);
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

  // void _handleError(String message) {
  //   state = [];
  // }

  DateTime _parseDateTime(String? dateString) {
    if (dateString == null) return DateTime.now();

    try {
      return DateTime.parse(dateString);
    } catch (e) {
      print("Error parsing date: $dateString");
      return DateTime.now();
    }
  }

  Future<List<Comment>> getComments(int postId) async {
    try {
      String? token = await _getToken();
      if (token == null) {
        token = await _getToken();
        print("DEBUG: new token: $token");
      }

      // print("DEBUG: current user id: $postId");

      final url = Uri.parse('$_baseUrl/api/comment/$postId');

      final response = await http.get(url, headers: await _headers);

      print("DEBUG - Requesting URL: $url with token: $token");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return parseCommentsFromJson(data);

        // state = state.copyWith(user: user, isLoading: false);
      } else {
        print("Failed to load user. Status: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      // _handleError(e.toString());
      print("Error: ${e.toString()}");
      return [];
    }
  }

  List<Comment> parseCommentsFromJson(List<dynamic> commentsJson) {
    if (commentsJson == []) {
      return [];
    }

    // print("Comments: $commentsJson");

    return commentsJson
        .map((comment) => Comment(
            id: comment["id"].toString(),
            postId: comment["post"]["id"].toString(),
            content: comment["content"],
            createdAt: _parseDateTime(comment["createdAt"]),
            user: User(
                id: comment["user"]["id"].toString(),
                username: comment["user"]["username"],
                email: comment["user"]["email"],
                description: comment["user"]["description"],
                profilePicUrl: comment["user"]["profilePicUrl"],
                gamePoints: comment["user"]["gamePoints"],
                createdAt: _parseDateTime(comment["user"]["createdAt"]),
                updatedAt: _parseDateTime(comment["user"]["updatedAt"])),
            replies: parseCommentsFromJson(comment["replies"])))
        .toList();
  }

  Future<bool> createComment(
      String postId, String content, String destinationId,
      {String? parentCommentId}) async {
    try {
      // First, get all the data you'll need BEFORE invalidating
      final userId = ref.read(authServiceProvider).userData['id'];

      // Determine post type ahead of time rather than watching after invalidation
      final isSharingPost = ref
          .read(postServiceProvider(PostApiType.sharing, "all"))
          .posts
          .any((post) => post.id == postId);

      // Make the API request
      final response = await http.post(Uri.parse('$_baseUrl/api/comment'),
          headers: await _headers,
          body: jsonEncode({
            'postId': postId,
            'content': content,
            'userId': userId,
            'parentCommentId': parentCommentId,
          }));

      // Print detailed error info for debugging
      if (response.statusCode != 201) {
        print("Create post failed with status: ${response.statusCode}");
        print("Response body: ${response.body}");
        return false;
      }

      if (response.statusCode == 201) {
        try {
          final data = json.decode(response.body);
          final comment = Comment(
              id: data["id"].toString(),
              postId: postId,
              content: content,
              createdAt: _parseDateTime(data["createdAt"]),
              user: User(
                  id: data["user"]["id"].toString(),
                  username: data["user"]["username"],
                  email: data["user"]["email"],
                  description: data["user"]["description"],
                  profilePicUrl: data["user"]["profilePicUrl"],
                  gamePoints: data["user"]["gamePoints"],
                  createdAt: _parseDateTime(data["user"]["createdAt"]),
                  updatedAt: _parseDateTime(data["user"]["updatedAt"])),
              replies: []);

          // Step 1: Update comment state
          if (state.hasValue) {
            final currentComments = state.value ?? [];
            if (parentCommentId == null) {
              state = AsyncData([...currentComments, comment]);
            } else {
              state = AsyncData(_addReplyToComment(
                  currentComments, parentCommentId, comment));
            }
          }

          // Step 2: Update post comment counts BEFORE invalidating self
          if (isSharingPost) {
            // Update sharing posts
            ref
                .read(postServiceProvider(PostApiType.sharing, "all").notifier)
                .updatePostCommentCount(postId, 1);
            ref
                .read(postServiceProvider(PostApiType.sharing, destinationId)
                    .notifier)
                .updatePostCommentCount(postId, 1);
          } else {
            // Update discussion posts
            ref
                .read(
                    postServiceProvider(PostApiType.discussion, "all").notifier)
                .updatePostCommentCount(postId, 1);
            ref
                .read(postServiceProvider(PostApiType.discussion, destinationId)
                    .notifier)
                .updatePostCommentCount(postId, 1);
          }

          // Step 3: Now safe to invalidate after all ref operations are complete
          ref.invalidateSelf();

          return true;
        } catch (e) {
          print("Error processing create post response: $e");
          return false;
        }
      } else {
        print('Failed to create comment. Status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Network error: ${e.toString()}');
      return false;
    }
  }

  List<Comment> _addReplyToComment(
      List<Comment> comments, String parentCommentId, Comment newReply) {
    return comments.map((comment) {
      if (comment.id == parentCommentId) {
        return comment.copyWith(replies: [...comment.replies, newReply]);
      } else if (comment.replies.isNotEmpty) {
        return comment.copyWith(
            replies:
                _addReplyToComment(comment.replies, parentCommentId, newReply));
      }
      return comment;
    }).toList();
  }
}
