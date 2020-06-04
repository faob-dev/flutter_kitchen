import 'package:bubble_trouble_game/game_nodes/game.dart';
import 'package:bubble_trouble_game/game_nodes/shapes.dart';
import 'package:flutter/material.dart';

class Player extends GameObject {
  final double _strokeWidth = 2;
  Offset _moveOffset = Offset.zero;

  Rectangle _body;

  Rectangle get body => _body;

  Player({@required Size size}) : super(size: size) {
    _body = Rectangle(x: 0, y: 0, w: 15, h: 65);
  }

  void move(Offset offset) {
    _moveOffset = offset;
  }

  @override
  void update(double t) {
    _body.x = (_moveOffset.dx - _body.w / 2)
        .clamp(_strokeWidth / 2, size.width - _body.w - _strokeWidth / 2);

    _body.y = size.height - _body.h;
  }

  @override
  void draw(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(_body.x, _body.y, _body.w, _body.h),
      paint
        ..style = PaintingStyle.stroke
        ..strokeWidth = _strokeWidth,
    );
  }
}
