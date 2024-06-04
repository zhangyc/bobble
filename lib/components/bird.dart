import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:flappy_bird/components/pipe/pipe.dart';
import 'package:flappy_bird/components/pipe/pipe_line.dart';
import 'package:flappy_bird/components/pipe/pipe_line_controller.dart';
import 'package:flappy_bird/util/spritesheet.dart';
import 'package:flutter/material.dart';

class Bird extends PlatformPlayer with HandleForces, TapGesture {
  Vector2? _initialPosition;
  Bird({required super.position})
      : super(
          size: Vector2(34, 24),
          animation: PlatformAnimations(
            idleRight: Spritesheet.flapMidle,
            runRight: Spritesheet.flapMidle,
            jump: PlatformJumpAnimations(
              jumpUpRight: Spritesheet.flapDown,
              jumpDownRight: Spritesheet.flapUp,
            ),
          ),
          countJumps: 1
        ) {
    _initialPosition = position.clone();
    anchor = Anchor.center;
  }
  Timer? _timer;
  @override
  void onTapDownScreen(GestureEvent event) {
    if (_canClick) {
      jump(force: true, jumpSpeed: 160*2);
      // 点击事件触发后，设置_canClick为false，防止在1秒内再次触发点击事件
      _canClick = false;
      // 1秒后将_canClick重新设置为true，使得下一个点击事件可以被触发
      _timer=Timer(1, onTick: () {
        _canClick = true;
      });
    }
    super.onTapDownScreen(event);
  }

  final graus90 = 1.0472;
  bool _canClick = true;

  @override
  void update(double dt) {
    _timer?.update(dt);
    if(y<=5){
      y=5;
    }
    angle = lerpDouble(angle, (velocity.y > 0 ? 1 : -1) * graus90, dt) ?? 0;
    super.update(dt);
  }
  @override
  void onTap() {}

  @override
  Future<void> onLoad() {
    add(RectangleHitbox(
      size: Vector2.all(24),
      position: Vector2(5, 0),
    ));
    return super.onLoad();
  }

  @override
  bool onBlockMovement(Set<Vector2> intersectionPoints, GameComponent other) {
    if(other is Pipe){
      gameRef.pauseEngine();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('Game Over'),
            actions: [
              ElevatedButton(
                onPressed: _resetGame,
                child: const Text('Try Again'),
              ),
            ],
          );
        },
      );
    }
    return super.onBlockMovement(intersectionPoints, other);
  }

  void _resetGame() {
    gameRef.query<PipeLineController>().first.reset();
    gameRef.query<PipeLine>().forEach((element) => element.removeFromParent());
    position = _initialPosition!.clone();
    gameRef.resumeEngine();
    Navigator.pop(context);
  }
}
