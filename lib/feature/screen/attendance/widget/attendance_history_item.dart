import 'package:flutter/material.dart';
import 'dart:ui';

class AttendanceHistoryItem extends StatelessWidget {
  final String date;
  final String status;
  final Color statusColor;
  final Color statusBgColor;
  final String loginTime;
  final String logoutTime;
  final String workingHours;

  const AttendanceHistoryItem({
    super.key,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.statusBgColor,
    required this.loginTime,
    required this.logoutTime,
    required this.workingHours,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: CustomPaint(
        painter: DottedBorderPainter(
          color: const Color(0xFFD1D5DB),
          dashWidth: 4,
          dashSpace: 3,
          borderRadius: 8,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Date & Day',
                        style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF), fontWeight: FontWeight.w500),
                      ),
                      Text(
                        date,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusBgColor,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: statusColor.withOpacity(0.2)),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: statusColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTimeInfo('Login', loginTime, const Color(0xFFEDAA00)),
                  _buildTimeInfo('Logout', logoutTime, const Color(0xFF00B650)),
                  _buildTimeInfo('Working Hours', workingHours, const Color(0xFF2563EB)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeInfo(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: label == 'Working Hours' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF), fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: valueColor),
        ),
      ],
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;
  final double borderRadius;

  DottedBorderPainter({
    required this.color,
    this.dashWidth = 3.0,
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
