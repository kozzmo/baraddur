import 'dart:developer';

import 'package:baraddur/mytiledgame.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../helpers/direction.dart';
import 'package:flame/sprite.dart';

class MyPlayer extends SpriteAnimationComponent with HasGameRef<MyTiledGame>, CollisionCallbacks {
  final double _playerSpeed = 100.0;
  final double _animationSpeed = 0.15;

  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _standingAnimation;

  late Vector2 _previousPosition ;

  Direction direction = Direction.none;

  MyPlayer({super.position})
      : super(size: Vector2(42.0 / 2, 55.0 / 2), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await _loadAnimations().then((_) => {animation = _standingAnimation});
    add(RectangleHitbox()..collisionType = CollisionType.active);
  }

  @override
  void update(double delta) {
    super.update(delta);
    _previousPosition = position.clone();
    movePlayer(delta);
    keepPlayerInBounds();
  }

  void keepPlayerInBounds() {
    // Récupérer les dimensions de la carte en pixels
    final mapWidth = gameRef.getMyWorld().mapComponent.tileMap.map.width * 16; // Largeur de la carte
    final mapHeight = gameRef.getMyWorld().mapComponent.tileMap.map.height * 16; // Hauteur de la carte

    // Récupérer la taille du joueur
    final playerWidth = size.x;
    final playerHeight = size.y;

    // Limiter la position du joueur à l'intérieur de la carte
    position.x = position.x.clamp(playerWidth / 2, mapWidth - playerWidth / 2);
    position.y = position.y.clamp(playerHeight / 2, mapHeight - playerHeight / 2);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    position.setFrom(_previousPosition);
    super.onCollision(intersectionPoints, other);
  }

  void movePlayer(double delta) {
    switch (direction) {
      case Direction.up:
        animation = _runUpAnimation;
        moveUp(delta);
        break;
      case Direction.down:
        animation = _runDownAnimation;
        moveDown(delta);
        break;
      case Direction.left:
        animation = _runLeftAnimation;
        moveLeft(delta);
        break;
      case Direction.right:
        animation = _runRightAnimation;
        moveRight(delta);
        break;
      case Direction.none:
        animation = _standingAnimation;
        break;
    }
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('sp_player.png'),
      srcSize: Vector2(84.0, 110.0),
    );

    _runDownAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);

    _runLeftAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);

    _runUpAnimation =
        spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);

    _runRightAnimation =
        spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);

    _standingAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 1);
  }

  void moveUp(double delta) {
    position.add(Vector2(0, delta * -_playerSpeed));
  }

  void moveDown(double delta) {
    position.add(Vector2(0, delta * _playerSpeed));
  }

  void moveLeft(double delta) {
    position.add(Vector2(delta * -_playerSpeed, 0));
  }

  void moveRight(double delta) {
    position.add(Vector2(delta * _playerSpeed, 0));
  }
}