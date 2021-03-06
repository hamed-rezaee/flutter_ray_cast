import 'dart:math';
import 'package:flutter/material.dart';

import 'package:flutter_ray_cast/boundary.dart';

class Helper {
  static bool hasIntersectionLine({
    Boundary ray,
    Boundary line,
  }) {
    final double x1 = line.start.dx;
    final double y1 = line.start.dy;
    final double x2 = line.end.dx;
    final double y2 = line.end.dy;

    final double x3 = ray.start.dx;
    final double y3 = ray.start.dy;
    final double x4 = ray.end.dx;
    final double y4 = ray.end.dy;

    final double den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);

    if (den == 0) {
      return false;
    }

    final double t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den;
    final double u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / den;

    return t > 0 && t < 1 && u > 0;
  }

  static Offset getIntersectionLine({
    Boundary ray,
    Boundary line,
  }) {
    final double x1 = line.start.dx;
    final double y1 = line.start.dy;
    final double x2 = line.end.dx;
    final double y2 = line.end.dy;

    final double x3 = ray.start.dx;
    final double y3 = ray.start.dy;
    final double x4 = ray.end.dx;
    final double y4 = ray.end.dy;

    final double den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    final double t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den;

    return Offset(x1 + t * (x2 - x1), y1 + t * (y2 - y1));
  }

  static double getDistanse({
    Boundary ray,
    Offset intersection,
  }) =>
      sqrt(
        pow(ray.start.dx - intersection.dx, 2) +
            pow(ray.start.dy - intersection.dy, 2),
      );
}
