import 'dart:async';

import 'package:flutter/material.dart';

class LoginImageSlider extends StatefulWidget {
  const LoginImageSlider({super.key});

  @override
  State<LoginImageSlider> createState() => _LoginImageSliderState();
}

class _LoginImageSliderState extends State<LoginImageSlider> {
  late PageController _slideshowController;
  int _currentPage = 0;
  Timer? _timer;

  final List<String> imageUrls = [
    "https://m.media-amazon.com/images/I/71eYCAMKcJL._AC_UF1000,1000_QL80_.jpg",
    "https://img.static-af.com/transform/45cb9a13-b167-4842-8ea8-05d0cc7a4d04/",
    "https://keystoneacademic-res.cloudinary.com/image/upload/v1733331993/Switzerland_rkswd8.png"
  ];

  @override
  void initState() {
    super.initState();
    _slideshowController = PageController(initialPage: 0);
    _startImageTimer();
  }

  void _startImageTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < imageUrls.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_slideshowController.hasClients) {
        _slideshowController.animateToPage(_currentPage,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    _slideshowController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(
      children: [
        // Pages for slideshow
        PageView.builder(
          controller: _slideshowController,
          itemCount: imageUrls.length,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            return Image.network(
              imageUrls[index],
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                    color: Colors.white,
                  ),
                );
              },
            );
          },
        ),

        // Gradient Background
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.purple.withOpacity(0.2),
                Colors.black.withOpacity(0.7)
              ])),
        ),

        // WanderVerse Logo with enhanced visibility
        Positioned(
          top: 5,
          left: 5,
          // padding: const EdgeInsets.all(30),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black.withOpacity(0.3),
              border:
                  Border.all(color: Colors.white.withOpacity(0.2), width: 1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.explore_outlined,
                  color: Colors.white,
                  size: 28,
                ),
                const SizedBox(width: 8),
                Text(
                  'WanderVerse',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    shadows: [
                      Shadow(
                        offset: const Offset(0, 2),
                        blurRadius: 4.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Content Overlay - Tagline
        const Positioned(
          bottom: 50,
          left: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Capturing Moments,\nCreating Memories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Progress Indicator Dots - Now at bottom center
        Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < imageUrls.length; i++)
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: i == _currentPage ? 32 : 16,
                    height: 4,
                    decoration: BoxDecoration(
                      color: i == _currentPage
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  )
              ],
            ),
          ),
        ),

        // Navigation arrows
        Positioned.fill(
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  if (_currentPage > 0) {
                    _slideshowController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    _slideshowController.animateToPage(
                      imageUrls.length - 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                icon: const Icon(Icons.chevron_left,
                    color: Colors.white, size: 32),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  if (_currentPage < imageUrls.length - 1) {
                    _slideshowController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    _slideshowController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                icon: const Icon(Icons.chevron_right,
                    color: Colors.white, size: 32),
              )
            ],
          ),
        )
      ],
    ));
  }
}