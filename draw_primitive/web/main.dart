//
//
// WebGL entry point
//
//

import 'package:umiuni2d_sprite_html5/umiuni2d_sprite.dart';
import 'package:example/primitive_test.dart';

void main() {
  GameWidget game = new GameWidget();
  game.stage.root.addChild(new PrimitiveTest());
  game.start();
}

