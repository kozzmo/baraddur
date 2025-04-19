import 'package:baraddur/helpers/mytextcard.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';

class MyTextOverlay extends StatelessWidget {
  final VoidCallback onClose;
  final Vector2 position;
  final String text;

  const MyTextOverlay({super.key, required this.position, required this.text, required this.onClose});

  @override
  Widget build(BuildContext context) {
    // return Transform.translate(
    //   offset: Offset(position.x, position.y),
    //   child: QuestCard(text: text),
    // );

    // TODO position marche pas, obligé de Center
    return Center(
      child: MyTextCard(
        text: text,
        onClose: onClose,
      ),
    );
  }
}
