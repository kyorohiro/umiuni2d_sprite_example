import 'dart:math' as math;
import 'package:umiuni2d_sprite/umiuni2d_sprite.dart';
import 'package:vector_math/vector_math_64.dart';

class PrimitiveTest extends DisplayObject {
  Image imageA = null;
  Image imageB = null;

  PrimitiveTest();

  void onInit(Stage stage) {
    stage.context.loadImage("assets/test.jpg").then((Image i) {
      imageA = i;
    });
    stage.context.loadImage("assets/icon.png").then((Image i) {
      imageB = i;
    });

  }

  void onPaint(Stage stage, Canvas canvas) {
    {
      Paint p = new Paint();
      // canvas.clipRect(null, new TinyRect(50.0, 100.0, 150.0, 280.0));
      canvas.drawRect(new Rect(50.0, 50.0, 100.0, 100.0), p);
    }

    canvas.pushMulMatrix(new Matrix4.zero()
      ..setIdentity()
      ..rotateZ(math.PI / 8.0)); //math.PI/100.0));
    {
      Paint p = new Paint();
      p.color = new Color.argb(0xff, 0xff, 0xff, 0x00);

      canvas.drawRect(new Rect(50.0, 50.0, 100.0, 100.0), p);

      p.color = new Color.argb(0xff, 0x00, 0xff, 0xff);
      p.style = PaintStyle.stroke;
      p.strokeWidth = 5.5;
      canvas.drawRect(new Rect(150.0, 150.0, 100.0, 100.0), p);

      p.style = PaintStyle.fill;
      p.color = new Color.argb(0xff, 0xff, 0xaa, 0xff);
      canvas.drawOval(new Rect(150.0, 150.0, 100.0, 100.0), p);

      p.style = PaintStyle.stroke;
      p.strokeWidth = 10.0;
      p.color = new Color.argb(0xff, 0xff, 0xff, 0xaa);
      canvas.drawOval(new Rect(150.0, 150.0, 100.0, 100.0), p);
    }

    for(int i=0;i<1;i++) {
      if (imageA != null) {
        Paint p = new Paint();
        p.color = new Color.argb(0x50, 0xff, 0xff, 0xff);
        //
        Rect src = new Rect(0.0, 0.0, imageA.w.toDouble(), imageA.h.toDouble());
        canvas.drawImageRect(
            imageA,
            src,
            new Rect(
                250.0, i+25.0, imageA.w.toDouble() / 2, imageA.h.toDouble() / 2));
      }
    }
    for(int i=0;i<1;i++) {
      if (imageB != null) {
        Paint p = new Paint();
        p.color = new Color.argb(0x50, 0xff, 0xff, 0xff);
        //
        Rect src = new Rect(0.0, 0.0, imageB.w.toDouble(), imageB.h.toDouble());
        canvas.drawImageRect(
            imageB,
            src,
            new Rect(150.0, i+125.0, imageB.w.toDouble() / 10,
                imageB.h.toDouble() / 10));
      }
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
