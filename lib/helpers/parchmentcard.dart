import 'package:flutter/material.dart';

class ParchmentCard extends StatefulWidget {
  final VoidCallback onClose;
  final Widget contentWidget;
  const ParchmentCard({super.key, required this.contentWidget, required this.onClose});

  @override
  State<ParchmentCard> createState() => _ParchmentCardState();
}

class _ParchmentCardState extends State<ParchmentCard> with SingleTickerProviderStateMixin {

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(32),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/parchment_texture.jpg'),
                fit: BoxFit.fill,
              ),
              border: Border.all(color: Colors.brown, width: 3),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.shade300,
                  offset: const Offset(4, 4),
                  blurRadius: 10,
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: widget.contentWidget,
            ),
          ),
          Positioned(
            right: 40,
            top: 40,
            child: GestureDetector(
              onTap: widget.onClose,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(color: Colors.brown, width: 2),
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  Icons.close,
                  size: 24,
                  color: Colors.brown,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
