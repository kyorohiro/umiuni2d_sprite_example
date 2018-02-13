library gamelogic;

import 'dart:async';
import 'dart:math' as math;
import 'package:umiuni2d_sprite/umiuni2d_sprite.dart' as umiuni2d;


//
// Game Loop
//
Future onStart(umiuni2d.GameWidget _builder) async {
  umiuni2d.Sprite chara = await createChara(_builder);
  umiuni2d.Stage _stage = _builder.stage;

  _stage.root.addChild(chara);
  chara.x = 200.0;
  chara.y = 150.0;
  chara.centerX = 100.0;
  chara.centerY = 100.0;
  chara.scaleX = 0.8;
  chara.scaleY = 0.8;

  while (_stage != null) {
    //
    // calc rorate
    chara.rotation = math.PI * ((new DateTime.now().millisecondsSinceEpoch) / 1000);

    //
    //
    chara.currentFrameID = (chara.currentFrameID < chara.numOfFrameID?chara.numOfFrameID+1:0);

    //
    // request redraw
    _stage.markPaintshot();

    //
    // sleep
    await new Future.delayed(new Duration(milliseconds: 50));
  }
  return;
}

//
// Create Character
//
Future<umiuni2d.Sprite> createChara(umiuni2d.GameWidget builder) async {
  umiuni2d.Image img = await builder.loadImage("assets/chara.png");
  return new umiuni2d.Sprite.simple(img, srcs: [
    new umiuni2d.Rect(0.0, 0.0, 200.0, 200.0),
    new umiuni2d.Rect(200.0, 0.0, 200.0, 200.0),
    new umiuni2d.Rect(0.0, 200.0, 200.0, 200.0)
  ], dsts: [
    new umiuni2d.Rect(0.0, 0.0, 200.0, 200.0),
    new umiuni2d.Rect(0.0, 0.0, 200.0, 200.0),
    new umiuni2d.Rect(0.0, 0.0, 200.0, 200.0)
  ], transforms: [
    umiuni2d.CanvasTransform.NONE,
    umiuni2d.CanvasTransform.NONE,
    umiuni2d.CanvasTransform.NONE
  ]);
}
