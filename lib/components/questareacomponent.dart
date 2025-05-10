import 'dart:async';
import 'dart:developer';
import 'package:baraddur/components/interrogationdotcomponent.dart';
import 'package:baraddur/mytiledgame.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class QuestAreaComponent extends PositionComponent with CollisionCallbacks, HasGameReference<MyTiledGame> {

  final String text;

  late RectangleHitbox _hitbox ;
  late InterrogationDotComponent _myInterrogationDot;
  late final RectangleHitbox _detectionZone;

  QuestAreaComponent({super.position, super.size, required this.text});

  @override
  FutureOr<void> onLoad() {
    _hitbox = RectangleHitbox()..collisionType = CollisionType.passive;
    add(_hitbox);
    // _detectionZone = RectangleHitbox.relative(
    //   Vector2.all(2.0), // zone = 200% taille de la quête
    //   parentSize: size,
    // )..collisionType = CollisionType.passive;
    //
    // add(_detectionZone);
  }

  void showTooltip() {
    _myInterrogationDot = InterrogationDotComponent(position: Vector2(position.x + (size.x - 40 / 3) / 2, position.y - 66 / 3), size: Vector2(40 / 3, 66 / 3));
    parent?.add(
      _myInterrogationDot,
    );
  }

  void hideTooltip() {
    game.hideTooltip();
    parent?.remove(_myInterrogationDot);
  }
}