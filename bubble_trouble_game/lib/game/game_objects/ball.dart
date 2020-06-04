import 'package:bubble_trouble_game/game_nodes/game.dart';
import 'package:bubble_trouble_game/game_nodes/shapes.dart';
import 'package:flutter/material.dart';

class Ball extends GameObject {
  int splitIndex = 0;
  double _vx = 0;
  double _vy = 0;
  final double _speed = 30;
  static const double minRadius = 8;

  Circle _body;

  Circle get body => _body;

  Ball({
    @required Size size,
    Offset center = Offset.zero,
    Offset velocity = const Offset(5, -12),
    int splitIndex,
  }) : super(size: size) {
    this._vx = velocity.dx;
    this._vy = velocity.dy;
    this.splitIndex = splitIndex;

    _body = Circle(
      cx: center.dx + 0,
      cy: center.dy,
      radius: minRadius + splitIndex * 10,
    );
  }

  List<Ball> split() {
    return [
      Ball(
        size: size,
        center: Offset(_body.cx, _body.cy),
        velocity: Offset(5, -12),
        splitIndex: this.splitIndex - 1,
      ),
      Ball(
        size: size,
        center: Offset(_body.cx, _body.cy),
        velocity: Offset(-5, -12),
        splitIndex: this.splitIndex - 1,
      )
    ];
  }

  void update(double t) {
    _body.cx += _vx * t * _speed;
    _body.cy += _vy * t * _speed;

    _vy += t * _speed;

    if (_body.cy > size.height - _body.radius) {
      _vy = -20;
      _body.cy = size.height - _body.radius;
    }
    if (_body.cx > size.width - _body.radius) {
      _vx *= -1;
      _body.cx = size.width - _body.radius;
    }
    if (_body.cx < _body.radius) {
      _vx *= -1;
      _body.cx = _body.radius;
    }
  }

  @override
  void draw(Canvas canvas) {
    canvas.drawCircle(
      Offset(_body.cx, _body.cy),
      _body.radius,
      paint,
    );
  }

  @override
  bool checkCollision(GameObject other) {
    if (other.body is Rectangle) {
      return checkCircleRectCollision(this.body, other.body);
    }
    return false;
  }
}
