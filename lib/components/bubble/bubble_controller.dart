import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flappy_bird/components/bubble/bubble_decoration.dart';
import 'package:flappy_bird/components/pipe/pipe_line.dart';
import 'package:flutter/material.dart';

class BubbleController extends GameComponent with ChangeNotifier {
  final double speed;
  int currentInterval = 1000;
  int bubbleCount = 0;

  BubbleController({required this.speed});
  @override
  void update(double dt) {
    if (checkInterval('AddsBubble', currentInterval, dt)) {
      double offsety = Random().nextInt(100).toDouble()-25;
      double offsetx = Random().nextInt(100).toDouble()-25;
      final offset=Vector2(offsetx, offsety);
      gameRef.add(
        BubbleDecoration(speed: 80, offset: offset,)
      );
    }
    super.update(dt);
  }

  void countScore() {
    bubbleCount++;
    notifyListeners();
  }

  void reset() {
    bubbleCount = 0;
    notifyListeners();
  }
}
