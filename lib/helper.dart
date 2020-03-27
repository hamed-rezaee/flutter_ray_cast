import 'dart:math';
import 'package:flutter/material.dart';

import 'package:flutter_ray_cast/boundary.dart';

class Helper {
  static bool hasIntersection(Boundary ray, Boundary wall) {
    double x1 = wall.start.dx;
    double y1 = wall.start.dy;
    double x2 = wall.end.dx;
    double y2 = wall.end.dy;

    double x3 = ray.start.dx;
    double y3 = ray.start.dy;
    double x4 = ray.end.dx;
    double y4 = ray.end.dy;

    double den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);

    if (den == 0) {
      return false;
    }

    double t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den;
    double u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / den;

    return t > 0 && t < 1 && u > 0;
  }

  static Offset getIntersection(Boundary ray, Boundary wall) {
    double x1 = wall.start.dx;
    double y1 = wall.start.dy;
    double x2 = wall.end.dx;
    double y2 = wall.end.dy;

    double x3 = ray.start.dx;
    double y3 = ray.start.dy;
    double x4 = ray.end.dx;
    double y4 = ray.end.dy;

    double den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    double t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den;

    return Offset(x1 + t * (x2 - x1), y1 + t * (y2 - y1));
  }

  static double getDistanse(Boundary ray, Offset intersection) => sqrt(
        pow(ray.start.dx - intersection.dx, 2) +
            pow(ray.start.dy - intersection.dy, 2),
      );
}
