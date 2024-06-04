import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import '../bird.dart';
import '../scenario/base.dart';
import 'bubble_controller.dart';

class BubbleDecoration extends GameDecoration with Movement,RandomMovement,Follower{
  final double radius;
  final Vector2 offset;
  BubbleDecoration({this.radius = 32,double speed = 50,required this.offset})
      : super(
    position: Vector2.zero(),
    size: Vector2.all(radius * 2),
  ){
    this.speed = speed;
    moveLeft();
    movementOnlyVisible = false;

  }
  @override
  bool onComponentTypeCheck(PositionComponent other) {
    if (other is ParallaxBaseBackground) {
      return false;
    }
    return super.onComponentTypeCheck(other);
  }
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other is Bird){
      controller.countScore();
      // speed=gameRef.player!.speed;
      // moveRight(speed: speed);
      // setupFollower(target: gameRef.player, offset: Vector2.zero());
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }
  late BubbleController controller;
  @override
  Future<void> onLoad() {
    controller= gameRef.query<BubbleController>().first;
    final mapSize = gameRef.map.size;
    position = Vector2(
      mapSize.x + offset.x,
      (mapSize.y - size.y) / 2 + offset.y,
    );
    add(
      CircleHitbox(
        radius: radius,
        isSolid: true,
      ),
    );
    return super.onLoad();
  }
  bool _goOutOnTheLeft() {
    return position.x < -(size.x);
  }
  // @override
  // int get priority => LayerPriority.BACKGROUND;
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..color = Colors.red;
    canvas.drawCircle(Offset(0, 0), radius, paint);
  }

  @override
  void update(double dt) {
    // runRandomMovement(dt,speed: 80,directions: RandomMovementDirections.vertically);
    super.update(dt);

    if (_goOutOnTheLeft() && !isRemoving) {
      removeFromParent();
    }
  }
}