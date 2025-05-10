import 'dart:async';
import 'dart:developer';

import 'package:baraddur/mytiledgame.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/cupertino.dart';

class InterrogationDotComponent extends SpriteComponent with TapCallbacks, HasGameReference<MyTiledGame> {

  InterrogationDotComponent({super.position, super.size, super.anchor});

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('interrogationDot.png');
    opacity = 0.0;
    add(OpacityEffect.fadeIn(EffectController(duration: 1)));
    //TODO : fade out marche pas car hideToolTip fait un parent?.remove(_myComponent);
    add(OpacityEffect.fadeOut(EffectController(duration: 1)));
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    game.onActionButtonPressed();
  }
}
