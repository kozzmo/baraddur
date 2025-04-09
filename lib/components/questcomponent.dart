import 'dart:async';
import 'dart:developer';

import 'package:baraddur/components/tooltipcomponent.dart';
import 'package:baraddur/helpers/questcard.dart';
import 'package:baraddur/mytiledgame.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class QuestComponent extends PositionComponent with CollisionCallbacks, HasGameRef<MyTiledGame> {

  final String text;

  late RectangleHitbox _hitbox ;

  QuestComponent({super.position, super.size, required this.text});

  @override
  FutureOr<void> onLoad() {
    _hitbox = RectangleHitbox()..collisionType = CollisionType.passive;
    add(_hitbox);
  }

  void showTooltip() {
    // Ici tu ajoutes une bulle au-dessus, ou déclenches un callback
    log('position = $position');
    gameRef.showTooltipAt(position, text: text);
    //TODO REMOVE BELOW ?
    // parent?.add(
    //   ScrollBox(position: position + Vector2(-100, -100), text: text),
    // );
    //
    // final game = findGame() as MyTiledGame ;
    // game.showTooltipAt(position);
  }

  void hideTooltip() {
    gameRef.hideTooltip();
    //TODO REMOVE ?
    // parent?.children.whereType<ScrollBox>().forEach((_scrollbox) => _scrollbox.removeFromParent());
  }
}