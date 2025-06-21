import 'package:flutter/material.dart';
import 'package:wanderverse_app/providers/models.dart';

class PostCategoryChip extends StatefulWidget {
  final PostType postType;
  const PostCategoryChip({required this.postType, super.key});

  @override
  State<PostCategoryChip> createState() => _PostCategoryChipState();
}

class _PostCategoryChipState extends State<PostCategoryChip> {
  @override
  Widget build(BuildContext context) {
    late Color chipColor;
    late IconData chipIcon;
    late String label;

    final colorScheme = Theme.of(context).colorScheme;

    switch (widget.postType) {
      case PostType.questions:
        chipColor = colorScheme.primary;
        chipIcon = Icons.help_outline;
        label = "Question";
        break;
      case PostType.experience:
        chipColor = colorScheme.secondary;
        chipIcon = Icons.hiking;
        label = 'Experience';
        break;
      case PostType.tips:
        chipColor = colorScheme.tertiary;
        chipIcon = Icons.lightbulb_outline;
        label = 'Tip';
        break;
      default:
        chipColor = colorScheme.primary;
        chipIcon = Icons.chat_bubble_outline;
        label = "Discussion";
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            chipIcon,
            size: 12,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
