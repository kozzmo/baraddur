import 'package:baraddur/helpers/mytextcard.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';

class MyTextOverlay extends StatelessWidget {
  final VoidCallback onClose;
  final Vector2 position;
  final String text;
  final Alignment alignment;

  const MyTextOverlay({super.key, required this.position, required this.text, required this.onClose, required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyTextCard(
        text: text,
        onClose: onClose,
        alignment: alignment,
      ),
    );
  }
}
