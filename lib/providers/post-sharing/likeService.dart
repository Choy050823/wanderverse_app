// ignore_for_file: avoid_print

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderverse_app/providers/authentication/authService.dart';
import 'package:wanderverse_app/providers/post-sharing/postService.dart';
import 'package:wanderverse_app/utils/env.dart';
import 'package:http/http.dart' as http;

part 'likeService.g.dart';
part 'likeService.freezed.dart';

final _baseUrl = environment['api_url'];

@freezed
class PostLikeData with _$PostLikeData {
  const factory PostLikeData({
    @Default(false) bool isLiked,
    @Default(0) int likesCount,
  }) = _PostLikeData;
}

@Riverpod(keepAlive: true)
class LikeService extends _$LikeService {
  // Use a global cache to share like state
  static final Map<String, PostLikeData> _globalLikeCache = {};

  @override
  Future<PostLikeData> build(int postId) async {
    // Check if we have this in the global cache
    final cacheKey = postId.toString();
    if (_globalLikeCache.containsKey(cacheKey)) {
      return _globalLikeCache[cacheKey]!;
    }

    // Otherwise, only check if the user liked the post
    // Don't fetch like count as it will come from the post data
    final isLiked = await checkUserLikedPost(postId);

    // Create a default instance with only isLiked set
    // likesCount will be set by initWithPostData when posts are loaded
    final data = PostLikeData(isLiked: isLiked, likesCount: 0);
    _globalLikeCache[cacheKey] = data;

    return data;
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

  // void updateLikesCount(int newLikesCount) {
  //   final currentData =
  //       state.valueOrNull ?? PostLikeData(isLiked: false, likesCount: 0);

  //   state = AsyncValue.data(PostLikeData(
  //       isLiked: currentData.isLiked,
  //       likesCount: newLikesCount >= 0 ? newLikesCount : 0));
  // }

  Future<bool> checkUserLikedPost(int postId) async {
    try {
      final userId = ref.read(authServiceProvider).userData['id'];
      final url = Uri.parse('$_baseUrl/api/like?postId=$postId&userId=$userId');
      final response = await http.get(url, headers: await _headers);

      if (response.statusCode == 200) {
        return bool.parse(response.body);
      } else {
        return false;
      }
    } catch (e) {
      print("Error checking like status: ${e.toString()}");
      return false;
    }
  }

  // Remove fetchLikeCount since we'll use the count from posts

  Future<void> toggleLike(String postId, String destinationId) async {
    try {
      // Get current state from cache
      final cacheKey = postId;
      final currentData = _globalLikeCache[cacheKey] ??
          const PostLikeData(isLiked: false, likesCount: 0);

      // Update state optimistically
      final newIsLiked = !currentData.isLiked;
      final newCount =
          newIsLiked ? currentData.likesCount + 1 : currentData.likesCount - 1;

      // Update cache AND state
      final newData = PostLikeData(isLiked: newIsLiked, likesCount: newCount);
      _globalLikeCache[cacheKey] = newData;
      state = AsyncData(newData);

      // Make API call
      final userId = ref.read(authServiceProvider).userData['id'];
      final url = Uri.parse('$_baseUrl/api/like?postId=$postId&userId=$userId');

      final response = newIsLiked
          ? await http.post(url, headers: await _headers)
          : await http.delete(url, headers: await _headers);

      // Handle API error
      if (response.statusCode != 200 && response.statusCode != 201) {
        // Revert on error
        _globalLikeCache[cacheKey] = currentData;
        state = AsyncData(currentData);
        throw Exception(
            'Failed to toggle like. Status: ${response.statusCode}');
      }

      // After successful API call, update ALL post instances with this ID
      if (response.statusCode == 200 || response.statusCode == 201) {
        final delta = newIsLiked ? 1 : -1;

        // Update "all" providers
        _updatePostProvider(PostApiType.sharing, "all", postId, delta);
        _updatePostProvider(PostApiType.discussion, "all", postId, delta);

        // Update destination-specific provider
        if (destinationId.isNotEmpty) {
          _updatePostProvider(
              PostApiType.sharing, destinationId, postId, delta);
          _updatePostProvider(
              PostApiType.discussion, destinationId, postId, delta);
        }

        // Update other possible destination providers (from main.dart we see there are 21)
        for (int i = 1; i <= 21; i++) {
          final destId = i.toString();
          if (destId != destinationId) {
            // Skip the one we already updated
            _updatePostProvider(PostApiType.sharing, destId, postId, delta);
            _updatePostProvider(PostApiType.discussion, destId, postId, delta);
          }
        }
      }
    } catch (e) {
      print('Network error: ${e.toString()}');
      rethrow;
    }
  }

  // Helper method to safely update post providers
  void _updatePostProvider(
      PostApiType type, String destId, String postId, int delta) {
    try {
      final posts = ref.read(postServiceProvider(type, destId)).posts;
      final hasPost = posts.any((p) => p.id == postId);

      if (hasPost) {
        ref
            .read(postServiceProvider(type, destId).notifier)
            .updatePostLikeCount(postId, delta);
      }
    } catch (e) {
      // Ignore errors - just means this provider instance doesn't exist yet
    }
  }

  // Improved initWithPostData that updates both cache and state
  void initWithPostData(int likesCount) {
    final cacheKey = postId.toString();

    // Get current data if it exists
    final currentData = _globalLikeCache[cacheKey];

    if (currentData != null) {
      // If we already have data, just update the like count
      if (currentData.likesCount != likesCount) {
        final updatedData =
            PostLikeData(isLiked: currentData.isLiked, likesCount: likesCount);
        _globalLikeCache[cacheKey] = updatedData;

        // Update state if it's already loaded
        if (state.hasValue) {
          state = AsyncData(updatedData);
        }
      }
    } else {
      // If no data exists yet, create new entry with default isLiked
      final newData = PostLikeData(isLiked: false, likesCount: likesCount);
      _globalLikeCache[cacheKey] = newData;

      // Don't set state here as build() will be called to fetch isLiked
    }
  }
}
