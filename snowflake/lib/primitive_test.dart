import 'dart:math' as math;
import 'package:umiuni2d_sprite/umiuni2d_sprite.dart';
import 'package:umiuni2d_sprite/umiuni2d_sprite_utils.dart';
import 'dart:convert' as conv;
import 'dart:async';

class SnowTest extends DisplayObject {

  void onInit(Stage stage) {
    GameWidget builder = stage.builder;
    Snows snows = new Snows();
    addChild(snows);

    new Future(() async  {
      snows.imageSets  = await builder.loadImage("assets/se_play.png");
      List<int> x = await builder.loadBytes("assets/se_play.json");
      snows.spriteInfo = new SpriteSheetInfo.fronmJson(conv.UTF8.decode(x));
      for (int i = 0; i < 100; i++) {
        snows.addIdName("S001.png");
        snows.addIdName("S002.png");
      }
    });
  }
}

class Snow extends Sprite  {
  double dx = 0.0;
  double dy = 0.0;
  double dr = 0.0;
  String type = "BG001.png";
  math.Random r = new math.Random();
  Rect tmp = new Rect(0.0, 0.0, 0.0, 0.0);
  List<Object> cache = [];

  Snow(Image img,
      List<Rect> srcs,List<Rect> dsts, List<CanvasTransform> transforms,
      this.type) :super.simple(img,srcs:srcs, dsts:dsts, transforms:transforms) {
    reset();
  }

  reset() {
    x = r.nextDouble() * 400;
    y = -1 * r.nextDouble() * 100 - 100;
    dx = r.nextDouble() - 0.5;
    dy = r.nextDouble();
    dr = r.nextDouble() -0.5;
    this.rotation = r.nextDouble();
    double size = (r.nextDouble() * 0.75 + 0.25);
    scaleY = size;
    scaleX = size;
  }
}

class Snows extends DisplayObject {
  math.Random r = new math.Random();
  Image imageSets;
  SpriteSheetInfo spriteInfo;
  List<Snow> spriteNames = [];

  Snows();

  addIdName(String name) {
    Snow s = new Snow(imageSets,
        [spriteInfo.frameFromFileName(name).srcRect],
        [new Rect(0.0, 0.0, 50.0, 50.0)],
        [CanvasTransform.NONE],
        name);
    s.centerX = 25.0;
    s.centerY = 25.0;

    addChild(s);
    spriteNames.add(s);
  }

  void onPaint(Stage stage, Canvas canvas) {
    if (imageSets != null && spriteInfo != null) {
      for (Snow se in spriteNames) {
        Size s = spriteInfo.frameFromFileName(se.type).sourceSize;
        se.x += se.dx;
        se.y += se.dy;
        se.rotation += se.dr;
        se.dy += 0.001;
        if (se.x + se.w < 0 || se.x - se.w > 400 || se.y - se.h > 300) {
          se.reset();
        }
      }
    }
  }
}