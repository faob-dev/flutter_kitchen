abstract class Shape {}

class Circle extends Shape {
  double cx;
  double cy;
  double radius;

  Circle({
    this.cx = 0,
    this.cy = 0,
    this.radius = 0,
  });

  @override
  String toString() {
    return "Circle[$cx, $cy, $radius]";
  }
}

class Rectangle extends Shape {
  double x;
  double y;
  double w;
  double h;

  Rectangle({
    this.x = 0,
    this.y = 0,
    this.w = 0,
    this.h = 0,
  });

  @override
  String toString() {
    return "Rectangle[$x, $y, $w, $h]";
  }
}
