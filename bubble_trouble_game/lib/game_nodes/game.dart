import 'package:bubble_trouble_game/game_nodes/colliders.dart';
import 'package:bubble_trouble_game/game_nodes/shapes.dart';
import 'package:flutter/material.dart';

abstract class Game {
  final Size size;

  Game({
    required this.size,
  });

  void update(double t) {}

  void draw(Canvas canvas) {}
}

abstract class GameObject extends Game with Collider {
  Shape get body;
  Paint paint = Paint()..color = Colors.white;

  GameObject({
    required super.size,
  });
}

class TextObject extends Game {
  String text;
  TextStyle style;
  Offset position;

  TextObject({
    required super.size,
    this.text = "",
    this.style = const TextStyle(),
    this.position = Offset.zero,
  });

  String? _oldText;
  late TextPainter _textPainter;

  @override
  void draw(Canvas canvas) {
    if (text != _oldText) {
      _textPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: style,
        ),
        textDirection: TextDirection.ltr,
      )..layout();
    }
    _textPainter.paint(
        canvas,
        Offset(
          position.dx - _textPainter.width / 2,
          position.dy - _textPainter.height / 2,
        ));
    _oldText = text;
  }
}
