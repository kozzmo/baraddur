import 'dart:developer';

import 'package:baraddur/components/bonfire.dart';
import 'package:baraddur/components/menuareacomponent.dart';
import 'package:baraddur/components/myplayer.dart';
import 'package:baraddur/components/questareacomponent.dart';
import 'package:baraddur/helpers/utils.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class MyWorld extends World {
  late final TiledComponent mapComponent;
  late final MyPlayer myPlayer;
  late final List<QuestAreaComponent> myQuests = [];
  // late final List<List<int>> treeLayer; // 2D array of tile (trees)

  late final Bonfire myBonfire;

  MyWorld(this.myPlayer);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    //TODO DEBUG MODE MYWORLD
    debugMode = myDebug;

    mapComponent = await TiledComponent.load('map.tmx', Vector2(16, 16));
    add(mapComponent);

    add(myPlayer);

    //TODO BONFIRE
    myBonfire = Bonfire();
    // add(myBonfire);

    final collisionLayer = mapComponent.tileMap.getLayer<ObjectGroup>(
        'collisions');
    if (collisionLayer != null) {
      for (final obj in collisionLayer.objects) {
        final block = PositionComponent(
          position: Vector2(obj.x, obj.y),
          size: Vector2(obj.width, obj.height),
        )
          ..add(RectangleHitbox(collisionType: CollisionType.passive));
        add(block);
      }
    }

    final itemsLayer = mapComponent.tileMap.getLayer<ObjectGroup>('items_zone');
    if (itemsLayer != null) {
      for (final obj in itemsLayer.objects) {
        final block = PositionComponent(
          position: Vector2(obj.x, obj.y),
          size: Vector2(obj.width, obj.height),
        )
          ..add(RectangleHitbox(collisionType: CollisionType.passive));
        add(block);
      }
    }

    final questLayer = mapComponent.tileMap.getLayer<ObjectGroup>('quest_area');
    if (questLayer != null) {
      for (final obj in questLayer.objects) {
          bool isQuest = questLayer.properties.getValue<bool>('isQuest') ?? false ;
          String myText = obj.properties.getValue<String>('text') ?? 'default' ;
          if(myText != "menu") {
            final questComponent = QuestAreaComponent(
                position: Vector2(obj.x, obj.y),
                size: Vector2(obj.width, obj.height),
                text: isQuest ? getVariableByName(myText) ??
                    "STRING_EMPTY" : "isQuest vide ou false"
            );
            myQuests.add(questComponent);
            add(questComponent);
            log('QUEST BLOCK added at ${questComponent.position.toString()}');
          }
      }
    }

    final menuLayer = mapComponent.tileMap.getLayer<ObjectGroup>('menu_area');
    if(menuLayer != null) {
      for (final obj in menuLayer.objects) {
        String myText = obj.properties.getValue<String>('text') ?? 'default' ;
        if(myText == "menu") {
          MenuAreaComponent menuComponent = MenuAreaComponent(
            position: Vector2(obj.x, obj.y),
            size: Vector2(obj.width, obj.height),
          );
          add(menuComponent);
          log('MENU BLOCK added at ${menuComponent.position.toString()}');
        }
      }
    }
  }
}

    //TODO : HANDLE TREES
  //   final treesLayer = mapComponent.tileMap.getLayer<TileLayer>("trees") ;
  //   // Flatten LayerTile data to raw tile IDs
  //   if (treesLayer == null || treesLayer.data == null) {
  //     throw Exception("Layer 'trees' or its data is null");
  //   }
  //
  //   final csvData = treesLayer.data!
  //       .map((tile) => tile.toDouble().toString() ?? '0')
  //       .join(',');
  //
  // }
  //
  // void parseCsvLayer(String csvData, int width, int height) {
  //   final flatList = csvData
  //       .split(',')
  //       .map((e) => int.tryParse(e.trim()) ?? 0)
  //       .toList();
  //
  //   treeLayer = List.generate(
  //     height,
  //         (y) => List.generate(width, (x) => flatList[y * width + x]),
  //   );
//   }
//
//   bool isTree(int gid) {
//     return gid == 13 || gid == 14 || gid == 15 || gid == 16
//         || gid == 36 || gid == 37 || gid == 38 || gid == 39
//         || gid == 59 || gid == 60 || gid == 61 || gid == 62
//         || gid == 83 || gid == 84
//     ;
//   }
//
//   bool hasTreeAt(Vector2 pos) {
//     final x = pos.x.floor();
//     final y = pos.y.floor();
//
//     if (y < 0 || y >= treeLayer.length || x < 0 || x >= treeLayer[0].length) {
//       return false;
//     }
//
//     final gid = treeLayer[y][x];
//     return isTree(gid);
//   }
// }
