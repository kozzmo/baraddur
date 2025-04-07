import 'package:baraddur/components/myplayer.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class MyWorld extends World {
  late final TiledComponent mapComponent;
  late final MyPlayer myPlayer;

  MyWorld(this.myPlayer);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    mapComponent = await TiledComponent.load('map.tmx', Vector2(16, 16));
    add(mapComponent);

    add(myPlayer);

    final collisionLayer = mapComponent.tileMap.getLayer<ObjectGroup>('collisions');
    if (collisionLayer != null) {
      for (final obj in collisionLayer.objects) {
        final block = PositionComponent(
          position: Vector2(obj.x, obj.y),
          size: Vector2(obj.width, obj.height),
        )..add(RectangleHitbox(collisionType: CollisionType.passive));
        add(block);
      }
    }
  }
}
