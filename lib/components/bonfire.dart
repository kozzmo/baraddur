import 'dart:async';

import 'package:baraddur/mytiledgame.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Bonfire extends SpriteAnimationComponent with HasGameReference<MyTiledGame> {
  final double _animationSpeed = 0.15;

  Bonfire({super.key});

  late final SpriteAnimation fire_1,
      fire_2,
      fire_3,
      fire_4;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    await _loadAnimations().then((_) => {animation = fire_1});
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await game.images.load('bonfire.png'),
      srcSize: Vector2(64.0, 64.0),
    );
    fire_1 = spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 3);
  }
}