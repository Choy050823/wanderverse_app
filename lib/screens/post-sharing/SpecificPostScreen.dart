import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderverse_app/providers/authentication/authService.dart';
import 'package:wanderverse_app/providers/models.dart';
import 'package:wanderverse_app/providers/post-sharing/commentService.dart';
import 'package:wanderverse_app/providers/post-sharing/userService.dart';
import 'package:wanderverse_app/utils/constants.dart';
import 'package:wanderverse_app/utils/widgets/CommentInput.dart';
import 'package:wanderverse_app/utils/widgets/CommentItem.dart';
import 'package:wanderverse_app/utils/widgets/postDetails.dart';

class SpecificPostScreen extends ConsumerStatefulWidget {
  final Post post;
  const SpecificPostScreen({required this.post, super.key});

  @override
  ConsumerState<SpecificPostScreen> createState() => _SpecificPostScreenState();
}

class _SpecificPostScreenState extends ConsumerState<SpecificPostScreen> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final commentsAsync =
        ref.watch(commentServiceProvider(int.parse(widget.post.id)));

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
                      widget.post.creator.profilePicUrl == null ||
                              widget.post.creator.profilePicUrl == ""
                          ? defaultProfilePic
                          : widget.post.creator.profilePicUrl!),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.title,
                      style: textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      widget.post.creator.username,
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
        body: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Left: Discussion
          Expanded(
              flex: 6,
              child: CustomScrollView(
                slivers: [
                  // Main Post
                  SliverToBoxAdapter(
                    child: PostDetails(post: widget.post),
                  ),

                  // Comments (mobile)
                  if (MediaQuery.of(context).size.width <= 800) ...[
                    // Comment Input
                    SliverToBoxAdapter(
                      // should change to current user avatar
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CommentInput(
                          userProfilePic:
                              ref.watch(authServiceProvider).userData.isEmpty ||
                                      ref
                                              .watch(authServiceProvider)
                                              .userData["profilePicUrl"] ==
                                          ""
                                  ? defaultProfilePic
                                  : ref
                                      .watch(authServiceProvider)
                                      .userData["profilePicUrl"],
                          postId: widget.post.id,
                          destinationId: widget.post.destination.id,
                        ),
                      ),
                    ),
                    commentsAsync.when(
                      data: (comments) => SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                        print(
                            "Comment User profile pic: ${comments[index].user.profilePicUrl}");
                        return CommentItem(
                          comment: comments[index],
                          creatorId: widget.post.creator.id,
                          depth: 0,
                          destinationId: widget.post.destination.id,
                        );
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
                  ]
                ],
              )),

          // Right Side Bar for comments
          if (MediaQuery.of(context).size.width > 800) ...[
            Expanded(
                flex: 4,
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    // should change currentDestination to support provider
                    child: CustomScrollView(
                      slivers: [
                        // Comment Input
                        SliverToBoxAdapter(
                          // should change to current user avatar
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CommentInput(
                              userProfilePic:
                                  ref.watch(userServiceProvider).user == null
                                      ? defaultProfilePic
                                      : ref
                                          .watch(userServiceProvider)
                                          .user!
                                          .profilePicUrl,
                              postId: widget.post.id,
                              destinationId: widget.post.destination.id,
                            ),
                          ),
                        ),
                        commentsAsync.when(
                          data: (comments) => SliverList(
                              delegate:
                                  SliverChildBuilderDelegate((context, index) {
                            return CommentItem(
                              comment: comments[index],
                              creatorId: widget.post.creator.id,
                              depth: 0,
                              destinationId: widget.post.destination.id,
                            );
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
                      ],
                    )))
          ],
        ]));
  }
}
