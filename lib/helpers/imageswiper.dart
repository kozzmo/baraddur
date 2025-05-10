import 'dart:ui';

import 'package:flutter/material.dart';

class ImageSwiper extends StatefulWidget {

  final double _height = 600.0;
  final List<String> imagePaths;

  const ImageSwiper({
    super.key,
    required this.imagePaths,
  });

  @override
  State<ImageSwiper> createState() => _ImageSwiperState();
}

class _ImageSwiperState extends State<ImageSwiper> {
  late final PageController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: _currentIndex);

    // On attend que tout soit prêt et stable avant de charger precacheImage
    //TODO SAUF QUE ça ne fonctionne pas ? Sur smartphone : https://kozzmo.github.io/baraddur/
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ... pour précharger toutes les images
      for (final path in widget.imagePaths) {
        precacheImage(AssetImage(path), context);
      }
    });
  }

  void _handlePageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onPageEndSwipe(DragEndDetails details) {
    if (details.primaryVelocity == null) return;

    final isLeftSwipe = details.primaryVelocity! < 0;
    final lastIndex = widget.imagePaths.length - 1;

    if (isLeftSwipe && _currentIndex == lastIndex) {
      _controller.jumpToPage(0);
    } else if (!isLeftSwipe && _currentIndex == 0) {
      _controller.jumpToPage(lastIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget._height,
      child: Stack(
        children: [
          // Background blur layer
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: Colors.black.withValues(alpha: 0), // transparent touch passthrough
            ),
          ),
          Align(alignment: Alignment.bottomCenter, child: Container(child: Icon(Icons.more_horiz_rounded,size: 40))),
          // Main content
          GestureDetector(
            onHorizontalDragEnd: _onPageEndSwipe,
            child: PageView.builder(
              controller: _controller,
              onPageChanged: _handlePageChanged,
              itemCount: widget.imagePaths.length,
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  panEnabled: true,
                  minScale: 1.0,
                  maxScale: 4.0,
                  child: Image.asset(
                    widget.imagePaths[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
