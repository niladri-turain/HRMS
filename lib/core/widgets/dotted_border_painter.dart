import 'package:flutter/material.dart';
import 'dart:ui';

class DottedBorderPainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;
  final double borderRadius;

  DottedBorderPainter({
    required this.color,
    this.dashWidth = 4.0,
    this.dashSpace = 3.0,
    this.strokeWidth = 1.0,
    this.borderRadius = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromLTRBR(0, 0, size.width, size.height, Radius.circular(borderRadius));
    final Path path = Path()..addRRect(rrect);

    for (final PathMetric pathMetric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final Path dashPath = pathMetric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(dashPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
