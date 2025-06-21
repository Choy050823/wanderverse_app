import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderverse_app/providers/models.dart';
import 'package:wanderverse_app/providers/post-sharing/destinationService.dart';
import 'package:wanderverse_app/providers/post-sharing/postService.dart';
import 'package:wanderverse_app/utils/constants.dart';
import 'package:wanderverse_app/utils/widgets/textField.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  final VoidCallback? onClose;

  const CreatePostScreen({
    super.key,
    this.onClose,
  });

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen>
    with TickerProviderStateMixin {
  List<Uint8List> _selectedFiles = [];
  late PageController _imagePageController;
  int _currentImagePage = 0;
  late DropzoneViewController _dropzoneController;
  bool isHighlighted = false;

  PostType _selectedPostType = PostType.post; // default post type
  String? _selectedDestinationId;

  bool _showCaptionPanel = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  // final TextEditingController _captionController = TextEditingController();
  // final TextEditingController _locationController = TextEditingController();

  final double imagePickerWidth = 500;
  final double imagePickerHeight = 500;
  final double imageWidth = 500;
  final double imageHeight = 500;
  final double imageWithCaptionWidth = 1000;
  final double captionHeight = 500;

  void _previousImage() {
    if (_currentImagePage > 0) {
      setState(() {
        _currentImagePage--;
      });
      _imagePageController.animateToPage(
        _currentImagePage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextImage() {
    if (_currentImagePage < _selectedFiles.length - 1) {
      setState(() {
        _currentImagePage++;
      });
      _imagePageController.animateToPage(
        _currentImagePage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> acceptFile(dynamic event) async {
    final name = await _dropzoneController.getFilename(event);
    final mime = await _dropzoneController.getFileMIME(event);
    final bytes = await _dropzoneController.getFileSize(event);
    final fileData = await _dropzoneController.getFileData(event);

    if (!['image/jpeg', 'image/jpg', 'image/png', 'image/gif'].contains(mime)) {
      print('Unsupported file type: $mime');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.warning,
              color: Colors.black,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Only image files (JPEG, JPG, PNG, GIF) are allowed',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.amber,
      ));
      return;
    }

    final droppedFile =
        DroppedFile(fileData: fileData, name: name, mime: mime, bytes: bytes);

    _selectedFiles.add(fileData);
    print('Name ${droppedFile.name}');
    // print('File Data ${droppedFile.fileData}');

    setState(() {
      isHighlighted = false;
    });
  }

  Widget _buildImage(Uint8List fileData) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.memory(
        fileData,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _imagePageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _imagePageController.dispose();
    _contentController.dispose();
    _titleController.dispose();
    _destinationController.dispose();
    // _captionController.dispose();
    // _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _showCaptionPanel && _selectedFiles.isNotEmpty
          ? imageWithCaptionWidth
          : imagePickerWidth,
      height: imagePickerHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Main image picker section
          SizedBox(
            width: imagePickerWidth,
            height: imagePickerHeight,
            child: _buildImagePickerLayout(),
          ),

          // Caption panel (animated)
          if (_showCaptionPanel && _selectedFiles.isNotEmpty)
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 300),
              tween: Tween<double>(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return ClipRect(
                  child: SizedBox(
                    width: (imageWithCaptionWidth - imagePickerWidth) * value,
                    height: imagePickerHeight,
                    child: Opacity(
                      opacity: value,
                      child: _buildCaptionPanel(),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildImagePickerContent() {
    final theme = Theme.of(context);

    return Stack(
      fit: StackFit.expand,
      children: [
        DropzoneView(
          onCreated: (controller) => _dropzoneController = controller,
          onHover: () => setState(() => isHighlighted = true),
          onLeave: () => setState(() => isHighlighted = false),
          onDropFiles: (List<DropzoneFileInterface>? files) {
            if (files == null) return;
            for (DropzoneFileInterface file in files) {
              acceptFile(file);
            }
          },
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isHighlighted
                ? theme.colorScheme.surface.withOpacity(0.7)
                : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_selectedFiles.isEmpty)
                Column(
                  children: [
                    Icon(
                      Icons.photo_library,
                      size: 50,
                      color: theme.colorScheme.onSurface,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Create New Post',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Drag photos here',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),

              // Choose Files button
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        backgroundColor: theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        final events = await _dropzoneController.pickFiles();
                        if (events.isEmpty) return;
                        for (var file in events) {
                          acceptFile(file);
                        }
                      },
                      icon: Icon(
                        Icons.search,
                        size: 32,
                        color: theme.colorScheme.onPrimary,
                      ),
                      label: Text(
                        _selectedFiles.isEmpty ? 'Choose Files' : 'Add Files',
                        style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),

                  // Next Button
                  if (_selectedFiles.isNotEmpty && !_showCaptionPanel)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                        ),
                        onPressed: () {
                          setState(() {
                            _showCaptionPanel = true;
                          });
                        },
                        child: const Text('Next'),
                      ),
                    ),
                ],
              ),

              // Image preview section
              if (_selectedFiles.isNotEmpty) ...[
                const SizedBox(height: 20),
                Expanded(
                  child: _buildImagePreview(),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImagePickerLayout() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: _buildImagePickerContent(),
    );
  }

  Widget _buildImagePreview() {
    final theme = Theme.of(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        // Main image container
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.onSurface.withOpacity(0.2),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: PageView.builder(
              controller: _imagePageController,
              itemCount: _selectedFiles.length,
              onPageChanged: (index) {
                setState(() {
                  _currentImagePage = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.memory(
                  _selectedFiles[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                );
              },
            ),
          ),
        ),

        // Navigation controls (only show if more than 1 image)
        if (_selectedFiles.length > 1) ...[
          // Left navigation button
          Positioned(
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withOpacity(0.8),
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
                onPressed: _currentImagePage > 0 ? _previousImage : null,
                icon: Icon(
                  Icons.chevron_left,
                  color: _currentImagePage > 0
                      ? theme.colorScheme.onSurface
                      : theme.colorScheme.onSurface.withOpacity(0.3),
                ),
              ),
            ),
          ),

          // Right navigation button
          Positioned(
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withOpacity(0.8),
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
                onPressed: _currentImagePage < _selectedFiles.length - 1
                    ? _nextImage
                    : null,
                icon: Icon(
                  Icons.chevron_right,
                  color: _currentImagePage < _selectedFiles.length - 1
                      ? theme.colorScheme.onSurface
                      : theme.colorScheme.onSurface.withOpacity(0.3),
                ),
              ),
            ),
          ),

          // Page indicators
          Positioned(
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  _selectedFiles.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentImagePage == index
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],

        // Delete button (always visible)
        Positioned(
          bottom: 10,
          right: 10,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.error.withOpacity(0.9),
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
              onPressed: _deleteCurrentImage,
              icon: Icon(
                Icons.delete,
                color: theme.colorScheme.onError,
                size: 20,
              ),
              tooltip: 'Delete image',
            ),
          ),
        ),

        // Image counter (top left)
        if (_selectedFiles.length > 1)
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                '${_currentImagePage + 1} / ${_selectedFiles.length}',
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  IconData _getPostTypeIcon(PostType type) {
    switch (type) {
      case PostType.post:
        return Icons.photo;
      case PostType.experience:
        return Icons.hiking;
      case PostType.questions:
        return Icons.help;
      case PostType.tips:
        return Icons.lightbulb;
      default:
        return Icons.article;
    }
  }

  String _getPostTypeName(PostType type) {
    switch (type) {
      case PostType.post:
        return 'General Post';
      case PostType.experience:
        return 'Travel Experience';
      case PostType.questions:
        return 'Question';
      case PostType.tips:
        return 'Travel Tip';
      default:
        return type.toString().split('.').last;
    }
  }

  Widget _buildCaptionPanel() {
    final theme = Theme.of(context);
    final destinationAsync = ref.watch(destinationServiceProvider);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          left: BorderSide(
            color: theme.colorScheme.onSurface.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Add Details',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis),
              IconButton(
                onPressed: () {
                  setState(() {
                    _showCaptionPanel = false;
                  });
                },
                icon: Icon(
                  Icons.close,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Title field
          buildTextField(
              controller: _titleController,
              labelText: 'Title',
              suffixIcon: const Icon(Icons.title)),
          const SizedBox(height: 16),

          buildTextField(
              controller: _contentController,
              labelText: 'Content',
              suffixIcon: const Icon(Icons.edit)),
          const SizedBox(height: 16),

          // Location field
          // buildTextField(
          //     controller: _destinationController,
          //     labelText: 'Location',
          //     suffixIcon: const Icon(Icons.location_on)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Destination",
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              destinationAsync.when(
                  data: (destinations) {
                    return Autocomplete<Destination>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return destinations;
                        }
                        return destinations.where((destination) {
                          return destination.name
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      displayStringForOption: (destination) => destination.name,
                      fieldViewBuilder: (context, textEditingController,
                          focusNode, onFieldSubmitted) {
                        _destinationController = textEditingController;
                        return TextField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                              hintText: "Search for a destination...",
                              prefixIcon: const Icon(Icons.location_on),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              fillColor: theme.colorScheme.surface,
                              filled: true),
                          onSubmitted: (_) => onFieldSubmitted(),
                        );
                      },
                      onSelected: (Destination destination) {
                        setState(() {
                          _selectedDestinationId = destination.id;
                          _destinationController.text = destination.name;
                        });
                      },
                      optionsViewBuilder: (context, onSelected, options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                              elevation: 4.0,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                    maxHeight: 200, maxWidth: 500),
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: options.length,
                                    itemBuilder: (context, index) {
                                      final Destination option =
                                          options.elementAt(index);
                                      return ListTile(
                                        leading: option.imageUrl.isNotEmpty
                                            ? CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    option.imageUrl),
                                              )
                                            : const CircleAvatar(
                                                child: Icon(Icons.location_on),
                                              ),
                                        title: Text(option.name),
                                        subtitle: Text(
                                          option.description,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        onTap: () => onSelected(option),
                                      );
                                    }),
                              )),
                        );
                      },
                    );
                  },
                  error: (error, _) =>
                      Text("Error loading destinations: $error"),
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ))
            ],
          ),

          const SizedBox(
            height: 8,
          ),

          // Post type selector
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Post Type",
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: theme.colorScheme.outline.withOpacity(0.5),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<PostType>(
                      isExpanded: true,
                      value: _selectedPostType,
                      icon: const Icon(Icons.arrow_drop_down),
                      style: theme.textTheme.bodyLarge,
                      onChanged: (PostType? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedPostType = newValue;
                          });
                        }
                      },
                      items: PostType.values
                          .map<DropdownMenuItem<PostType>>((PostType type) {
                        return DropdownMenuItem<PostType>(
                            value: type,
                            child: Row(
                              children: [
                                Icon(
                                  _getPostTypeIcon(type),
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(_getPostTypeName(type))
                              ],
                            ));
                      }).toList(),
                    ),
                  ))
            ],
          ),

          const Spacer(),

          // Share button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Handle post sharing
                _sharePost(
                  _titleController.text,
                  _contentController.text,
                );
              },
              child: const Text('Share Post'),
            ),
          ),
        ],
      ),
    );
  }

  void _sharePost(String title, String content) {
    // Validation checks (use return to exit early)
    if (_selectedFiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select at least one image'),
        backgroundColor: Colors.red,
      ));
      return; // Exit early
    }

    if (title.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter title'),
        backgroundColor: Colors.red,
      ));
      return; // Exit early
    }

    if (content.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter content'),
        backgroundColor: Colors.red,
      ));
      return; // Exit early
    }

    // if (destination.trim().isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content: Text('Please enter destination'),
    //     backgroundColor: Colors.red,
    //   ));
    //   return; // Exit early
    // }

    if (_selectedDestinationId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select a destination'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    // Show loading indicator
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Row(children: [
        CircularProgressIndicator(color: Colors.white),
        SizedBox(width: 16),
        Text('Creating post...'),
      ]),
      duration: Duration(seconds: 10),
    ));

    // Store error message variable to avoid widget disposal issues
    final postServiceNotifier = _selectedPostType == PostType.post
        ? ref.read(sharingPostsProvider.notifier)
        : ref.read(discussionPostsProvider.notifier);

    final postService = _selectedPostType == PostType.post
        ? ref.read(sharingPostsProvider)
        : ref.read(discussionPostsProvider);

    // print("SELECTED POST TYPE: $_selectedPostType");

    postServiceNotifier
        .createPost(title, content, _selectedDestinationId!,
            postType: _selectedPostType, imageFiles: _selectedFiles)
        .then((success) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Post created successfully!'),
          backgroundColor: Colors.greenAccent,
        ));

        // Only close after successful post creation
        widget.onClose?.call();
      } else {
        // Get error message immediately to avoid ref after disposal
        String? errorMsg;
        try {
          errorMsg = postService.errorMessage;
        } catch (e) {
          errorMsg = "Could not retrieve error details";
        }

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error: ${errorMsg ?? 'Failed to create post'}"),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  void _deleteCurrentImage() {
    if (_selectedFiles.isEmpty) return;

    setState(() {
      _selectedFiles.removeAt(_currentImagePage);

      // Adjust current page if necessary
      if (_currentImagePage >= _selectedFiles.length &&
          _selectedFiles.isNotEmpty) {
        _currentImagePage = _selectedFiles.length - 1;
      } else if (_selectedFiles.isEmpty) {
        _currentImagePage = 0;
        _showCaptionPanel = false; // Hide caption panel if no images
      }

      // Update page controller if there are still images
      if (_selectedFiles.isNotEmpty) {
        _imagePageController.animateToPage(
          _currentImagePage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }
}
