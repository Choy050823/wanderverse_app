import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wanderverse_app/providers/models.dart';
import 'package:wanderverse_app/providers/post-sharing/createPostOverlayService.dart';
import 'package:wanderverse_app/providers/post-sharing/destinationService.dart';
import 'package:wanderverse_app/providers/post-sharing/postService.dart';
import 'package:wanderverse_app/router/ResponsiveLayout.dart';
import 'package:wanderverse_app/screens/discussion/SpecificDiscussionScreen.dart';
import 'package:wanderverse_app/utils/constants.dart';
import 'package:wanderverse_app/utils/widgets/DiscussionCard.dart';
import 'package:wanderverse_app/utils/widgets/DiscussionSidebar.dart';

class DiscussionScreen extends ConsumerStatefulWidget {
  const DiscussionScreen({super.key});

  @override
  ConsumerState<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends ConsumerState<DiscussionScreen>
    with SingleTickerProviderStateMixin {
  Destination? currentDestination;
  String _sortBy = "Top";
  final List<String> _sortOptions = ["Top", "New", "Hot"];
  late AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;
  TextEditingController _destinationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animationController.forward();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _animationController.dispose();
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
        ref.read(discussionPostsProvider.notifier).loadMorePosts();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final postState = ref.watch(discussionPostsProvider);
    final isLoading = postState.isLoading;
    final hasError = postState.errorMessage != null;

    final destinationAsync = ref.watch(destinationServiceProvider);
    List<Post> discussions = List<Post>.from(postState.posts)
        .where((post) =>
            currentDestination == null ||
            currentDestination!.name == "General" ||
            post.destination.id == currentDestination!.id)
        .toList();
    final theme = Theme.of(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(discussionPostsProvider.notifier).refreshPosts(),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // App Bar
            SliverAppBar(
              floating: true,
              shadowColor: Colors.amber,
              pinned: true,
              expandedHeight: 200,
              backgroundColor: colorScheme.surface,
              elevation: 0,
              iconTheme: IconThemeData(color: colorScheme.onSurface),
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                          color: colorScheme.surface.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        "Travel Discussions: ${currentDestination == null ? generalDestination.name : currentDestination!.name}",
                        style: textTheme.headlineLarge?.copyWith(
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      currentDestination == null
                          ? generalDestination.imageUrl
                          : currentDestination!.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            colorScheme.primary.withOpacity(0.8),
                          ],
                          stops: const [0.5, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    // Search Engine Function
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // filter function
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.filter_list,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),

            // Sort bar
            SliverPersistentHeader(
              delegate: _SortBarDelegate(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        // Sort dropdown
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceVariant.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Sort By:",
                                style: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant),
                              ),
                              const SizedBox(width: 8),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isDense: true,
                                  value: _sortBy,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                  items: _sortOptions.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      setState(() {
                                        _sortBy = value;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          child: destinationAsync.when(
                            data: (destinations) {
                              return Autocomplete<Destination>(
                                optionsBuilder:
                                    (TextEditingValue textEditingValue) {
                                  if (textEditingValue.text.isEmpty) {
                                    return destinations;
                                  }
                                  return destinations.where((destination) {
                                    return destination.name
                                        .toLowerCase()
                                        .contains(textEditingValue.text
                                            .toLowerCase());
                                  });
                                },
                                displayStringForOption: (destination) =>
                                    destination.name,
                                fieldViewBuilder: (context,
                                    textEditingController,
                                    focusNode,
                                    onFieldSubmitted) {
                                  _destinationController =
                                      textEditingController;
                                  return TextField(
                                    controller: textEditingController,
                                    focusNode: focusNode,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                      hintText: "Search for a destination...",
                                      prefixIcon: const Icon(Icons.search),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      fillColor: theme.colorScheme.surface,
                                      filled: true,
                                      contentPadding:
                                          ResponsiveLayout.isMobile(context)
                                              ? const EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 12)
                                              : null,
                                    ),
                                    onSubmitted: (_) => onFieldSubmitted(),
                                  );
                                },
                                onSelected: (Destination destination) {
                                  setState(() {
                                    currentDestination = destination;
                                    _destinationController.text =
                                        destination.name;
                                  });
                                  // You could also refresh posts based on new destination here
                                  // ref.read(discussionPostsProvider.notifier).refreshPostsByDestination(destination.id);
                                },
                                // Add this options view builder for rich destination display
                                optionsViewBuilder:
                                    (context, onSelected, options) {
                                  return Align(
                                    alignment: Alignment.topLeft,
                                    child: Material(
                                      elevation: 4.0,
                                      child: ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          maxHeight: 200,
                                          maxWidth: 500,
                                        ),
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemCount: options.length,
                                          itemBuilder: (context, index) {
                                            final Destination option =
                                                options.elementAt(index);
                                            return ListTile(
                                              leading: option
                                                      .imageUrl.isNotEmpty
                                                  ? CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                              option.imageUrl),
                                                    )
                                                  : const CircleAvatar(
                                                      child: Icon(
                                                          Icons.location_on),
                                                    ),
                                              title: Text(option.name),
                                              subtitle: Text(
                                                option.description,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              onTap: () => onSelected(option),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            error: (error, _) =>
                                Text("Error loading destinations: $error"),
                            loading: () => const Center(
                                child: CircularProgressIndicator()),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Location button
                        Container(
                          height: 36,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 0),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.primary.withOpacity(0.25),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 18,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                currentDestination == null
                                    ? generalDestination.name
                                    : currentDestination!.name,
                                style: GoogleFonts.notoSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Main content with discussions and sidebar
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: ResponsiveLayout.isDesktop(context)
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Discussions area - flex 7
                          Expanded(
                            flex: 7,
                            child: discussions.isEmpty && !isLoading
                                ? _buildEmptyView(
                                    hasError, postState.errorMessage)
                                : Column(
                                    children: [
                                      // List of discussion cards
                                      ...List.generate(discussions.length,
                                          (index) {
                                        return DiscussionCard(
                                          post: discussions[index],
                                          index: index,
                                          screen: SpecificDiscussionScreen(
                                            destination:
                                                discussions[index].destination,
                                            discussionPost: discussions[index],
                                          ),
                                        );
                                      }),

                                      // Loading indicator or "no more posts" message
                                      if (isLoading && postState.hasMore)
                                        _buildLoadingIndicator()
                                      else if (!isLoading && postState.hasMore)
                                        const SizedBox(height: 16)
                                      else if (!isLoading &&
                                          !postState.hasMore &&
                                          discussions.isNotEmpty)
                                        _buildNoMorePostsIndicator(),

                                      // Add extra space at bottom for FAB
                                      const SizedBox(height: 80),
                                    ],
                                  ),
                          ),

                          // Sidebar - flex 3
                          const SizedBox(width: 24),
                          Expanded(
                            flex: 3,
                            // set to destination entity
                            child: DiscussionSidebar(
                              currentDestination: currentDestination,
                            ),
                          ),
                        ],
                      )
                    : discussions.isEmpty && !isLoading
                        ? _buildEmptyView(hasError, postState.errorMessage)
                        : Column(
                            children: [
                              // List of discussion cards
                              ...List.generate(discussions.length, (index) {
                                return DiscussionCard(
                                  post: discussions[index],
                                  index: index,
                                  screen: SpecificDiscussionScreen(
                                    destination: discussions[index].destination,
                                    discussionPost: discussions[index],
                                  ),
                                );
                              }),

                              // Loading indicator or "no more posts" message
                              if (isLoading && postState.hasMore)
                                _buildLoadingIndicator()
                              else if (!isLoading && postState.hasMore)
                                const SizedBox(height: 16)
                              else if (!isLoading &&
                                  !postState.hasMore &&
                                  discussions.isNotEmpty)
                                _buildNoMorePostsIndicator(),

                              // Add extra space at bottom for FAB
                              const SizedBox(height: 80),
                            ],
                          ),
              ),
            ),

            // Add empty space at the bottom to ensure we can scroll past the content
            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).padding.bottom),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: () {
            // Navigate to create post screen
            ref.read(createPostOverlayServiceProvider.notifier).show();
          },
          elevation: 0,
          backgroundColor: Colors.transparent,
          icon: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          label: Text(
            "Post a Discussion",
            style: textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onPrimary,
            ),
          ),
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
                  ref.read(discussionPostsProvider.notifier).refreshPosts(),
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

class _SortBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SortBarDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }

  @override
  double get maxExtent => 56.0;

  @override
  double get minExtent => 56.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
