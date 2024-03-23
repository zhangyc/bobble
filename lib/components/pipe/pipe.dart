import 'package:bonfire/bonfire.dart';
import 'package:flappy_bird/util/spritesheet.dart';

class Pipe extends GameDecoration {
  static const pipeHeight = 320.0;
  static const pipeWidth = 52.0;
  final bool inverted;
  Pipe({
    required super.position,
    this.inverted = false,
  }) : super.withSprite(
          size: Vector2(pipeWidth, pipeHeight),
          sprite: Spritesheet.pipe,
        );
  @override
  void render(Canvas canvas) {
    if (inverted) {
      canvas.save();
      _doCanvasFlip(canvas);
      super.render(canvas);
      canvas.restore();
    } else {
      super.render(canvas);
    }
  }

  @override
  Future<void> onLoad() {
    add(
      RectangleHitbox(
        size: size,
        isSolid: true,
      ),
    );
    return super.onLoad();
  }

  void _doCanvasFlip(Canvas canvas) {
    canvas.translate(center.x, center.y);
    canvas.scale(
      1,
      -1,
    );
    canvas.translate(-center.x, -center.y);
  }
}