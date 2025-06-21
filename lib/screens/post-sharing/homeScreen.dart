import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wanderverse_app/providers/models.dart';
import 'package:wanderverse_app/providers/post-sharing/postService.dart';
import 'package:wanderverse_app/utils/widgets/postCard.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // loads more post when reach the bottom of the grid view
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Debounce the load more call to prevent rapid calls
      if (_debounce?.isActive ?? false) _debounce?.cancel();

      _debounce = Timer(const Duration(milliseconds: 300), () {
        ref.read(sharingPostsProvider.notifier).loadMorePosts();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final postState = ref.watch(sharingPostsProvider);
    List<Post> posts = List<Post>.from(postState.posts);
    final isLoading = postState.isLoading;
    final hasError = postState.errorMessage != null;

    // item count for the grids
    final itemCount = posts.isEmpty && isLoading
        ? 1
        : posts.length + (isLoading && postState.hasMore ? 1 : 0);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.read(sharingPostsProvider.notifier).refreshPosts(),
        child: posts.isEmpty && !isLoading
            ? _buildEmptyView(hasError, postState.errorMessage)
            : MasonryGridView.count(
                controller: _scrollController,
                itemCount: itemCount,
                crossAxisCount: 3,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (context, index) {
                  // show loading indicator after running all the index
                  if (index >= posts.length) {
                    return isLoading
                        ? _buildLoadingIndicator()
                        : _buildNoMorePostsIndicator();
                  }

                  // all listed posts
                  final post = posts[index];
                  return PostCard(
                    post: post,
                    destination: post.destinationId,
                    // initialLikes: post.likesCount,
                    // imageUrl: post.imageUrls.isEmpty ? "" : post.imageUrls[0],
                    // profilePicUrl:
                    //     post.creator.profilePicUrl ?? defaultProfilePic,
                    // caption: post.title,
                  );
                },
              ),
      ),
    );
  }

  Widget _buildEmptyView(bool hasError, String? errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (hasError) ...[
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              errorMessage ?? "Unexpected error occurred",
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
              textAlign: TextAlign.center,
            )
          ] else ...[
            const Icon(
              Icons.photo_album_outlined,
              color: Colors.grey,
              size: 60,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "No post found\nPull down to refresh",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            )
          ],
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
              onPressed: () =>
                  ref.read(sharingPostsProvider.notifier).refreshPosts(),
              child: const Text("Refresh"))
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)
          ]),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              height: 12,
            ),
            Text(
              "Loading more posts...",
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNoMorePostsIndicator() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: const Text(
        "You've reached the end",
        style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
      ),
    );
  }
}
