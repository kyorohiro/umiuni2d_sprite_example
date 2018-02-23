import 'dart:math' as math;
import 'package:umiuni2d_sprite/umiuni2d_sprite.dart';
import 'package:vector_math/vector_math_64.dart';

class PrimitiveTest extends DisplayObject {
  Image image = null;
  PrimitiveTest();

  void onInit(Stage stage) {
    stage.builder.loadImage("assets/test.jpg").then((Image i) {
      image = i;
    });
  }

  void onPaint(Stage stage, Canvas canvas) {
    {
      Paint p = new Paint();
      // canvas.clipRect(null, new TinyRect(50.0, 100.0, 150.0, 280.0));
      canvas.drawRect(null, new Rect(50.0, 50.0, 100.0, 100.0), p);
    }

    canvas.pushMulMatrix(new Matrix4.zero()
      ..setIdentity()
      ..rotateZ(math.PI / 8.0)); //math.PI/100.0));
    {
      Paint p = new Paint();
      p.color = new Color.argb(0xff, 0xff, 0xff, 0x00);

      canvas.drawRect(null, new Rect(50.0, 50.0, 100.0, 100.0), p);

      p.color = new Color.argb(0xff, 0x00, 0xff, 0xff);
      p.style = PaintStyle.stroke;
      p.strokeWidth = 5.5;
      canvas.drawRect(null, new Rect(150.0, 150.0, 100.0, 100.0), p);

      p.style = PaintStyle.fill;
      p.color = new Color.argb(0xff, 0xff, 0xaa, 0xff);
      canvas.drawOval(new Rect(150.0, 150.0, 100.0, 100.0), p);

      p.style = PaintStyle.stroke;
      p.strokeWidth = 10.0;
      p.color = new Color.argb(0xff, 0xff, 0xff, 0xaa);
      canvas.drawOval(new Rect(150.0, 150.0, 100.0, 100.0), p);
    }

    if (image != null) {
      Paint p = new Paint();
      p.color = new Color.argb(0x50, 0xff, 0xff, 0xff);
      //
      Rect src = new Rect(0.0, 0.0, image.w.toDouble(), image.h.toDouble());
      canvas.drawImageRect(
          image,
          src,
          new Rect(250.0, 25.0, image.w.toDouble() / 2, image.h.toDouble() / 2));
    }

    {
      Paint p = new Paint();
      p.color = new Color.argb(0xff, 0xff, 0xff, 0x00);
      //p.style = TinyPaintStyle.stroke;
      //
      p.strokeWidth = 5.0;
      canvas.drawLine(new Point(200.0, 200.0), new Point(500.0, 200.0), p);
    }
    canvas.popMatrix();
  }
}
