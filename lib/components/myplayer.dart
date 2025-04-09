import 'dart:developer';

import 'package:baraddur/components/questcomponent.dart';
import 'package:baraddur/components/tooltipcomponent.dart';
import 'package:baraddur/mytiledgame.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../helpers/direction.dart';
import 'package:flame/sprite.dart';

class MyPlayer extends SpriteAnimationComponent
    with HasGameRef<MyTiledGame>, CollisionCallbacks {
  final double _playerSpeed = 100.0;
  final double _animationSpeed = 0.15;

  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _standingUpAnimation;
  late final SpriteAnimation _standingDownAnimation;
  late final SpriteAnimation _standingRightAnimation;
  late final SpriteAnimation _standingLeftAnimation;

  late Vector2 _previousPosition;

  late Direction _previousDirection;

  Direction direction = Direction.none;

  MyPlayer({super.position})
    : super(size: Vector2(42.0 / 2, 55.0 / 2), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await _loadAnimations().then((_) => {animation = _standingDownAnimation});
    add(RectangleHitbox()..collisionType = CollisionType.active);
    _previousDirection = Direction.down;
    //TODO DEBUG MODE PLAYER
    debugMode = true;
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
    final mapWidth =
        gameRef.getMyWorld().mapComponent.tileMap.map.width *
        16; // Largeur de la carte
    final mapHeight =
        gameRef.getMyWorld().mapComponent.tileMap.map.height *
        16; // Hauteur de la carte

    // Récupérer la taille du joueur
    final playerWidth = size.x;
    final playerHeight = size.y;

    // Limiter la position du joueur à l'intérieur de la carte
    position.x = position.x.clamp(playerWidth / 2, mapWidth - playerWidth / 2);
    position.y = position.y.clamp(
      playerHeight / 2,
      mapHeight - playerHeight / 2,
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is! QuestComponent) {
      position.setFrom(_previousPosition);
      super.onCollision(intersectionPoints, other);
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is QuestComponent) {
      other.showTooltip();
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is QuestComponent) {
      other.hideTooltip();
    }
  }

  void movePlayer(double delta) {
    switch (direction) {
      case Direction.up:
        _previousDirection = Direction.up;
        animation = _runUpAnimation;
        moveUp(delta);
        break;
      case Direction.down:
        _previousDirection = Direction.down;
        animation = _runDownAnimation;
        moveDown(delta);
        break;
      case Direction.left:
        _previousDirection = Direction.left;
        animation = _runLeftAnimation;
        moveLeft(delta);
        break;
      case Direction.right:
        _previousDirection = Direction.right;
        animation = _runRightAnimation;
        moveRight(delta);
        break;
      case Direction.none:
        // _previousDirection = Direction.none;
        animation =
            isDirectionDown()
                ? _standingDownAnimation
                : isDirectionUp()
                ? _standingUpAnimation
                : isDirectionLeft()
                ? _standingLeftAnimation
                : isDirectionRight()
                ? _standingRightAnimation
                : _standingDownAnimation;
        break;
    }
  }

  bool isDirectionDown() {
    return _previousDirection == Direction.down;
  }

  bool isDirectionUp() {
    return _previousDirection == Direction.up;
  }

  bool isDirectionLeft() {
    return _previousDirection == Direction.left;
  }

  bool isDirectionRight() {
    return _previousDirection == Direction.right;
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('sp_player.png'),
      srcSize: Vector2(84.0, 110.0),
    );

    _runDownAnimation = spriteSheet.createAnimation(
      row: 0,
      stepTime: _animationSpeed,
      to: 4,
    );

    _runLeftAnimation = spriteSheet.createAnimation(
      row: 2,
      stepTime: _animationSpeed,
      to: 4,
    );

    _runUpAnimation = spriteSheet.createAnimation(
      row: 1,
      stepTime: _animationSpeed,
      to: 4,
    );

    _runRightAnimation = spriteSheet.createAnimation(
      row: 3,
      stepTime: _animationSpeed,
      to: 4,
    );

    _standingDownAnimation = spriteSheet.createAnimation(
      row: 0,
      stepTime: _animationSpeed,
      to: 1,
    );

    _standingRightAnimation = spriteSheet.createAnimation(
      row: 3,
      stepTime: _animationSpeed,
      to: 1,
    );

    _standingUpAnimation = spriteSheet.createAnimation(
      row: 1,
      stepTime: _animationSpeed,
      to: 1,
    );

    _standingLeftAnimation = spriteSheet.createAnimation(
      row: 2,
      stepTime: _animationSpeed,
      to: 1,
    );
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
