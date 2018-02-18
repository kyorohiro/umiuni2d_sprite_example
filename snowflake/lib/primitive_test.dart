import 'dart:math' as math;
import 'package:umiuni2d_sprite/umiuni2d_sprite.dart';
import 'package:umiuni2d_sprite/umiuni2d_sprite_utils.dart';

import 'package:vector_math/vector_math_64.dart';
import 'dart:convert' as conv;

//import 'package:umiuni2d/tinygame.dart';
//import 'package:umiuni2d/tinygame_ex.dart';
import 'dart:math' as math;

class SnowTest extends DisplayObject {
  SnowTest() {
  }
  void onInit(Stage stage) {
    print("## onInit ");
    GameWidget builder = stage.builder;
    Snows snows = new Snows();
    addChild(snows);
    for (int i = 0; i < 100; i++) {
      snows.addIdName("S001.png", 0.4, randomSize: true);
      snows.addIdName("S002.png", 0.4, randomSize: true);
    }

    builder.loadImage("assets/se_play.png").then((Image i) {
      snows.bgimg = i;
    });
    builder.loadBytes("assets/se_play.json").then((List<int> x) {
      snows.info = new SpriteSheetInfo.fronmJson(conv.UTF8.decode(x));
    });
  }

  bool onTouch(Stage stage, int id, StagePointerType type, double globalX, globalY) {
    return false;
  }
}

class Snow {
  double x = 0.0;
  double y = 0.0;
  double dx = 0.0;
  double dy = 0.0;
  double size = 1.0;
  String type = "BG001.png";
  bool randomSize;
  double baseSize = 1.0;
  math.Random r = new math.Random();
  double getWidth(double baseW) => baseW * size;
  double getHeight(double baseH) => baseH * size;
  Rect tmp = new Rect(0.0, 0.0, 0.0, 0.0);
  List<Object> cache = [];
  Snow(this.type, this.baseSize, {this.randomSize: false}) {
    reset();
  }
  reset() {
    x = r.nextDouble() * 400;
    y = -1 * r.nextDouble() * 100 - 100;
    dx = r.nextDouble() - 0.5;
    dy = r.nextDouble();
    if (randomSize) {
      size = this.baseSize * (r.nextDouble() * 0.75 + 0.25);
    } else {
      size = this.baseSize;
    }
  }
}

class Snows extends DisplayObject {
  math.Random r = new math.Random();
  Image bgimg;
  SpriteSheetInfo info;
  List<Snow> idnames = [];
  Paint p = new Paint();

  Snows() {}
  addIdName(String name, double baseSize, {bool randomSize: false}) {
    idnames.add(new Snow(name, baseSize, randomSize: randomSize));
  }

  void onPaint(Stage stage, Canvas canvas) {
    if (bgimg != null && info != null) {
      for (Snow se in idnames) {
        Size s = info.frameFromFileName(se.type).sourceSize;
        se.tmp.x = se.x;
        se.tmp.y = se.y;
        se.tmp.w = se.getWidth(s.w);
        se.tmp.h = se.getHeight(s.h);
        canvas.drawImageRect(stage, bgimg, info.frameFromFileName(se.type).srcRect, se.tmp, p, cache:se.cache);
        se.x += se.dx;
        se.y += se.dy;
        se.dy += 0.001;
        if (se.x + se.getWidth(s.w) < 0 || se.x - se.getWidth(s.w) > 400 || se.y - se.getHeight(s.h) > 300) {
          se.reset();
        }
      }
    }
  }
}