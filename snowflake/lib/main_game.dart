import 'dart:math' as math;
import 'package:umiuni2d_sprite/umiuni2d_sprite.dart';
import 'package:umiuni2d_sprite/umiuni2d_sprite_utils.dart';
import 'dart:convert' as conv;
import 'dart:async';


Future onStart(GameWidget widget) async {
  int wait = 15;
  int startTime = new DateTime.now().millisecondsSinceEpoch;
  int curretTime = startTime;
  int prevTime = startTime;

  int fpsStartTime = 0;
  int count = 0;

  widget.stage.root.addChild(new SnowTest());
  do {
    if(!widget.stage.startable) {
      //
      // in preparation
      await new Future.delayed(new Duration(milliseconds: 20));
      continue;
    }
    if(count >= 1000) {
      int t = fpsStartTime;
      fpsStartTime = new DateTime.now().millisecondsSinceEpoch;
      print("fps(logic)c: ${((fpsStartTime-t)/1000)}, fps:${(count~/((fpsStartTime-t)/1000))}");
      count = 0;
    }
    if(count == 0) {
      fpsStartTime = new DateTime.now().millisecondsSinceEpoch;
    }
    count++;
    curretTime = new DateTime.now().millisecondsSinceEpoch;
    widget.stage.kick(curretTime);
    widget.stage.markPaintshot();
    await new Future.delayed(
        new Duration(milliseconds:
        (curretTime-prevTime > wait*2?1:wait*2-(curretTime-prevTime))
        ));
    prevTime = curretTime;
  } while(true);
}

class SnowTest extends DisplayObject {

  void onInit(Stage stage) {
    Snows snows = new Snows();
    addChild(snows);

    new Future(() async  {
      snows.imageSets  = await stage.context.loadImage("assets/se_play.png");
      List<int> x = await stage.context.loadBytes("assets/se_play.json");
      snows.spriteInfo = new SpriteSheetInfo.fronmJson(conv.UTF8.decode(x));
      for (int i = 0; i < 50; i++) {
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
      this.type)
//      : super.empty(w:dsts[0].w,h:dsts[0].h, color:new Color(0xaaaa00bb)) {
        : super.simple(img,srcs:srcs, dsts:dsts, transforms:transforms) {
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