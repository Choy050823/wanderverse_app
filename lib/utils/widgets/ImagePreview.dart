import 'package:flutter/material.dart';

class ImagePreview extends StatefulWidget {
  final List<String> selectedFiles;
  final Function(int index)? onDelete; // Required callback for deletion
  final Function(bool hasImages)?
      onImagesEmptyChanged; // Optional callback for empty state

  const ImagePreview({
    required this.selectedFiles,
    this.onDelete,
    this.onImagesEmptyChanged,
    super.key,
  });

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  late PageController _imagePageController;
  int _currentImagePage = 0;

  void _previousImage() {
    if (_currentImagePage > 0) {
      _imagePageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextImage() {
    if (_currentImagePage < widget.selectedFiles.length - 1) {
      _imagePageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _deleteCurrentImage() {
    if (widget.selectedFiles.isEmpty) return;

    final wasEmpty = widget.selectedFiles.length <= 1;

    // Call parent's deletion method with current index
    widget.onDelete!(_currentImagePage);

    // Handle page adjustment
    setState(() {
      // Adjust current page if necessary
      if (_currentImagePage >= widget.selectedFiles.length &&
          widget.selectedFiles.isNotEmpty) {
        _currentImagePage = widget.selectedFiles.length - 1;
      } else if (widget.selectedFiles.isEmpty) {
        _currentImagePage = 0;
      }

      // Update page controller if there are still images
      if (widget.selectedFiles.isNotEmpty) {
        _imagePageController.animateToPage(
          _currentImagePage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    // Notify parent about empty state changes
    if (wasEmpty != widget.selectedFiles.isEmpty) {
      widget.onImagesEmptyChanged?.call(widget.selectedFiles.isEmpty);
    }
  }

  @override
  void initState() {
    super.initState();
    _imagePageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _imagePageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (widget.selectedFiles.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text("No images selected"),
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        // Main image carousel
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: _imagePageController,
            onPageChanged: (index) {
              setState(() {
                _currentImagePage = index;
              });
            },
            itemCount: widget.selectedFiles.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.selectedFiles[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),

        // Navigation arrows
        if (widget.selectedFiles.length > 1)
          Positioned.fill(
            child: Row(
              children: [
                // Previous arrow
                if (_currentImagePage > 0)
                  IconButton(
                    onPressed: _previousImage,
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorScheme.surface.withOpacity(0.7),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_back_ios_new,
                          color: colorScheme.onSurface),
                    ),
                  ),
                const Spacer(),
                // Next arrow
                if (_currentImagePage < widget.selectedFiles.length - 1)
                  IconButton(
                    onPressed: _nextImage,
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorScheme.surface.withOpacity(0.7),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_forward_ios,
                          color: colorScheme.onSurface),
                    ),
                  ),
              ],
            ),
          ),

        // Delete button
        if (widget.onDelete != null)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface.withOpacity(0.8),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.delete, color: colorScheme.error),
                onPressed: _deleteCurrentImage,
              ),
            ),
          ),

        // Image counter
        if (widget.selectedFiles.length > 1)
          Positioned(
            bottom: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: colorScheme.surface.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "${_currentImagePage + 1}/${widget.selectedFiles.length}",
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
