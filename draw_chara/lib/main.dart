//
//
// Flutter entry point
//
//

import 'package:umiuni2d_sprite_flutter/umiuni2d_sprite.dart';
import 'chara_test.dart';

void main() {
  GameWidget game = new GameWidget();
  game.stage.root.addChild(new CharaGameRoot());
  game.start();
}
