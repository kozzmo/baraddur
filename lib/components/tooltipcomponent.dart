import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class TooltipComponent extends TextComponent {
  TooltipComponent({
    required Vector2 position,
    required String text,
  }) : super(
    text: text,
    position: position,
    anchor: Anchor.bottomCenter,
    priority: 100, // devant les autres éléments
  );

  @override
  Future<void> onLoad() async {
    textRenderer = TextPaint(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        backgroundColor: Colors.black87,
      ),
    );
  }
}