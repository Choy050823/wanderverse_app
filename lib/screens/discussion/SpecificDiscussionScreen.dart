// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderverse_app/providers/models.dart';
import 'package:wanderverse_app/providers/post-sharing/commentService.dart';
import 'package:wanderverse_app/providers/post-sharing/userService.dart';
import 'package:wanderverse_app/utils/constants.dart';
import 'package:wanderverse_app/utils/widgets/CommentInput.dart';
import 'package:wanderverse_app/utils/widgets/CommentItem.dart';
import 'package:wanderverse_app/utils/widgets/DiscussionSidebar.dart';
import 'package:wanderverse_app/utils/widgets/postDetails.dart';

// class Comment {
//   final int id;
//   final String username;
//   final String userAvatar;
//   final String content;
//   final String timeAgo;
//   final int votes;
//   final List<Comment> replies; // Recursive structure for nested comments
//   final bool isOP;

//   Comment({
//     required this.id,
//     required this.username,
//     required this.userAvatar,
//     required this.content,
//     required this.timeAgo,
//     required this.votes,
//     required this.replies,
//     this.isOP = false,
//   });
// }

class SpecificDiscussionScreen extends ConsumerStatefulWidget {
  final Post discussionPost;

  const SpecificDiscussionScreen({required this.discussionPost, super.key});

  @override
  ConsumerState<SpecificDiscussionScreen> createState() =>
      _SpecificDiscussionScreenState();
}

