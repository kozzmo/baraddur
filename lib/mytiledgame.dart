import 'dart:developer';
import 'dart:math' as math;

import 'package:baraddur/components/menuareacomponent.dart';
import 'package:baraddur/components/questareacomponent.dart';
import 'package:baraddur/helpers/utils.dart';
import 'package:baraddur/myworld.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'helpers/direction.dart';
import 'components/myplayer.dart';

class MyTiledGame extends FlameGame
    with KeyboardEvents, HasCollisionDetection, TapDetector {
  late final MyPlayer _myPlayer;
  late final MyWorld _myWorld;

  MyTiledGame() : _myPlayer = MyPlayer(position: Vector2(40, 40));

  late final TiledComponent mapComponent;

  Vector2? tooltipPosition;
  String? tooltipText;

  void showTooltipAt(Vector2 position, {String text = 'Tooltip par défaut', String overlayName = 'tooltip'}) {
    tooltipPosition = position;
    tooltipText = text;
    overlays.add(overlayName);
  }

  void hideTooltip([String overlayName = 'tooltip']) {
    overlays.remove(overlayName);
  }

  @override
  void onTap() {
    hideTooltip();
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    _myWorld = MyWorld(_myPlayer);
    camera = CameraComponent(world: _myWorld);

    await addAll([_myWorld, camera]);

    camera.viewfinder
      ..zoom = myZoom
      ..anchor = Anchor.center;

    camera.follow(_myPlayer);

    _setCameraBounds();
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is KeyDownEvent;
    final isKeyUp = event is KeyUpEvent;
    Direction? keyDirection;

    if (event.logicalKey == LogicalKeyboardKey.keyQ) {
      keyDirection = Direction.left;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      keyDirection = Direction.right;
    } else if (event.logicalKey == LogicalKeyboardKey.keyZ) {
      keyDirection = Direction.up;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      keyDirection = Direction.down;
    }

    if (isKeyDown && keyDirection != null) {
      _myPlayer.direction = keyDirection;
      _myPlayer.gameRef.onJoyPadDirectionChanged(keyDirection);
    } else if (isKeyUp) {
      _myPlayer.direction = Direction.none;
    }

    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    _handleResize();
  }

  void _handleResize() {
    _setCameraBounds();
  }

  void _setCameraBounds() {
    final worldSize = 40 * 16.0;
    camera.setBounds(
      Rectangle.fromCenter(
        center: Vector2.all(worldSize / 2),
        size: Vector2.all(worldSize) - camera.viewport.size / myZoom,
      ),
    );
  }

  void onJoyPadDirectionChanged(Direction direction) {
    _myPlayer.direction = direction;
  }

  MyWorld getMyWorld() {
    return _myWorld;
  }

  String getRandomNoQuestMessage() {
    return noQuestMessages[math.Random().nextInt(noQuestMessages.length)];
  }

  void onActionButtonPressed() async {
    log(
      'BUTTON PRESSED - direction = ${_myPlayer.getDirectionName()} et position = ${_myPlayer.position.x.toString()} / ${_myPlayer.position.y.toString()} et pov = ${_myPlayer.getPov().x.toString()} / ${_myPlayer.getPov().y.toString()}',
    );
    if (_myPlayer.isColliding) {
      log('My Player is colliding !');
      if (_myPlayer.isCollidingWith<QuestAreaComponent>()) {
        final collidingComp = _myPlayer.getCollidingWith<QuestAreaComponent>();
        log('Colliding Quest : ${collidingComp!.height.toString()} * ${collidingComp.width.toString()}');
        showTooltipAt(_myPlayer.getPov(), text: collidingComp.text);
      }

      if (_myPlayer.isCollidingWith<MenuAreaComponent>()) {
        final collidingComp = _myPlayer.getCollidingWith<MenuAreaComponent>();
        log('Colliding Menu : ${collidingComp!.height.toString()} * ${collidingComp.width.toString()}');
        showTooltipAt(_myPlayer.getPov(), overlayName: 'menu');
      }
    } else {
      showTooltipAt(
        _myPlayer.getPov(),
        text: getRandomNoQuestMessage(),
      );
    }
  }
}
