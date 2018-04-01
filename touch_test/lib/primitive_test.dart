import 'dart:math' as math;
import 'package:umiuni2d_sprite/umiuni2d_sprite.dart';
import 'package:vector_math/vector_math_64.dart';

class PrimitiveTest extends DisplayObject {
  PrimitiveTest() {
    // for container test
    mat.rotateZ(math.PI / 10);
  }

  Map<int, List<double>> touches = {};
  GameWidget builder;
  void onInit(Stage stage) {
    GameWidget builder = stage.context;
  }

  bool onTouch(Stage stage, int id, StagePointerType type, double globalX, globalY) {
    var v = stage.getCurrentPositionOnDisplayObject(globalX, globalY);
    double x = v.x;
    double y = v.y;
    print("${x} ${y} ${globalX} ${globalY}");
    touches[id] = [x, y];
    if (type == StagePointerType.UP || type == StagePointerType.CANCEL) {
      touches.remove(id);
    }
    return false;
  }

  void onPaint(Stage stage, Canvas canvas) {
    Paint p = new Paint();
    for (int k in touches.keys) {
      List<double> xy = touches[k];
      p.color = new Color.argb(0xff, 0xff, 0xff, 0x00);
      p.style = (k%2==0?PaintStyle.fill:PaintStyle.stroke);
      p.strokeWidth = 2.5;
      canvas.drawRect(new Rect(xy[0] - 25.0, xy[1] - 25.0, 50.0, 50.0), p);
    }
  }
}
