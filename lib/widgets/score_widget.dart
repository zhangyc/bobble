import 'package:flappy_bird/components/bubble/bubble_controller.dart';
import 'package:flappy_bird/components/pipe/pipe_line_controller.dart';
import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  static const name = 'score';
  final PipeLineController controller;
  final BubbleController bubbleController;
  const ScoreWidget({super.key, required this.controller, required this.bubbleController});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return Material(
          type: MaterialType.transparency,
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    controller.countPipesWin.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '吸附的泡泡个数：${bubbleController.bubbleCount}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
