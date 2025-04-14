import 'package:flutter/material.dart';

class ImageSwiper extends StatefulWidget {
  final List<String> imagePaths;
  final double height;

  const ImageSwiper({
    super.key,
    required this.imagePaths,
    this.height = 600,
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
    return GestureDetector(
      onHorizontalDragEnd: _onPageEndSwipe,
      child: SizedBox(
        height: widget.height,
        child: PageView.builder(
          controller: _controller,
          onPageChanged: _handlePageChanged,
          itemCount: widget.imagePaths.length,
          itemBuilder: (context, index) {
            return Image.asset(
              widget.imagePaths[index],
              fit: BoxFit.contain,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
