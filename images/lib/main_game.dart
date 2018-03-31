import 'dart:math' as math;
import 'package:umiuni2d_sprite/umiuni2d_sprite.dart';
import 'dart:convert' as conv;
import 'dart:async';
import 'package:vector_math/vector_math_64.dart';


Future onStart(GameWidget widget) async {
  int wait = 20;
  int startTime = new DateTime.now().millisecondsSinceEpoch;
  int curretTime = startTime;
  int prevTime = startTime;

  int fpsStartTime = 0;
  int count = 0;

  widget.stage.root.addChild(new ImageView());
  do {
    if(!widget.stage.startable) {
      //
      // in preparation
      await new Future.delayed(new Duration(milliseconds: 20));
      continue;
    }
    if(count > 60) {
      int t = fpsStartTime;
      fpsStartTime = new DateTime.now().millisecondsSinceEpoch;
      print("fps(logic) ${(count~/((fpsStartTime-t)/1000))}");
      count = 0;
    }
    if(count == 0) {
      fpsStartTime = new DateTime.now().millisecondsSinceEpoch;
    }
    count++;
    curretTime = new DateTime.now().millisecondsSinceEpoch;
    widget.stage.kick(new DateTime.now().millisecondsSinceEpoch);
    prevTime = curretTime;
    widget.stage.markPaintshot();
    await new Future.delayed(
        new Duration(milliseconds:
        (curretTime-prevTime > wait?1:wait-(curretTime-prevTime))
        ));
  } while(true);
}

class ImageView extends DisplayObjectEx  {
  int index = 0;
  List<String> res = <String>[
    "assets/bg_clear01.png", "assets/bg_clear02.png", "assets/bg_clear03.png",
    "assets/bg_clear04.png", "assets/bg_clear05.png","assets/bg_clear06.png"];

  ExButton exButton = null;
  @override
  void onInit(Stage stage) {
    super.onInit(stage);
    print("on init>>>");
    _init(stage.context);
    addExtension(exButton = new ExButton(this, "l", (String l){
      //print(">> touch ${exButton.registerUp} && ${exButton.registerDown}");
      //exButton.registerUp = false; exButton.registerDown = false;
    }));
  }

  bool checkFocus(double localX, double localY) => true;

  Future<ImageView> _init(GameWidget context) async {
    //exButton.registerUp = false; exButton.registerDown = false;
    for(String f in res) {
      context.loadAndCacheImage(f);
    }
    return this;
  }

  @override
  void onPaint(Stage stage, Canvas canvas) {
    super.onPaint(stage, canvas);
    GameWidget context = stage.context;

    Image img = context.getCachedImage(res[index]);
    if(img != null) {
      canvas.drawImageRect(img,
          new Rect(0.0, 0.0, img.w.toDouble(), img.h.toDouble()),
          new Rect(0.0, 0.0, img.w.toDouble(), img.h.toDouble()));
    }
  }

  @override
  bool onTouch(Stage stage, int id, StagePointerType type, double globalX, globalY) {
    super.onTouch(stage, id, type, globalX, globalY);
    Vector3 pos = stage.getCurrentPositionOnDisplayObject(globalX, globalY);
    if(exButton.registerUp && exButton.registerDown) {
      if (pos.x < stage.w / 2) {
        index++;
        if (index >= res.length) {
          index = res.length - 1;
        }
      } else {
        index--;
        if (index <= 0) {
          index = 0;
        }
      }
      exButton.registerUp =false; exButton.registerDown = false;
    }
    return false;
  }
}