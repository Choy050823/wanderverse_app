import 'dart:io';
import 'package:flutter/material.dart';

class ImagePickerCard extends StatefulWidget {
  // final VoidCallback onClose;
  // final VoidCallback onClose;
  // final ValueChanged<List<String>> onFilesSelected;

  const ImagePickerCard({
    super.key,
    // required this.onClose,
    // required this.onFilesSelected,
  });

  @override
  State<ImagePickerCard> createState() => _ImagePickerCardState();
}

class _ImagePickerCardState extends State<ImagePickerCard> {
  // late DropzoneViewController controller;
  List<String> _selectedFiles = [
    "https://m.media-amazon.com/images/I/71eYCAMKcJL._AC_UF1000,1000_QL80_.jpg",
    "https://m.media-amazon.com/images/I/71eYCAMKcJL._AC_UF1000,1000_QL80_.jpg",
    "https://m.media-amazon.com/images/I/71eYCAMKcJL._AC_UF1000,1000_QL80_.jpg",
    "https://m.media-amazon.com/images/I/71eYCAMKcJL._AC_UF1000,1000_QL80_.jpg",
    "https://m.media-amazon.com/images/I/71eYCAMKcJL._AC_UF1000,1000_QL80_.jpg"
  ];
  late PageController _imagePageController;
  int _currentImagePage = 0;

  Future<void> _pickFiles() async {
    //   FilePickerResult? result = await FilePicker.platform.pickFiles(
    //     allowMultiple: true,
    //     type: FileType.media,
    //   );
    //   if (result != null) {
    //     setState(() {
    //       _selectedFiles = result.files
    //           .map((file) {
    //             if (file.path != null) {
    //               return file.path!; // Use path for desktop
    //             } else if (file.bytes != null) {
    //               // For web, save bytes to a temp file or use URL (simplified)
    //               return 'web_file_${DateTime.now().millisecondsSinceEpoch}_${file.name}';
    //             }
    //             return '';
    //           })
    //           .where((path) => path.isNotEmpty)
    //           .toList();
    //     });
    //     widget.onFilesSelected(_selectedFiles);
    //   }
  }

  // Future _handleDrop(dynamic event) async {
  //   final name = await controller.getFilename(event);
  //   final mime = await controller.getFileMIME(event);
  //   final bytes = await controller.getFileSize(event);
  //   final url = await controller.createFileUrl(event);
  //   print('Dropped: $name, MIME: $mime, Size: $bytes, URL: $url');

  //   setState(() {
  //     _selectedFiles.add(url); // Use URL for web, adjust for desktop if needed
  //   });
  //   widget.onFilesSelected(_selectedFiles);
  // }

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

  Widget _buildImage(String filePath) {
    try {
      if (filePath.startsWith('http') || filePath.startsWith('https')) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              filePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            ),
          ),
        );
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            File(filePath),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
          ),
        );
      }
    } catch (e) {
      return const Icon(Icons.error);
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
    return GestureDetector(
      // onTap: widget.onClose,
      child: AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          color: Colors.black54,
          child: Center(
            child: SizedBox(
              width: 400,
              height: 400,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // DropzoneView(
                  //   onCreated: (ctrl) => controller = ctrl,
                  //   onDrop: _handleDrop,
                  //   onHover: () => setState(() {}),
                  //   onLeave: () => setState(() {}),
                  //   onLoaded: () => print('Dropzone loaded'),
                  //   onError: (err) => print('Dropzone error: $err'),
                  // ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Drag photos and videos here',
                                style: TextStyle(color: Colors.white70),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ElevatedButton(
                          onPressed: _pickFiles,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey),
                          child: const Text(
                            'Select from Computer',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        if (_selectedFiles.isNotEmpty) ...[
                          const SizedBox(height: 3),
                          Expanded(
                              child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: double.infinity,
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
                              Positioned(
                                  left: 10,
                                  child: IconButton(
                                      style: ButtonStyle(
                                        iconColor: const WidgetStatePropertyAll(
                                            Colors.white),
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                Colors.black.withOpacity(0.6)),
                                      ),
                                      onPressed: _previousImage,
                                      icon: const Icon(Icons.arrow_back_ios))),
                              Positioned(
                                  right: 10,
                                  child: IconButton(
                                      style: ButtonStyle(
                                        iconColor: const WidgetStatePropertyAll(
                                            Colors.white),
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                Colors.black.withOpacity(0.6)),
                                      ),
                                      onPressed: _nextImage,
                                      icon:
                                          const Icon(Icons.arrow_forward_ios))),
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
                                                color:
                                                    _currentImagePage == index
                                                        ? Colors.blue
                                                        : Colors.grey),
                                          )),
                                ),
                              )
                            ],
                          ))
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
