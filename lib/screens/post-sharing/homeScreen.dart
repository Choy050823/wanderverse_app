import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:wanderverse_app/providers/models.dart';
import 'package:wanderverse_app/providers/post-sharing/postService.dart';
import 'package:wanderverse_app/providers/post-sharing/userService.dart';
import 'package:wanderverse_app/router/ResponsiveLayout.dart';
import 'package:wanderverse_app/utils/env.dart';
import 'package:wanderverse_app/utils/widgets/postCard.dart';

// New provider for fetching recommended posts
final recommendedPostsProvider = FutureProvider.autoDispose<List<Post>>((ref) {
  final postService = ref.read(
    postServiceProvider(PostApiType.sharing, "all").notifier,
  );
  return postService.getRecommendedPosts();
});

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;
  final sharingPostsProvider = postServiceProvider(PostApiType.sharing, "all");
  final TextEditingController _searchController = TextEditingController();
  final _baseUrl = environment['api_url'];

  // Add these variables to _HomeScreenState class
  bool _isSearching = false;
  List<Post>? _searchResults;
  bool _searchLoading = false;

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
    _searchController.dispose();
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

  void _performSearch() async {
    final query = _searchController.text.trim();
    print("🔍 Search triggered with query: '$query'");

    if (query.isEmpty) {
      print("🔍 Empty query - clearing search");
      setState(() {
        _isSearching = false;
        _searchResults = null;
      });
      return;
    }

    // Set loading state
    setState(() {
      _isSearching = true;
      _searchLoading = true;
    });

    try {
      print("🔍 Calling postService.getSearchPosts with query: '$query'");
      // Call the search method from postService
      final results = await ref
          .read(postServiceProvider(PostApiType.sharing, "all").notifier)
          .getSearchPosts(query);

      print("🔍 Search completed, got ${results.length} results");

      // Update state with results
      setState(() {
        _searchResults = results;
        _searchLoading = false;
      });
    } catch (e) {
      print("🔍 Search error: $e");
      // Handle errors
      setState(() {
        _searchResults = [];
        _searchLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Search error: $e')));
    }
  }

  // Add method to clear search
  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _isSearching = false;
      _searchResults = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch the state for "All" posts
    final allPostsState = ref.watch(sharingPostsProvider);
    // Watch the async value for "Recommended" posts
    final recommendedPostsAsync = ref.watch(recommendedPostsProvider);

    final isMobile = ResponsiveLayout.isMobile(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // Search Bar with clear button when searching
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search posts...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: _clearSearch,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              contentPadding: EdgeInsets.zero,
              fillColor: Theme.of(context).colorScheme.surface,
            ),
            onSubmitted: (_) => _performSearch(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: _performSearch,
            ),
          ],
          // Only show tabs when not in search mode
          bottom: _isSearching
              ? null
              : const TabBar(
                  tabs: [
                    Tab(text: 'All'),
                    Tab(text: 'Recommended'),
                  ],
                ),
        ),
        body: _isSearching
            // Show search results when searching
            ? _buildSearchResultsView()
            // Otherwise show normal tab view
            : TabBarView(
                children: [
                  // "All" tab view
                  _buildAllPostsView(allPostsState, isMobile),
                  // "Recommended" tab view
                  _buildRecommendedPostsView(recommendedPostsAsync),
                ],
              ),
      ),
    );
  }

  // Renamed from _buildPostListView for clarity
  Widget _buildAllPostsView(PostsState postState, bool isMobile) {
    final posts = List<Post>.from(postState.posts);
    final isLoading = postState.isLoading;
    final hasError = postState.errorMessage != null;
    final itemCount = posts.length + (postState.hasMore ? 1 : 0);

    if (posts.isEmpty && !isLoading) {
      return _buildEmptyView(hasError, postState.errorMessage);
    }

    // Your existing responsive grid/list logic for "All" posts is great.
    // No major changes needed here.
    return RefreshIndicator(
      onRefresh: () => ref.read(sharingPostsProvider.notifier).refreshPosts(),
      child: isMobile
          ? ListView.builder(
              controller: _scrollController,
              itemCount: itemCount,
              padding: const EdgeInsets.all(8.0),
              itemBuilder: (context, index) {
                if (index >= posts.length) {
                  return isLoading
                      ? _buildLoadingIndicator()
                      : _buildNoMorePostsIndicator();
                }
                return PostCard(post: posts[index]);
              },
            )
          : MasonryGridView.count(
              controller: _scrollController,
              itemCount: itemCount,
              crossAxisCount: 3,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              padding: const EdgeInsets.all(8.0),
              itemBuilder: (context, index) {
                if (index >= posts.length) {
                  return isLoading
                      ? _buildLoadingIndicator()
                      : _buildNoMorePostsIndicator();
                }
                return PostCard(post: posts[index]);
              },
            ),
    );
  }

  // New method to build the "Recommended" tab view with MasonryGridView support
  Widget _buildRecommendedPostsView(
    AsyncValue<List<Post>> recommendedPostsAsync,
  ) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return recommendedPostsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (posts) {
        if (posts.isEmpty) {
          return _buildEmptyView(
            false,
            "No recommended posts found.\nLike some posts to get recommendations!",
          );
        }

        // Use same refresh indicator for both layouts
        return RefreshIndicator(
          onRefresh: () => ref.refresh(recommendedPostsProvider.future),
          // Now use the same responsive layout logic as All Posts
          child: isMobile
              ? ListView.builder(
                  key: const PageStorageKey('recommended_list'),
                  itemCount: posts.length,
                  padding: const EdgeInsets.all(8.0),
                  itemBuilder: (context, index) {
                    return PostCard(post: posts[index]);
                  },
                )
              : MasonryGridView.count(
                  key: const PageStorageKey('recommended_grid'),
                  itemCount: posts.length,
                  crossAxisCount: 3,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  padding: const EdgeInsets.all(8.0),
                  itemBuilder: (context, index) {
                    return PostCard(post: posts[index]);
                  },
                ),
        );
      },
    );
  }

  Widget _buildSearchResultsView() {
    final isMobile = ResponsiveLayout.isMobile(context);

    if (_searchLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_searchResults == null || _searchResults!.isEmpty) {
      return _buildEmptyView(
        false,
        "No posts match your search.\nTry different keywords.",
      );
    }

    // Use same layout logic as other views for consistency
    return isMobile
        ? ListView.builder(
            key: const PageStorageKey('search_results_list'),
            itemCount: _searchResults!.length,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (context, index) {
              return PostCard(post: _searchResults![index]);
            },
          )
        : MasonryGridView.count(
            key: const PageStorageKey('search_results_grid'),
            itemCount: _searchResults!.length,
            crossAxisCount: 3,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (context, index) {
              return PostCard(post: _searchResults![index]);
            },
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
            const SizedBox(height: 16),
            Text(
              errorMessage ?? "Unexpected error occurred",
              style: TextStyle(color: Theme.of(context).colorScheme.error),
              textAlign: TextAlign.center,
            ),
          ] else ...[
            const Icon(
              Icons.photo_album_outlined,
              color: Colors.grey,
              size: 60,
            ),
            const SizedBox(height: 16),
            const Text(
              "No post found\nPull down to refresh.\nIf you are in recommended section, you need to like a post first and refresh",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
          ],
          const SizedBox(height: 24),
          // ElevatedButton(
          //   onPressed: () {
          //     ref.read(sharingPostsProvider.notifier).refreshPosts();
          //     ref.read(sharingPostsProvider.notifier).getRecommendedPosts();
          //   },
          //   child: const Text("Refresh Post"),
          // ),
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
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 12),
            Text(
              "Loading more posts...",
              style: Theme.of(context).textTheme.bodySmall,
            ),
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
