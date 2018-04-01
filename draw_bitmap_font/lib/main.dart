//
//
// Flutter entry point
//
//

import 'package:umiuni2d_sprite_flutter/umiuni2d_sprite.dart';
import 'font_test.dart' as test;

void main() {
  GameWidget game = new GameWidget();
  game.start(onStart: test.onStart);
}
