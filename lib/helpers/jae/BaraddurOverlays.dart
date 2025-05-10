import 'dart:developer';
import 'package:baraddur/helpers/imageswiper.dart';
import 'package:baraddur/helpers/mytextoverlay.dart';
import 'package:baraddur/helpers/parchmentcard.dart';
import 'package:baraddur/mytiledgame.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

class BaraddurOverlays {
  final overlays = {
    'tooltip': (BuildContext context, MyTiledGame game) {
      log('TOOLTIP rendered at : ${game.tooltipPosition.toString()}');
      //TODO position marche pas
      return MyTextOverlay(
        alignment: game.align ?? Alignment.topCenter,
        position: game.tooltipPosition ?? Vector2(0, 0),
        text: game.tooltipText ?? 'EMPTY',
        onClose: game.hideTooltip,
      );
    },
    'menu': (BuildContext context, MyTiledGame game) {
      log('IN MENU !!');
      return ImageSwiper(
        imagePaths: [
          'assets/images/Menu/Boissons/bieresBouteilles.png',
          'assets/images/Menu/Boissons/bieresFut.png',
          'assets/images/Menu/Boissons/potions.png',
          'assets/images/Menu/Boissons/softs.png',
        ],
      );
    },
    'game_menu': (BuildContext context, MyTiledGame game) {
      return ParchmentCard(
        contentWidget: Text(
          'Should have a menu here -> be able to check every useful actions? '
              '\n- menu (IRL)'
              '\n- opening hours'
              '\n- change sp_player to sp_player_female?'
              '\n- ...',
        ),
        onClose: game.hideTooltip,
        alignment: Alignment.center,
      );
    },
  };
}
