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

@riverpod
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

  Future<bool> createComment(String postId, String content,
      {String? parentCommentId}) async {
    // state = state.copyWith(isLoading: true, errorMessage: null);

    // create comment
    try {
      print(
          "DEBUG: User data from auth: ${ref.read(authServiceProvider).userData}");
      final userId = ref.read(authServiceProvider).userData['id'];
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
        print("Request payload: ${jsonEncode({
              'postId': postId,
              'content': content,
              'userId': userId,
              'parentCommentId': parentCommentId,
            })}");
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

          // Optimistic Update for state
          if (state.hasValue) {
            final currentComments = state.value ?? [];
            if (parentCommentId == null) {
              // top level comments
              state = AsyncData([...currentComments, comment]);
            } else {
              // add replies
              state = AsyncData(_addReplyToComment(
                  currentComments, parentCommentId, comment));
            }
          }

          ref.invalidateSelf();
          
          final sharingPost = ref
              .watch(sharingPostsProvider)
              .posts
              .where((post) => post.id == postId)
              .firstOrNull;

          sharingPost != null
              ? ref
                  .read(sharingPostsProvider.notifier)
                  .updatePostCommentCount(postId, 1)
              : ref
                  .read(discussionPostsProvider.notifier)
                  .updatePostCommentCount(postId, 1);

          print("DEBUG: Successfully created comment: ${comment.toString()}");
          return true;
        } catch (e) {
          print("Error processing create post response: $e");
          // _handleError('Failed to process server response');
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
