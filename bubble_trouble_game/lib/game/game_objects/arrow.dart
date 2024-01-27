import 'package:bubble_trouble_game/game/game_painter.dart';
import 'package:bubble_trouble_game/game_nodes/game.dart';
import 'package:bubble_trouble_game/game_nodes/shapes.dart';
import 'package:flutter/material.dart';

class Arrow extends GameObject {
  final double _speed = 1000;

  late Rectangle _body;

  @override
  Rectangle get body => _body;

  Arrow({required super.size}) {
    _body = Rectangle(x: 0, y: 0, w: 4, h: size.height);
  }

  void fire(Offset fireOffset) {
    _body.x = fireOffset.dx - _body.w / 2;
    _body.y = fireOffset.dy;
  }

  @override
  void update(double t) {
    _body.y -= t * _speed;

    if (_body.y <= 0) {
      GamePainter.fire = false; //todo handle it using callback
    }
  }

  @override
  void draw(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(_body.x, _body.y, _body.w, _body.h),
      paint,
    );
  }
}
