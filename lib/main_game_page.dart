import 'dart:developer';
import 'package:baraddur/helpers/actionbutton.dart';
import 'package:baraddur/helpers/imageswiper.dart';
import 'package:baraddur/helpers/jae/BaraddurOverlays.dart';
import 'package:baraddur/helpers/mytextoverlay.dart';
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
  Widget build(BuildContext context) => Stack(
      children: [
        GameWidget(
          game: game,
          overlayBuilderMap: BaraddurOverlays().overlays,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ActionButton(
                onPressed: () {
                  game.MenuBtnPressed();
                },
              ),
            ),
          ],
        ),
        Column(
          children: [
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Joypad(onDirectionChanged: game.onJoyPadDirectionChanged),
                ),
              ],
            ),
          ],
        ),
      ],
    );
}

//TODO MAIN GAME PAGE GAMEBOY :
// import 'package:baraddur/helpers/actionbutton.dart';
// import 'package:baraddur/helpers/tooltipoverlay.dart';
// import 'package:flutter/material.dart';
// import 'package:flame/game.dart';
// import 'helpers/joypad.dart';
//
// import 'mytiledgame.dart';
//
// class MainGamePage extends StatefulWidget {
//   const MainGamePage({super.key});
//
//   @override
//   MainGameState createState() => MainGameState();
// }
//
// class MainGameState extends State<MainGamePage> {
//   MyTiledGame game = MyTiledGame();
//
//   @override
//   Widget build(BuildContext context) {
//     final orientation = MediaQuery.of(context).orientation;
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double sideSize = orientation == Orientation.portrait ? screenWidth : screenHeight;
//     return Scaffold(
//       backgroundColor: const Color(0xFFB9C0A4), // Gameboy greenish background
//       body: SafeArea(
//         child: Center(
//           child:
//               orientation == Orientation.portrait
//                   ? Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       // Game screen in GameBoy style
//                       buildScreen(sideSize),
//                       const Spacer(),
//                       // Control section
//                       Padding(
//                         padding: const EdgeInsets.all(24),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             buildJoypad(),
//                             const Spacer(),
//                             buildActionButton(),
//                           ],
//                         ),
//                       ),
//                     ],
//                   )
//                   : orientation == Orientation.landscape
//                   ? Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                       buildJoypad(),
//                       const Spacer(),
//                       buildScreen(sideSize),
//                       const Spacer(),
//                       buildActionButton(),
//                     ],
//                   )
//                   : Text('WTF'),
//         ),
//       ),
//     );
//   }
//
//   ActionButton buildActionButton() {
//     return ActionButton(
//       onPressed: () {
//         game.onActionButtonPressed();
//       },
//     );
//   }
//
//   Joypad buildJoypad() =>
//       Joypad(onDirectionChanged: game.onJoyPadDirectionChanged);
//
//   Widget buildScreen(double sideSize) {
//     return Container(
//       width: sideSize,
//       height: sideSize,
//       decoration: BoxDecoration(
//         color: Colors.black,
//         border: Border.all(width: 8, color: Colors.grey.shade700),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(6),
//         child: SizedBox(
//           width: 360,
//           height: 360,
//           child: GameWidget(
//             game: game,
//             overlayBuilderMap: {
//               'tooltip': (BuildContext context, MyTiledGame game) {
//                 return TooltipOverlay(
//                   position: game.tooltipPosition ?? Vector2.zero(),
//                   text: game.tooltipText ?? 'EMPTY',
//                 );
//               },
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
