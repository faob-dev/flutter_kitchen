import 'package:bubble_trouble_game/game/game_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameWidget extends StatefulWidget {
  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget>
    with SingleTickerProviderStateMixin {
  FocusNode _focusNode;
  GamePainter _gamePainter;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xFF2e282a),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return RawKeyboardListener(
              autofocus: true,
              focusNode: _focusNode,
              onKey: (RawKeyEvent event) {
                if (event.logicalKey == LogicalKeyboardKey.space) {
                  _gamePainter.onSpacePress();
                }
              },
              child: MouseRegion(
                onHover: (e) => _gamePainter.onMouseMove(e.localPosition),
                child: CustomPaint(
                  painter: _gamePainter = GamePainter(
                    size: constraints.biggest,
                    controller: _controller,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
