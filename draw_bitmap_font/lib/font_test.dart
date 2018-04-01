library gamelogic;

import 'dart:async';
import 'dart:math' as math;
import 'dart:convert' as conv;
import 'package:umiuni2d_sprite/umiuni2d_sprite.dart';

Future onStart(GameWidget game) async {
  game.stage.root.addChild(new BitmapFontTest());
  //
  // onshot paint request
  game.stage.markPaintshot();
  return;
}

class BitmapFontTest extends DisplayObject {
  String json = null;
  Image image = null;
  SpriteSheet sheet = null;

  void onInit(Stage stage) {
    stage.context.loadImage("assets/font_a.png").then((Image i) {
      image = i;
      update();
      // onshot paint request
      stage.markPaintshot();
    });
    stage.context.loadBytes("assets/font_a.json").then((List<int> xx) {
      json = conv.UTF8.decode(xx);
      update();
      // onshot paint request
      stage.markPaintshot();
    });
  }

  update() {
    if (json == null || image == null) {
      return;
    }
    sheet = new SpriteSheet.bitmapfont(json, image.w, image.h);
  }

  void onPaint(Stage stage, Canvas canvas) {
    if (sheet == null) {
      return;
    }
    sheet.drawText(canvas, image, "雪が降った。abcdefghijklmn", 25.0, rect: new Rect(10.0, 20.0, 200.0, 200.0), orientation: BitmapFontInfoType.horizontal);
    canvas.drawRect(new Rect(10.0, 20.0, 200.0, 200.0), new Paint()
      ..color = new Color.argb(0xff, 0xff, 0xaa, 0xaa)
      ..style = PaintStyle.stroke);
    sheet.drawText(canvas, image, "雪が降った。abcdefgh", 25.0, rect: new Rect(100.0, 100.0, 200.0, 200.0), orientation: BitmapFontInfoType.vertical);
    canvas.drawRect(new Rect(100.0, 100.0, 200.0, 200.0), new Paint()
      ..color = new Color.argb(0xff, 0xaa, 0xaa, 0xff)
      ..style = PaintStyle.stroke);
  }
}