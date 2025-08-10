import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderverse_app/providers/post-sharing/postService.dart';
import 'package:wanderverse_app/providers/post-sharing/userService.dart';
import 'package:wanderverse_app/screens/discussion/SpecificDiscussionScreen.dart';
import 'package:wanderverse_app/utils/constants.dart';
import 'package:wanderverse_app/utils/widgets/DiscussionCard.dart';
import 'package:wanderverse_app/utils/widgets/postCard.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Move the user fetching to initState - a safe place to fetch data
    Future.microtask(() {
      ref.read(userServiceProvider.notifier).getCurrentUser();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get current user state
    final userState = ref.watch(userServiceProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Just check if user is loaded yet, but DON'T call getCurrentUser() here
    if (userState.user == null) {
      // Just show loading state
      return Scaffold(
        appBar: AppBar(title: const Text("Profile")),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Now we can safely use the user
    final currentUser = userState.user!;

    final sharingPosts = ref
        .watch(postServiceProvider(PostApiType.sharing, "all"))
        .posts
        .where((post) => post.creator.id == currentUser.id)
        .toList();

    final discussionPosts = ref
        .watch(postServiceProvider(PostApiType.discussion, "all"))
        .posts
        .where((post) => post.creator.id == currentUser.id)
        .toList();

    final totalPosts = sharingPosts.length + discussionPosts.length;

    return Scaffold(
        // appBar: AppBar(
        //   title: Text("${currentUser.username}'s Profile"),
        //   elevation: 0,
        // ),
        body: NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile header with avatar and stats
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile picture
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                            currentUser.profilePicUrl == null ||
                                    currentUser.profilePicUrl == ""
                                ? defaultProfilePic
                                : currentUser.profilePicUrl!),
                      ),
                      const SizedBox(width: 16),

                      // User info column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Username and edit button row
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    currentUser.username,
                                    style: textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // const SizedBox(width: 8),
                                // OutlinedButton(
                                //   onPressed: () {
                                //     // Navigate to edit profile
                                //   },
                                //   style: OutlinedButton.styleFrom(
                                //     foregroundColor: colorScheme.primary,
                                //     backgroundColor: colorScheme.secondary,
                                //     side: BorderSide(
                                //         color: colorScheme.primary, width: 1.5),
                                //     padding: const EdgeInsets.symmetric(
                                //         horizontal: 16, vertical: 12),
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(8.0),
                                //     ),
                                //   ),
                                //   child: Text(
                                //     "Edit Profile",
                                //     style: textTheme.labelLarge?.copyWith(
                                //       fontWeight: FontWeight.w600,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Stats row
                            Row(
                              children: [
                                // Posts count
                                Column(
                                  children: [
                                    Text(
                                      totalPosts.toString(),
                                      style: textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Posts",
                                      style: textTheme.bodySmall?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 24),

                                // Game points with icon
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.stars,
                                          size: 16,
                                          color: colorScheme.tertiary,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          currentUser.gamePoints.toString(),
                                          style:
                                              textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Game Points",
                                      style: textTheme.bodySmall?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Bio/Description
                  if (currentUser.description != null &&
                      currentUser.description!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(
                      currentUser.description!,
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Tab bar
          SliverPersistentHeader(
            delegate: _SliverTabBarDelegate(
              TabBar(
                controller: _tabController,
                indicatorColor: colorScheme.primary,
                indicatorWeight: 3,
                labelColor: colorScheme.primary,
                unselectedLabelColor: colorScheme.onSurfaceVariant,
                tabs: const [
                  Tab(text: "Sharing"),
                  Tab(text: "Discussions"),
                ],
              ),
              colorScheme.surface,
            ),
            pinned: true,
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: Sharing Posts
          sharingPosts.isEmpty
              ? _buildEmptyState("No sharing posts yet",
                  "Share your travel moments with others")
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: sharingPosts.length,
                  itemBuilder: (context, index) {
                    return PostCard(
                      post: sharingPosts[index],
                      // destination: sharingPosts[index].destination.name,
                    );
                  },
                ),

          // Tab 2: Discussion Posts
          discussionPosts.isEmpty
              ? _buildEmptyState("No discussion posts yet",
                  "Start a conversation about your travels")
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: discussionPosts.length,
                  itemBuilder: (context, index) {
                    return DiscussionCard(
                      post: discussionPosts[index],
                      index: index,
                      screen: SpecificDiscussionScreen(
                        destination: discussionPosts[index].destination,
                        discussionPost: discussionPosts[index],
                      ),
                    );
                  },
                ),
        ],
      ),
    ));
  }

  Widget _buildEmptyState(String title, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.post_add_outlined,
            size: 64,
            color:
                Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      .withOpacity(0.7),
                ),
          ),
        ],
      ),
    );
  }
}

// Tab bar delegate for sticky tabs
class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color backgroundColor;

  _SliverTabBarDelegate(this.tabBar, this.backgroundColor);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}
