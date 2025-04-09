import 'package:baraddur/helpers/questcard.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';

class TooltipOverlay extends StatelessWidget {
  final Vector2 position;
  final String text;

  const TooltipOverlay({super.key, required this.position, required this.text});

  @override
  Widget build(BuildContext context) {
    // return Transform.translate(
    //   offset: Offset(position.x, position.y),
    //   child: QuestCard(text: text),
    // );
    //TODO GAME OVERLAY onClose
    return Center(
      child: QuestCard(
        text: text,
        onClose: () => {}  /*game.overlays.remove('questMenu')*/,
      ),
    );
  }
}
