import 'dart:async';

import 'package:baraddur/mytiledgame.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class BeerIconComponent extends SpriteComponent with HasGameRef<MyTiledGame> {

  BeerIconComponent({super.size, super.position, super.anchor});

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('Menu/Boissons/Icons/beer_icon.png');
    opacity = 0.0;
    add(OpacityEffect.fadeIn(EffectController(duration: 1)));
    //TODO : fade out marche pas car hideToolTip fait un parent?.remove(_myComponent);
    add(OpacityEffect.fadeOut(EffectController(duration: 1)));
  }
}