import 'package:baraddur/components/myplayer.dart';
import 'package:baraddur/components/questcomponent.dart';
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

    //TODO DEBUG MODE MYWORLD
    debugMode = true ;

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

    final itemsLayer = mapComponent.tileMap.getLayer<ObjectGroup>('items_zone');
    if (itemsLayer != null) {
      for (final obj in itemsLayer.objects) {
        final block = PositionComponent(
          position: Vector2(obj.x, obj.y),
          size: Vector2(obj.width, obj.height),
        )..add(RectangleHitbox(collisionType: CollisionType.passive));
        add(block);
      }
    }

    final areaLayer = mapComponent.tileMap.getLayer<ObjectGroup>('items_area');
    if (areaLayer != null) {
      for (final obj in areaLayer.objects) {
        bool isQuest = areaLayer.properties.getValue<bool>('isQuest') ?? false ;
        final block = QuestComponent(
          position: Vector2(obj.x + obj.width / 2, obj.y),
          size: Vector2(obj.width, obj.height),
          text: isQuest ? obj.properties.getValue<String>('text') ?? "STRING_EMPTY" : "isQuest vide ou false"
        ) ;
        add(block);
      }
    }
  }
}
