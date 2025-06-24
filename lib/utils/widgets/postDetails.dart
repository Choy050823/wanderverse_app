import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderverse_app/providers/models.dart';
import 'package:wanderverse_app/providers/post-sharing/likeService.dart';
import 'package:wanderverse_app/providers/post-sharing/postService.dart';
import 'package:wanderverse_app/utils/constants.dart';
import 'package:wanderverse_app/utils/widgets/ActionButton.dart';
import 'package:wanderverse_app/utils/widgets/CommentButton.dart';
import 'package:wanderverse_app/utils/widgets/ImagePreview.dart';
import 'package:wanderverse_app/utils/widgets/PostCategoryChip.dart';

// // Create a provider that directly gives you the updated post by ID
// final updatedPostProvider = Provider.family<Post?, String>((ref, postId) {
//   final sharingPosts =
//       ref.watch(postServiceProvider(PostApiType.sharing, "all")).posts;
//   final discussionPosts =
//       ref.watch(postServiceProvider(PostApiType.discussion, "all")).posts;

//   // Check in both post types
//   final matchingPosts = [...sharingPosts, ...discussionPosts]
//       .where((post) => post.id == postId)
//       .toList();

//   return matchingPosts.isNotEmpty ? matchingPosts.first : null;
// });

class PostDetails extends ConsumerStatefulWidget {
  final Post post;
  const PostDetails({required this.post, super.key});

  @override
  ConsumerState<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends ConsumerState<PostDetails> {
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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final updatedPost = widget.post.postType == PostType.post
        ? ref
            .watch(postServiceProvider(
                PostApiType.sharing, widget.post.destination.id))
            .posts
            .where((post) => post.id == widget.post.id)
            .firstOrNull
        : ref
            .watch(postServiceProvider(
                PostApiType.discussion, widget.post.destination.id))
            .posts
            .where((post) => post.id == widget.post.id)
            .firstOrNull;
    final updatedCommentCount =
        updatedPost == null ? 0 : updatedPost.commentsCount;

    // Watch the like data provider without any additional parameters
    final likeDataAsync =
        ref.watch(likeServiceProvider(int.parse(widget.post.id)));

    return Card(
        margin: const EdgeInsets.all(16),
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
                color: colorScheme.outline.withOpacity(0.2), width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post header
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage(
                            widget.post.creator.profilePicUrl == null ||
                                    widget.post.creator.profilePicUrl == ""
                                ? defaultProfilePic
                                : widget.post.creator.profilePicUrl!),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        widget.post.creator.username,
                        style: textTheme.titleMedium
                            ?.copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                      const Spacer(),
                      PostCategoryChip(postType: widget.post.postType)
                    ],
                  ),
                  const Divider(),

                  const SizedBox(
                    height: 12,
                  ),

                  // Title
                  Text(
                    widget.post.title,
                    style: textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  // Content
                  Text(
                    widget.post.content,
                    style: textTheme.bodyMedium?.copyWith(height: 1.5),
                  ),

                  if (widget.post.imageUrls.isNotEmpty) ...[
                    const SizedBox(
                      height: 16,
                    ),
                    // image picker card
                    ImagePreview(selectedFiles: widget.post.imageUrls)
                  ],
                ],
              ),
            ),

            // Post Action
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  color: colorScheme.surfaceVariant,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: Row(
                children: [
                  // Like button and count
                  Row(
                    children: [
                      likeDataAsync.when(
                        data: (likeData) => IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            // Call toggle without any local state management
                            ref
                                .read(likeServiceProvider(
                                        int.parse(widget.post.id))
                                    .notifier)
                                .toggleLike(
                                    widget.post.id, widget.post.destination.id);
                          },
                          icon: Icon(
                            likeData.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: likeData.isLiked
                                ? colorScheme.error
                                : colorScheme.onSurface,
                          ),
                        ),
                        loading: () => SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: colorScheme.primary,
                          ),
                        ),
                        error: (_, __) => Icon(
                          Icons.favorite_border,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(width: 4),

                      // Like count
                      likeDataAsync.when(
                        data: (likeData) => Text(
                          likeData.likesCount.toString(),
                          style: textTheme.bodyMedium,
                        ),
                        loading: () => Text("...", style: textTheme.bodyMedium),
                        error: (_, __) =>
                            Text("0", style: textTheme.bodyMedium),
                      ),
                    ],
                  ),

                  const SizedBox(width: 8),

                  // Comments count
                  CommentButton(commentsCount: updatedCommentCount),
                  const Spacer(),

                  const ActionButton(
                      icon: Icons.share_outlined, label: "Share"),
                  const ActionButton(
                      icon: Icons.bookmark_border, label: "Save"),

                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        color: colorScheme.onSurfaceVariant,
                      ))
                ],
              ),
            )
          ],
        ));
  }
}
