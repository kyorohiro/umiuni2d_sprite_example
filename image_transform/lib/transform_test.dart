import 'dart:math' as math;
import 'package:umiuni2d_sprite/umiuni2d_sprite.dart';
import 'package:vector_math/vector_math_64.dart';
import 'dart:async';

Future onStart(GameWidget game) async {
  game.stage.root.addChild(new TransformTest());
  game.stage.markPaintshot();
}

class TransformTest extends DisplayObject {
  GameWidget builder;
  Image image = null;
  TransformTest();

  void onInit(Stage stage) {
    stage.context.loadImage("assets/icon.png").then((Image i) {
      image = i;
      stage.markPaintshot();
    });
  }
  void onPaint(Stage stage, Canvas canvas) {
    if(image == null) {
      return;
    }
    {
      Paint p = new Paint();
      canvas.drawImageRect(
          image,
          new Rect(0.0,0.0, 1.0*image.w, 1.0*image.h),
          new Rect(0.0,50.0, 40.0, 40.0),
          transform: CanvasTransform.NONE);
      canvas.drawImageRect(
          image,
          new Rect(0.0,0.0, 1.0*image.w, 1.0*image.h),
          new Rect(0.0,100.0, 40.0, 40.0),
          transform: CanvasTransform.ROT90);
      canvas.drawImageRect(
          image,
          new Rect(0.0,0.0, 1.0*image.w, 1.0*image.h),
          new Rect(0.0,150.0, 40.0, 40.0),
          transform: CanvasTransform.ROT180);
      canvas.drawImageRect(
          image,
          new Rect(0.0,0.0, 1.0*image.w, 1.0*image.h),
          new Rect(0.0,200.0, 40.0, 40.0),
          transform: CanvasTransform.ROT270);
    }
    {
      Paint p = new Paint();
      canvas.drawImageRect(
          image,
          new Rect(0.0,0.0, 1.0*image.w, 1.0*image.h),
          new Rect(100.0,50.0, 40.0, 40.0),
          transform: CanvasTransform.MIRROR);
      canvas.drawImageRect(
          image,
          new Rect(0.0,0.0, 1.0*image.w, 1.0*image.h),
          new Rect(100.0,100.0, 40.0, 40.0),
          transform: CanvasTransform.MIRROR_ROT90);
      canvas.drawImageRect(
          image,
          new Rect(0.0,0.0, 1.0*image.w, 1.0*image.h),
          new Rect(100.0,150.0, 40.0, 40.0),
          transform: CanvasTransform.MIRROR_ROT180);
      canvas.drawImageRect(
          image,
          new Rect(0.0,0.0, 1.0*image.w, 1.0*image.h),
          new Rect(100.0,200.0, 40.0, 40.0),
          transform: CanvasTransform.MIRROR_ROT270);
    }
  }
}
