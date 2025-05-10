import 'dart:async';

import 'package:baraddur/components/beericoncomponent.dart';
import 'package:baraddur/mytiledgame.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class MenuAreaComponent extends PositionComponent with HasGameReference<MyTiledGame>{

  MenuAreaComponent({super.size, super.position, super.anchor});

  late RectangleHitbox _hitbox ;
  late BeerIconComponent _myBeerIcon;

  @override
  FutureOr<void> onLoad() async {
    _hitbox = RectangleHitbox()..collisionType = CollisionType.passive;
    add(_hitbox);
  }

  void showTooltip() {
    _myBeerIcon = BeerIconComponent(position: Vector2(position.x + (size.x - 45 / 2) / 2, position.y - 45 / 2), size: Vector2(45 / 2, 45 / 2));
    parent?.add(
      _myBeerIcon,
    );
  }

  void hideTooltip() {
    game.hideTooltip('menu');
    parent?.remove(_myBeerIcon);
  }
}