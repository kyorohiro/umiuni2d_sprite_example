import 'dart:math' as math;
import 'package:umiuni2d_sprite/umiuni2d_sprite.dart';
import 'package:vector_math/vector_math_64.dart';

class PrimitiveTest extends DisplayObject {
  Image image = null;
  PrimitiveTest();

  void onInit(Stage stage) {
    stage.context.loadImage("assets/test.jpg").then((Image i) {
      image = i;
    });
  }

  void onPaint(Stage stage, Canvas canvas) {
    {
      Paint p = new Paint();
      p.color = new Color.argb(0x55, 0xff, 0x44, 0x44);
      canvas.drawRect(new Rect(0.0, 0.0, 400.0, 300.0), p);
      canvas.clipRect(new Rect(10.0, 10.0, 380.0, 280.0));
      canvas.drawRect(new Rect(0.0, 0.0, 400.0, 300.0), p);
      canvas.clipRect(new Rect(100.0, 20.0, 100.0, 300.0));
      canvas.drawRect(new Rect(0.0, 0.0, 400.0, 300.0), p);
    }
    {
      canvas.clearClip();
      canvas.clipRect(new Rect(0.0, 150.0, 400.0, 150.0));
      Paint p = new Paint();
      p.color = new Color.argb(0xff, 0x44, 0x44, 0xff);
      canvas.drawRect(new Rect(0.0, 150.0, 400.0, 300.0), p);
    }
  }
}
