//
//
// Flutter entry point
//
//

import 'package:umiuni2d_sprite_flutter/umiuni2d_sprite.dart';
import 'cliprect_test.dart';

void main() {
  GameWidget game = new GameWidget();
  game.start(onStart: onStart);
}
