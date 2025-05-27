import 'dart:core';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:wanderverse_app/utils/constants.dart';
import 'package:wanderverse_app/utils/widgets/textField.dart';

class ImagePickerCard extends StatefulWidget {
  final VoidCallback? onClose;

  const ImagePickerCard({
    super.key,
    this.onClose,
  });

  @override
  State<ImagePickerCard> createState() => _ImagePickerCardState();
}

class _ImagePickerCardState extends State<ImagePickerCard> {
  // ignore: prefer_final_fields
  List<Uint8List> _selectedFiles = [];
  late PageController _imagePageController;
  int _currentImagePage = 0;
  late DropzoneViewController _dropzoneController;
  bool isHighlighted = false;

  bool _showCaptionPanel = false;
  final TextEditingController _titleController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  final TextEditingController _contentController = TextEditingController();
  final FocusNode _contentFocusNode = FocusNode();
  final TextEditingController _destinationController = TextEditingController();
  final FocusNode _destinationFocusNode = FocusNode();

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
      _imagePageController.animateToPage(_currentImagePage,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _nextImage() {
    if (_currentImagePage < _selectedFiles.length - 1) {
      setState(() {
        _currentImagePage++;
      });
      _imagePageController.animateToPage(_currentImagePage,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
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
    _contentFocusNode.dispose();
    _titleController.dispose();
    _titleFocusNode.dispose();
    _destinationController.dispose();
    _destinationFocusNode.dispose();
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
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(children: [
        SizedBox(
          width: imagePickerWidth,
          height: imagePickerHeight,
          child: _showCaptionPanel && _selectedFiles.isNotEmpty
              ? _buildImagePreview()
              : _buildImagePickerLayout(),
        ),
        if (_showCaptionPanel && _selectedFiles.isNotEmpty)
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            tween: Tween<double>(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return ClipRect(
                child: SizedBox(
                  width: imageWithCaptionWidth - imagePickerWidth,
                  height: imagePickerHeight,
                  child: FractionalTranslation(
                    translation: Offset(value - 1, 0),
                    child: Opacity(
                      opacity: value,
                      child: _buildCaptionPanel(),
                    ),
                  ),
                ),
              );
            },
          ),
      ]),
    );
  }

  Widget _buildImagePickerLayout() {
    return SizedBox(
      key: const ValueKey<String>('imagePicker'),
      width: imagePickerWidth,
      height: imagePickerHeight,
      child: _buildImagePickerContent(),
    );
  }

  Widget _buildImagePickerContent() {
    return Stack(
      fit: StackFit.expand,
      children: [
        DropzoneView(
          onCreated: (controller) => _dropzoneController = controller,
          onHover: () => setState(() {
            isHighlighted = true;
          }),
          onLeave: () => setState(() {
            isHighlighted = false;
          }),
          onDropFiles: (List<DropzoneFileInterface>? files) {
            if (files == null) return;
            for (DropzoneFileInterface file in files) {
              print('accept file from drop');
              acceptFile(file);
            }
          },
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isHighlighted ? Colors.grey[500] : Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_selectedFiles.isEmpty)
                const Column(
                  children: [
                    Icon(
                      Icons.photo_library,
                      size: 50,
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Create New Post',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Drag photos here',
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 20),
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
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          backgroundColor: Colors.blue),
                      onPressed: () async {
                        final events = await _dropzoneController.pickFiles();
                        if (events.isEmpty) return;

                        for (var file in events) {
                          print('accept file');
                          acceptFile(file);
                        }
                      },
                      icon: const Icon(
                        Icons.search,
                        size: 32,
                        color: Colors.white,
                      ),
                      label: Text(
                        _selectedFiles.isEmpty ? 'Choose Files' : 'Add Files',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),

                  // Next Button
                  if (_selectedFiles.isNotEmpty)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
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

              if (_selectedFiles.isNotEmpty) ...[
                const SizedBox(height: 5),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: imageWidth,
                        height: imageHeight,
                        child: PageView.builder(
                            controller: _imagePageController,
                            itemCount: _selectedFiles.length,
                            onPageChanged: (index) {
                              setState(() {
                                _currentImagePage = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              final filePath = _selectedFiles[index];
                              return _buildImage(filePath);
                            }),
                      ),
                      if (_selectedFiles.length > 1) ...[
                        Positioned(
                            left: 10,
                            child: IconButton(
                                style: ButtonStyle(
                                  iconColor: const WidgetStatePropertyAll(
                                      Colors.white),
                                  backgroundColor: WidgetStateProperty.all(
                                      Colors.black.withOpacity(0.6)),
                                ),
                                onPressed: _previousImage,
                                icon: const Icon(Icons.chevron_left))),
                        Positioned(
                            right: 10,
                            child: IconButton(
                                style: ButtonStyle(
                                  iconColor: const WidgetStatePropertyAll(
                                      Colors.white),
                                  backgroundColor: WidgetStateProperty.all(
                                      Colors.black.withOpacity(0.6)),
                                ),
                                onPressed: _nextImage,
                                icon: const Icon(Icons.chevron_right))),
                        Positioned(
                          bottom: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                                _selectedFiles.length,
                                (index) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _currentImagePage == index
                                              ? Colors.blue
                                              : Colors.grey),
                                    )),
                          ),
                        ),
                      ],
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: IconButton(
                            style: ButtonStyle(
                              iconColor:
                                  const WidgetStatePropertyAll(Colors.red),
                              backgroundColor: WidgetStateProperty.all(
                                  Colors.black.withOpacity(0.6)),
                            ),
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              _selectedFiles.removeAt(_currentImagePage);
                              setState(() {
                                if (_currentImagePage > 0) {
                                  _currentImagePage--;
                                } else {
                                  _currentImagePage = 0;
                                }
                              });
                            }),
                      ),
                    ],
                  ),
                )
              ]
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImagePreview() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[900],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: imageWidth,
                      height: imageHeight,
                      child: PageView.builder(
                        controller: _imagePageController,
                        itemCount: _selectedFiles.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentImagePage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          final fileData = _selectedFiles[index];
                          return _buildImage(fileData);
                        },
                      ),
                    ),
                    // Navigation controls
                    if (_selectedFiles.length > 1) ...[
                      Positioned(
                        left: 10,
                        child: IconButton(
                          style: ButtonStyle(
                            iconColor:
                                const WidgetStatePropertyAll(Colors.white),
                            backgroundColor: WidgetStateProperty.all(
                              Colors.black.withOpacity(0.6),
                            ),
                          ),
                          onPressed: _previousImage,
                          icon: const Icon(Icons.chevron_left),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        child: IconButton(
                          style: ButtonStyle(
                            iconColor:
                                const WidgetStatePropertyAll(Colors.white),
                            backgroundColor: WidgetStateProperty.all(
                              Colors.black.withOpacity(0.6),
                            ),
                          ),
                          onPressed: _nextImage,
                          icon: const Icon(Icons.chevron_right),
                        ),
                      ),

                      // Page indicators
                      Positioned(
                        bottom: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _selectedFiles.length,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentImagePage == index
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCaptionPanel() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[900]!,
            Colors.grey[850]!,
          ],
        ),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _showCaptionPanel = false;
                  });
                },
                icon: const Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Create New Post',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  shadowColor: Colors.blue.withOpacity(0.5),
                ),
                onPressed: () {
                  final caption = _contentController.text;
                  print('Processed $caption');
                },
                child: const Text(
                  'Share',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // _buildInputTextField(
                      //   label: 'Title',
                      //   hintText: 'Enter title here',
                      //   icon: Icons.title,
                      //   controller: _titleController,
                      //   focusNode: _titleFocusNode,
                      //   maxLines: 2,
                      // ),
                      buildTextField(
                          controller: _titleController,
                          labelText: 'Title',
                          suffixIcon: const Icon(Icons.title)),
                      const SizedBox(height: 24),
                      // _buildInputTextField(
                      //   label: 'Content',
                      //   hintText: 'Enter contents here',
                      //   icon: Icons.description,
                      //   controller: _contentController,
                      //   focusNode: _contentFocusNode,
                      //   maxLines: 5,
                      // ),
                      buildTextField(
                          controller: _contentController,
                          labelText: 'Content',
                          suffixIcon: const Icon(Icons.description)),
                      const SizedBox(height: 24),
                      // _buildInputTextField(
                      //   label: 'Destination',
                      //   hintText: 'Add Destination',
                      //   icon: Icons.location_on,
                      //   controller: _destinationController,
                      //   focusNode: _destinationFocusNode,
                      //   maxLines: 1,
                      // ),
                      buildTextField(
                          controller: _destinationController,
                          labelText: 'Destination',
                          suffixIcon: const Icon(Icons.location_on)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputTextField({
    required String label,
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
    required FocusNode focusNode,
    required int maxLines,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: theme.colorScheme.primary, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Use a simplified container with subtle border
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primary.withOpacity(0.1),
                theme.colorScheme.secondary.withOpacity(0.1),
              ],
            ),
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.3),
              width: 1.0,
            ),
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            maxLines: maxLines,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
                fontWeight: FontWeight.w300,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              suffixIcon: maxLines == 1
                  ? Icon(
                      Icons.chevron_right,
                      color: theme.colorScheme.onSurface.withOpacity(0.4),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
