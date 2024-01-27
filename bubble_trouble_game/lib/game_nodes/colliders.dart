import 'dart:math';

import 'package:bubble_trouble_game/game_nodes/game.dart';
import 'package:bubble_trouble_game/game_nodes/shapes.dart';

mixin class Collider {
  bool checkCollision(GameObject other) => false;

  bool checkCircleRectCollision(Circle circle, Rectangle rect) {
    double cx = circle.cx;
    double cy = circle.cy;
    double radius = circle.radius;

    double rx = rect.x;
    double ry = rect.y;
    double rw = rect.w;
    double rh = rect.h;

    double testX = cx;
    double testY = cy;

    if (cx < rx) {
      testX = rx;
    } else if (cx > rx + rw) {
      testX = rx + rw;
    }
    if (cy < ry) {
      testY = ry;
    } else if (cy > ry + rh) {
      testY = ry + rh;
    }

    double distX = cx - testX;
    double distY = cy - testY;
    double distance = sqrt((distX * distX) + (distY * distY));

    if (distance <= radius) {
      return true;
    }
    return false;
  }
}
