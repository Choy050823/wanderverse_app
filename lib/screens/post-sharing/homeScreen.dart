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
  // String creatorId = "choymh23";
  // String destination = "NUS";
  // int initialLikes = 123;
  // String imageUrl =
  //     "https://m.media-amazon.com/images/I/71eYCAMKcJL._AC_UF1000,1000_QL80_.jpg";
  // String profilePicUrl =
  //     "https://media.licdn.com/dms/image/v2/D5603AQHGl9U2jctJ0Q/profile-displayphoto-shrink_400_400/B56ZTJkMWIGQAo-/0/1738548496286?e=1752710400&v=beta&t=RPWykSYhW9Ek6yXupsn9QUQICrY8LUlPLG-cIk_8G6E";
  // String caption = "Japan is fun";

  // late final List<Map<String, dynamic>> posts;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // posts = List.generate(
    //   20,
    //   (index) => {
    //     'creatorId': creatorId,
    //     'destination': destination,
    //     'initialLikes': initialLikes,
    //     'imageUrl': imageUrl,
    //     'profilePicUrl': profilePicUrl,
    //     'caption': caption,
    //   },
    // );
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
        ref.read(postServiceProvider.notifier).loadMorePosts();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final postState = ref.watch(postServiceProvider);
    List<Post> posts = List<Post>.from(postState.posts);
    posts.sort((post1, post2) => post2.updatedAt.compareTo(post1.updatedAt));
    final isLoading = postState.isLoading;
    final hasError = postState.errorMessage != null;

    // item count for the grids
    final itemCount = posts.isEmpty && isLoading
        ? 1
        : posts.length + (isLoading && postState.hasMore ? 1 : 0);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.read(postServiceProvider.notifier).refreshPosts(),
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
                    creatorId: post.creatorId,
                    destination: post.destinationId,
                    initialLikes: post.likesCount,
                    imageUrl: post.imageUrls[0],
                    profilePicUrl:
                        "https://plus.unsplash.com/premium_photo-1665203415837-a3b389a6b33e?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8dHJhdmVsbGVyfGVufDB8fDB8fHww",
                    caption: post.title,
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
              style: TextStyle(color: Colors.grey),
            )
          ],
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
              onPressed: () =>
                  ref.read(postServiceProvider.notifier).refreshPosts(),
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
        style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
      ),
    );
  }
}
