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
            GameWidget(game: game),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child:
                Joypad(onDirectionChanged: game.onJoyPadDirectionChanged),
              ),
            )
          ],
        )
    );
  }
}