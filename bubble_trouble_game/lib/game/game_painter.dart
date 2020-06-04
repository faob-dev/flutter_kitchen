import 'dart:math';

import 'package:bubble_trouble_game/game/game_objects/arrow.dart';
import 'package:bubble_trouble_game/game/game_objects/ball.dart';
import 'package:bubble_trouble_game/game/game_objects/player.dart';
import 'package:bubble_trouble_game/game_nodes/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class GamePainter extends CustomPainter {
  final Size size;

  /////////////////////////////

  Arrow _arrow;
  Player _player;
  List<Ball> _balls = [];
  TextObject _levelText;

  Duration _lastTimeStamp;
  static bool fire = false;
  int _currentLevel = 0;

  ////////////////////////////

  GamePainter({
    this.size,
    AnimationController controller,
  }) : super(repaint: controller) {
    _player = Player(size: size);
    _arrow = Arrow(size: size);
    _levelText = TextObject(
      size: size,
      style: TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      position: Offset(size.width / 2, 30.0),
    );

    createNewLevel();
  }

  void onSpacePress() {
    if (!fire) {
      _arrow.fire(
        Offset(
          _player.body.x + _player.body.w / 2,
          size.height,
        ),
      );
      fire = true;
    }
  }

  void onMouseMove(Offset offset) {
    _player.move(offset);
  }

  void createNewLevel() {
    _currentLevel++;

    _balls.clear();
    final random = Random();
    int numBalls = _currentLevel;
    int splitIndex = random.nextInt(6) + 1;
    double x = size.width / numBalls;
    double r = Ball.minRadius + splitIndex * 10;
    for (int i = 0; i < numBalls; i++) {
      _balls.add(
        Ball(
          size: size,
          center: Offset((i * x + r), size.height / 2 + 50),
          splitIndex: splitIndex,
        ),
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    Duration timeStamp = SchedulerBinding.instance.currentFrameTimeStamp;

    double t = 0;
    if (_lastTimeStamp == null) {
      _lastTimeStamp = timeStamp;
    } else {
      t = (timeStamp - _lastTimeStamp).inMicroseconds /
          Duration.microsecondsPerSecond;
    }
    _lastTimeStamp = timeStamp;
    ///////////////////////////////////////////////////

    if (fire) {
      _arrow.update(t);
      _arrow.draw(canvas);

      for (int i = 0; i < _balls.length; i++) {
        Ball ball = _balls[i];
        if (ball.checkCollision(_arrow)) {
          if (ball.splitIndex - 1 == 0) {
            _balls.removeAt(i);
          } else {
            _balls.addAll(ball.split());
            _balls.removeAt(i);
          }

          fire = false;
          break;
        }
      }
      if (_balls.length == 0) {
        createNewLevel();
      }
    }

    _player.update(t);
    _player.draw(canvas);

    for (Ball ball in _balls) {
      ball.update(t);
      ball.draw(canvas);

      if (ball.checkCollision(_player)) {
        _currentLevel = 0;
        createNewLevel();
        break;
      }
    }

    _levelText.text = "LEVEL - $_currentLevel";
    _levelText.draw(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
