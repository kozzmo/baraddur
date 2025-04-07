import 'dart:developer';

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

class MyTiledGame extends FlameGame with KeyboardEvents, HasCollisionDetection {
  late final MyPlayer _myPlayer;
  late final MyWorld _myWorld;

  MyTiledGame() : _myPlayer = MyPlayer(position: Vector2(40, 40));

  late final TiledComponent mapComponent;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    _myWorld = MyWorld(_myPlayer);
    camera = CameraComponent(world: _myWorld);

    await addAll([
      _myWorld,
      camera
    ]);

    camera.viewfinder
      ..zoom = 2.0
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
    final halfViewportSize = camera.viewport.size / 2;
    final worldSize = 40*16.0;
    camera.setBounds(
      Rectangle.fromCenter(
        center: Vector2.all(worldSize / 2),
        size: Vector2.all(worldSize) - halfViewportSize,
      ),
    );
  }

  void onJoyPadDirectionChanged(Direction direction) {
    _myPlayer.direction = direction;
  }

  MyWorld getMyWorld() {
    return this._myWorld;
  }
}
