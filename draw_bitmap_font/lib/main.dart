//
//
// Flutter entry point
//
//

import 'package:umiuni2d_sprite_flutter/umiuni2d_sprite.dart';
import 'chara_test.dart' as test;

void main() {
  GameWidget game = new GameWidget();
  game.stage.root.addChild(new test.BitmapFontTest());
  game.start(useAnimationLoop: true);
}
