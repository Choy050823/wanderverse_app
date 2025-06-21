import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderverse_app/providers/models.dart';
import 'package:wanderverse_app/providers/post-sharing/likeService.dart';
import 'package:wanderverse_app/providers/post-sharing/postService.dart';
import 'package:wanderverse_app/screens/post-sharing/SpecificPostScreen.dart';
import 'package:wanderverse_app/utils/constants.dart';

class PostCard extends ConsumerStatefulWidget {
  final String destination;
  // final int initialLikes;
  // final String imageUrl;
  // final String profilePicUrl;
  // final String caption;
  final Post post;

  const PostCard({
    super.key,
    required this.post,
    required this.destination,
    // required this.initialLikes,
    // required this.imageUrl,
    // required this.profilePicUrl,
    // required this.caption,
  });

  @override
  ConsumerState<PostCard> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<PostCard> {
  @override
  void initState() {
    super.initState();
    // Initialize the like service with the post's like count
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(likeServiceProvider(int.parse(widget.post.id)).notifier)
          .initWithPostData(widget.post.likesCount);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final updatedLikesCount = ref
        .watch(sharingPostsProvider)
        .posts
        .where((post) => post.id == widget.post.id)
        .first
        .likesCount;

    // Just watch the provider, no additional parameters
    final likeDataAsync =
        ref.watch(likeServiceProvider(int.parse(widget.post.id)));

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SpecificPostScreen(post: widget.post),
          )),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                          widget.post.creator.profilePicUrl == null ||
                                  widget.post.creator.profilePicUrl == ""
                              ? defaultProfilePic
                              : widget.post.creator.profilePicUrl!),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post.creator.username,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            widget.destination,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.7),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                if (widget.post.imageUrls.isNotEmpty)
                  Image.network(
                    widget.post.imageUrls[0],
                    width: MediaQuery.of(context).size.width / 100 * 80,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        width: MediaQuery.of(context).size.width / 100 * 80,
                        height: MediaQuery.of(context).size.width / 100 * 80,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width / 100 * 80,
                        height: MediaQuery.of(context).size.width / 100 * 80,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, color: theme.colorScheme.error),
                              Text(
                                'Error Loading Image!',
                                style:
                                    TextStyle(color: theme.colorScheme.error),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(
                    widget.post.title,
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          // Like button
                          likeDataAsync.when(
                            data: (likeData) => IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                // Simply toggle like
                                ref
                                    .read(likeServiceProvider(
                                            int.parse(widget.post.id))
                                        .notifier)
                                    .toggleLike(widget.post.id);
                              },
                              icon: likeData.isLiked
                                  ? Icon(
                                      Icons.favorite,
                                      color: theme.colorScheme.error,
                                    )
                                  : Icon(
                                      Icons.favorite_border,
                                      color: theme.colorScheme.onSurface,
                                    ),
                            ),
                            loading: () => const CircularProgressIndicator(),
                            error: (error, _) => Icon(
                              Icons.favorite_border,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(width: 2),

                          // Like count
                          Text(
                            updatedLikesCount.toString(),
                            style: theme.textTheme.bodyMedium,
                          ),
                          // likeDataAsync.when(
                          //   data: (likeData) => Text(
                          //     likeData.likesCount.toString(),
                          //     style: theme.textTheme.bodyMedium,
                          //   ),
                          //   loading: () =>
                          //       Text("...", style: theme.textTheme.bodyMedium),
                          //   error: (_, __) =>
                          //       Text("0", style: theme.textTheme.bodyMedium),
                          // ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          IconButton(
                            // padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                            onPressed: () {},
                            icon: Icon(
                              Icons.comment_outlined,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            widget.post.commentsCount.toString(),
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        onPressed: () {},
                        icon: Icon(
                          Icons.bookmark_outline,
                          color: theme.colorScheme.onSurface,
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
    );
  }
}
