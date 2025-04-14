import 'package:baraddur/helpers/questcard.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';

class TooltipOverlay extends StatelessWidget {
  final Vector2 position;
  final String text;
  final VoidCallback onClose;

  const TooltipOverlay({super.key, required this.position, required this.text, required this.onClose});

  @override
  Widget build(BuildContext context) {
    // return Transform.translate(
    //   offset: Offset(position.x, position.y),
    //   child: QuestCard(text: text),
    // );

    // TODO position marche pas, obligé de Center
    return Center(
      child: QuestCard(
        text: text,
        onClose: () => onClose
      ),
    );
  }
}
