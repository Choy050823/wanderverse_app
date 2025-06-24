import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderverse_app/providers/post-sharing/commentService.dart';
import 'package:wanderverse_app/utils/constants.dart';
import 'package:wanderverse_app/utils/widgets/textField.dart';

class CommentInput extends ConsumerStatefulWidget {
  final String? userProfilePic;
  final String postId;
  final String? parentCommentId;
  final String destinationId;
  final VoidCallback? onSuccessfulReply;

  const CommentInput(
      {this.userProfilePic,
      required this.postId,
      this.parentCommentId,
      this.onSuccessfulReply,
      required this.destinationId,
      super.key});

  @override
  ConsumerState<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends ConsumerState<CommentInput> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitComment() async {
    if (_commentController.text.trim().isEmpty) return;
    final commentService =
        ref.read(commentServiceProvider(int.parse(widget.postId)).notifier);
    final success = await commentService.createComment(
        widget.postId, _commentController.text, widget.destinationId,
        parentCommentId: widget.parentCommentId);

    print("Succcess add comment? $success");

    if (success && mounted) {
      setState(() {
        _commentController.clear();
      });

      if (widget.parentCommentId != null && widget.onSuccessfulReply != null) {
        widget.onSuccessfulReply!();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error adding comment. Please Try Again'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: colorScheme.primary.withOpacity(0.1),
          backgroundImage:
              NetworkImage(widget.userProfilePic ?? defaultProfilePic),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
            child: buildTextField(
                controller: _commentController,
                labelText: "Join the conversation")),
        IconButton(
            onPressed: _submitComment,
            // {
            //   // Show comment form

            //   if (_commentController.text.isNotEmpty) {
            //     ref
            //         .read(commentServiceProvider(int.parse(widget.postId))
            //             .notifier)
            //         .createComment(widget.postId, _commentController.text,
            //             parentCommentId: widget.parentCommentId);
            //     // setState(() {
            //     //   print("Added comment!");
            //     //   comments = [
            //     //     Comment(
            //     //         id: 2,
            //     //         username: "choymh23",
            //     //         userAvatar:
            //     //             "https://plus.unsplash.com/premium_photo-1665203415837-a3b389a6b33e?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8dHJhdmVsbGVyfGVufDB8fDB8fHww",
            //     //         content: _commentController.text,
            //     //         timeAgo: "1s ago",
            //     //         votes: 0,
            //     //         replies: []),
            //     //     ...comments
            //     //   ];
            //     // });
            //   }

            //   _commentController.clear();
            // },
            icon: Icon(
              Icons.send,
              color: colorScheme.primary,
            ))
      ],
    );
  }
}
