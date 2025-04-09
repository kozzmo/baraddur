import 'package:baraddur/helpers/actionbutton.dart';
import 'package:baraddur/helpers/joypad.dart';
import 'package:baraddur/mytiledgame.dart';
import 'package:flutter/cupertino.dart';

class MyGamePad extends StatelessWidget {
  final MyTiledGame myGame ;
  const MyGamePad({super.key, required this.myGame});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Joypad(onDirectionChanged: myGame.onJoyPadDirectionChanged),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: ActionButton(
              onPressed: () {
                myGame.onActionButtonPressed(); // appelle une méthode dans ton jeu
              },
            ),
          ),
        ),
      ],
    );
  }
}
