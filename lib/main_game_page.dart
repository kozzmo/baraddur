import 'dart:developer';

import 'package:baraddur/helpers/actionbutton.dart';
import 'package:baraddur/helpers/questcard.dart';
import 'package:baraddur/helpers/tooltipoverlay.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'helpers/joypad.dart';

import 'mytiledgame.dart';

class MainGamePage extends StatefulWidget {
  const MainGamePage({super.key});

  @override
  MainGameState createState() => MainGameState();
}

class MainGameState extends State<MainGamePage> {
  MyTiledGame game = MyTiledGame();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      body: Stack(
        children: [
          GameWidget(
            game: game,
            overlayBuilderMap: {
              'tooltip': (BuildContext context, MyTiledGame game) {
                return TooltipOverlay(
                  position: game.tooltipPosition ?? Vector2(0, 0),
                  text: game.tooltipText ?? 'EMPTY',
                );
              },
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Joypad(onDirectionChanged: game.onJoyPadDirectionChanged),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: ActionButton(
                onPressed: () {
                  game.onActionButtonPressed(); // appelle une méthode dans ton jeu
                },
              ),
            ),
          ),

        ],
      ),
    );
  }
}
