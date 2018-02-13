//
//
// WebGL entry point
//
//

import 'package:umiuni2d_sprite_html5/umiuni2d_sprite.dart';
import 'package:example/chara_test.dart' as test;

void main() {
  GameWidget game = new GameWidget();
  game.start(onStart:test.onStart);
}

