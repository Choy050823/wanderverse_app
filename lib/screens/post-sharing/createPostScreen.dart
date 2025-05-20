import 'package:flutter/material.dart';
import 'package:wanderverse_app/utils/widgets/imagePickerCard.dart';

class CreatePostScreen extends StatefulWidget {
  final VoidCallback? onClose;

  const CreatePostScreen({
    super.key,
    this.onClose,
  });

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  @override
  Widget build(BuildContext context) {
    return ImagePickerCard(onClose: widget.onClose);
  }
}
