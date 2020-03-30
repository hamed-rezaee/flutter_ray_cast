import 'dart:math';
import 'package:flutter/material.dart';

import 'package:flutter_ray_cast/helper.dart';
import 'package:flutter_ray_cast/boundary.dart';

class EnvironmentPainter extends CustomPainter {
  final Offset position;
  final List<Boundary> walls;
  final double maxRayLenght;

  EnvironmentPainter({
    @required this.position,
    @required this.walls,
    @required this.maxRayLenght,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawWalls(canvas);
    _drawRays(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }

  void _drawWalls(Canvas canvas) {
    final Paint wallPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.0;

    for (Boundary wall in walls) {
      canvas.drawLine(wall.start, wall.end, wallPaint);
    }
  }

  void _drawRays(Canvas canvas) {
    final Paint rayPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.04;

    for (double angle = 0.0; angle < 360.0; angle += 0.1) {
      final Boundary ray = Boundary(
        start: position,
        end: Offset(
          position.dx + cos(-angle * pi / 180.0) * maxRayLenght,
          position.dy + sin(-angle * pi / 180.0) * maxRayLenght,
        ),
      );

      bool hasIntersection = false;
      double minDistanse = double.infinity;
      Offset minIntersection;

      for (Boundary wall in walls) {
        final Offset intersection =
            Helper.getIntersectionLine(ray: ray, line: wall);
        final double distance =
            Helper.getDistanse(ray: ray, intersection: intersection);
        final bool currentWallHasIntersection =
            Helper.hasIntersectionLine(ray: ray, line: wall);

        hasIntersection = hasIntersection || currentWallHasIntersection;

        if (currentWallHasIntersection && minDistanse > distance) {
          minIntersection = intersection;
          minDistanse = distance;
        }
      }

      canvas.drawLine(
        ray.start,
        hasIntersection ? minIntersection : ray.end,
        rayPaint,
      );
    }
  }
}
