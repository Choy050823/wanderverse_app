import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderverse_app/providers/models.dart';
import 'package:wanderverse_app/providers/post-sharing/userService.dart';
import 'package:wanderverse_app/utils/constants.dart';
import 'package:wanderverse_app/utils/widgets/CommentInput.dart';

class CommentItem extends ConsumerStatefulWidget {
  final Comment comment;
  final int depth;
  final String creatorId;
  const CommentItem(
      {required this.comment,
      required this.depth,
      required this.creatorId,
      super.key});

  @override
  ConsumerState<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends ConsumerState<CommentItem> {
  bool isReplying = false;

  void _handleSuccessfulReply() {
    // Close the reply input
    setState(() {
      isReplying = false;
    });

    // Force refresh parent comments list
    // ref.refresh(commentServiceProvider(int.parse(widget.comment.postId)));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bool hasReplies = widget.comment.replies.isNotEmpty;
    final commentUser = widget.comment.user;

    // print("Comment User profile pic: ${commentUser}");

    return Padding(
      padding: EdgeInsets.only(
          left: 16.0,
          right: widget.depth > 0 ? 0 : 16.0,
          top: widget.depth == 0 ? 8.0 : 0.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left side: comment thread lines
            if (widget.depth > 0)
              SizedBox(
                width: 24.0,
                child: Center(
                  child: Container(
                    width: 2,
                    height: double.infinity, // Full height connection
                    color: colorScheme.primary.withOpacity(0.2),
                  ),
                ),
              ),

            // Right side: actual comment with full width
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Comment card
                  Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                            color: colorScheme.outline.withOpacity(0.1),
                            width: 1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Comment header - no change
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(
                                    commentUser.profilePicUrl == null ||
                                            commentUser.profilePicUrl == ""
                                        ? defaultProfilePic
                                        : commentUser.profilePicUrl!),
                              ),
                              const SizedBox(width: 8),
                              Text(commentUser.username,
                                  style: textTheme.bodySmall
                                      ?.copyWith(fontWeight: FontWeight.bold)),
                              // BIG ERROR: Need to check if comment user id is creator id
                              if (widget.comment.user.id ==
                                  widget.creatorId) ...[
                                const SizedBox(width: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 1),
                                  decoration: BoxDecoration(
                                      color: colorScheme.primary,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Text("OP",
                                      style: textTheme.labelSmall?.copyWith(
                                          color: colorScheme.onPrimary,
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold)),
                                )
                              ],
                              const SizedBox(width: 4),
                              Text("• ${getTimeAgo(widget.comment.createdAt)}",
                                  style: textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant)),
                            ],
                          ),
                        ),

                        // Comment content
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                          child: Text(widget.comment.content,
                              style: textTheme.bodyMedium),
                        ),

                        // Comment actions
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
                          child: Row(
                            children: [
                              // VoteButton(
                              //     votes: widget.comment.votes, voted: false),
                              TextButton.icon(
                                onPressed: () {
                                  // add a comment input
                                  setState(() {
                                    isReplying = !isReplying;
                                  });
                                },
                                icon: Icon(Icons.reply,
                                    size: 16,
                                    color: colorScheme.onSurfaceVariant),
                                label: Text("Reply",
                                    style: textTheme.labelSmall?.copyWith(
                                        color: colorScheme.onSurfaceVariant)),
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 0)),
                              ),
                            ],
                          ),
                        ),

                        if (isReplying)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CommentInput(
                              postId: widget.comment.postId,
                              userProfilePic:
                                  ref.watch(userServiceProvider).user == null
                                      ? defaultProfilePic
                                      : ref
                                          .watch(userServiceProvider)
                                          .user!
                                          .profilePicUrl,
                              parentCommentId: widget.comment.id,
                              onSuccessfulReply: _handleSuccessfulReply,
                            ),
                          )
                      ],
                    ),
                  ),

                  // Nested replies with proper indentation
                  if (hasReplies)
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Column(
                        children: widget.comment.replies
                            .map((reply) => CommentItem(
                                comment: reply,
                                creatorId: widget.creatorId,
                                depth: widget.depth + 1))
                            .toList(),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
