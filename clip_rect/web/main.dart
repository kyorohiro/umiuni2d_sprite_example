//
//
// WebGL entry point
//
//

import 'package:umiuni2d_sprite_html5/umiuni2d_sprite.dart';
import 'package:example/cliprect_test.dart';

void main() {
  GameWidget game = new GameWidget();
  game.start(onStart: onStart);
}

