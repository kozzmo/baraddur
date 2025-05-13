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
        contentWidget: ListView(
          children: [
            Center(
              child: Text(
                'Should have a menu here -> be able to check every useful actions?',
              ),
            ),
            GestureDetector(
              child: Center(child: Text('Menu (IRL)')),
              onTap:
                  () => game.showTooltipAt(Vector2(0, 0), overlayName: 'menu'),
            ),
            Center(child: Text('Opening hours')),
            Center(child: Text('Book a table')),
            Center(child: Text('Change sp_player to sp_player_female')),
            Center(child: Text('Events')),
            Center(child: Text('...')),
          ],
        ),
        onClose: game.hideTooltip,
        alignment: Alignment.center,
      );
    },
  };
}