class _SpecificDiscussionScreenState
    extends ConsumerState<SpecificDiscussionScreen> {
  final TextEditingController _commentController = TextEditingController();

  // late Post discussionPost;
  // List<Comment> comments = [];
  String _sortBy = "Best";

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  // Future<void> _fetchDiscussionAndComments() async {
  //   // do some API fetching...

  //   // Mock data
  //   _discussionPost = const DiscussionPost(
  //     id: 1,
  //     username: "NoStudy366",
  //     title: "Zanzibar v. Cape Town v. Johannesburg",
  //     description:
  //         "My wife and I are planning a trip to Africa from the US this December and are seeking advice on the best way to finish the trip. We are starting off the trip with a 2 day gorilla trek in Rwanda, immediately followed by a 5 day safari in Tanzania.\n\nOriginally, we were planning on going to Zanzibar for 4 days, then finishing with 4 days in Johannesburg, where we will fly back to the US from. However, we are reconsidering this section of the itinerary after wanting to do shark diving in Cape Town / hearing great things about Cape Town.\n\nWe have 8 days after the safari in Tanzania to spend, and to avoid too much moving around, prefer to pick 2/3 between Zanzibar, Cape Town, and Johannesburg. We have to fly out of Johannesburg at the end of the trip, but don't mind tacking that on at the end if we choose to spend the time in Zanzibar and Cape Town.\n\nI think Zanzibar would be an awesome way to relax after the trekking + safari, but my wife thinks it's \"just another pretty beach you can get in a lot of other Caribbean locations\" and thinks we should bias towards CT and J-burg. Additionally, we aren't sure the best way to optimize the itinerary based on inter-country flights between the three destinations (another reason why we'd prefer to do 2/3).\n\nAny advice on which destinations we should really prioritize here?",
  //     imageUrl: null,
  //     timeAgo: "9 hr. ago",
  //     votes: 17,
  //     commentsCount: 42,
  //     category: "Question",
  //   );

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final commentsAsync =
        ref.watch(commentServiceProvider(int.parse(widget.discussionPost.id)));

    // List<Comment> comments = [
    //   Comment(
    //     id: 1,
    //     username: "Afireinside11",
    //     userAvatar:
    //         "https://plus.unsplash.com/premium_photo-1665203415837-a3b389a6b33e?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8dHJhdmVsbGVyfGVufDB8fDB8fHww",
    //     content:
    //         "Dude, do Cape Town. Trust me. It's incredible. Between that, safari in TZ, and the gorillas, you and your wife are in for a trip of a lifetime.",
    //     timeAgo: "9h ago",
    //     votes: 40,
    //     replies: [
    //       Comment(
    //         id: 2,
    //         username: "NoStudy366",
    //         userAvatar:
    //             "https://plus.unsplash.com/premium_photo-1665203415837-a3b389a6b33e?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8dHJhdmVsbGVyfGVufDB8fDB8fHww",
    //         content:
    //             "We are so excited! Sounds like Cape Town is definitely the move here",
    //         timeAgo: "9h ago",
    //         votes: 6,
    //         replies: [
    //           Comment(
    //             id: 2,
    //             username: "NoStudy366",
    //             userAvatar:
    //                 "https://plus.unsplash.com/premium_photo-1665203415837-a3b389a6b33e?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8dHJhdmVsbGVyfGVufDB8fDB8fHww",
    //             content:
    //                 "We are so excited! Sounds like Cape Town is definitely the move here",
    //             timeAgo: "9h ago",
    //             votes: 6,
    //             replies: [],
    //             isOP: true,
    //           ),
    //           Comment(
    //             id: 2,
    //             username: "NoStudy366",
    //             userAvatar:
    //                 "https://plus.unsplash.com/premium_photo-1665203415837-a3b389a6b33e?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8dHJhdmVsbGVyfGVufDB8fDB8fHww",
    //             content:
    //                 "We are so excited! Sounds like Cape Town is definitely the move here",
    //             timeAgo: "9h ago",
    //             votes: 6,
    //             replies: [],
    //             isOP: true,
    //           ),
    //         ],
    //         isOP: true,
    //       ),
    //       Comment(
    //         id: 2,
    //         username: "NoStudy366",
    //         userAvatar:
    //             "https://plus.unsplash.com/premium_photo-1665203415837-a3b389a6b33e?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8dHJhdmVsbGVyfGVufDB8fDB8fHww",
    //         content:
    //             "We are so excited! Sounds like Cape Town is definitely the move here",
    //         timeAgo: "9h ago",
    //         votes: 6,
    //         replies: [],
    //         isOP: true,
    //       ),
    //     ],
    //   ),
    //   Comment(
    //     id: 3,
    //     username: "george_gamow",
    //     userAvatar:
    //         "https://plus.unsplash.com/premium_photo-1665203415837-a3b389a6b33e?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8dHJhdmVsbGVyfGVufDB8fDB8fHww",
    //     content:
    //         "Cape Town is beautiful. Don't do Johannesburg, it's cool if you want to see apartheid museums, but it's not walkable (especially CBD) at all and you'd have to keep to tourist areas, which is annoying and not the case in Cape Town",
    //     timeAgo: "9h ago",
    //     votes: 30,
    //     replies: [],
    //   ),
    //   Comment(
    //     id: 4,
    //     username: "Cheeseoholics",
    //     userAvatar: "https://ui-avatars.com/api/?name=C&background=708090",
    //     content:
    //         "Shark diving is pointless. There haven't been any sharks (whites) in a long time due to, amongst other things, orcas. I wish I'd know that before I wasted my money.\n\nCape Town was a great little city.\n\nZanzibar was something else. Loved Stone Town and then a beach resort.",
    //     timeAgo: "9h ago",
    //     votes: 15,
    //     replies: [],
    //   ),
    // ];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.surface,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              color: colorScheme.onSurface,
            ),
          ),
          title: InkWell(
            onTap: () {
              // Navigate back (pop)
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(
                      widget.discussionPost.creator.profilePicUrl == null ||
                              widget.discussionPost.creator.profilePicUrl == ""
                          ? defaultProfilePic
                          : widget.discussionPost.creator.profilePicUrl!),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.discussionPost.title,
                      style: textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      widget.discussionPost.creator.username,
                      style: textTheme.labelMedium,
                    )
                  ],
                )
              ],
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  // show option menu
                },
                icon: const Icon(Icons.more_horiz))
          ],
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Discussion
            Expanded(
                flex: 7,
                child: CustomScrollView(
                  slivers: [
                    // Main Post
                    SliverToBoxAdapter(
                      child: PostDetails(post: widget.discussionPost),
                    ),

                    // Comments
                    SliverToBoxAdapter(
                      // should change to current user avatar
                      child: CommentInput(
                        userProfilePic:
                            ref.watch(userServiceProvider).user == null
                                ? defaultProfilePic
                                : ref
                                    .watch(userServiceProvider)
                                    .user!
                                    .profilePicUrl,
                        postId: widget.discussionPost.id,
                      ),
                    ),

                    // Sort
                    SliverToBoxAdapter(
                      child: _buildSortOptions(),
                    ),

                    // Comments
                    commentsAsync.when(
                      data: (comments) => SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                        return CommentItem(
                            comment: comments[index],
                            creatorId: widget.discussionPost.creator.id,
                            depth: 0);
                      }, childCount: comments.length)),
                      loading: () => const SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      error: (error, _) => SliverToBoxAdapter(
                        child: Center(
                          child: Text('Failed to load comments: $error'),
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 24,
                      ),
                    )
                  ],
                )),

            // Right Side Bar
            if (MediaQuery.of(context).size.width > 800) ...[
              // const SizedBox(
              //   width: 24,
              // ),
              if (MediaQuery.of(context).size.width > 800) ...[
                const Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        // should change currentDestination to support provider
                        child: DiscussionSidebar(
                          currentDestination: "Paris",
                        ),
                      ),
                    ))
              ],
            ]
          ],
        ));
  }

  Widget _buildSortOptions() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    var sortOptions = ["Best", "New", "Top"];
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Row(
        children: [
          // Sort dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Sort By:",
                  style: textTheme.bodySmall
                      ?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
                const SizedBox(
                  width: 8,
                ),
                DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                  isDense: true,
                  value: _sortBy,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  items: sortOptions.map((String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ));
                  }).toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        _sortBy = value;
                      });
                    }
                  },
                ))
              ],
            ),
          ),
          const Spacer(),

          // Search Comments
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
                color: colorScheme.surfaceVariant.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.search,
                  size: 16,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Search Comments",
                  style: textTheme.bodySmall
                      ?.copyWith(color: colorScheme.onSurfaceVariant),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
