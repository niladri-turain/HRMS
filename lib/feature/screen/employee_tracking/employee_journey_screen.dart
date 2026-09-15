import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_colors.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';

class EmployeeJourneyScreen extends StatelessWidget {
  const EmployeeJourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImagesPng.dashboardBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'Employee Journey',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // Employee Info Card
                      _buildEmployeeInfoCard(),
                      const SizedBox(height: 16),
                      // Map Card
                      _buildMapCard(),
                      const SizedBox(height: 16),
                      // Journey Details Card
                      _buildJourneyDetailsCard(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmployeeInfoCard() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage(AppImagesPng.persionIcon),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Goutam Mazumder',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        Text(
                          'Marketing Executive',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.calendar_today_outlined, size: 14, color: Color(0xFF6B7280)),
                        SizedBox(width: 6),
                        Text(
                          '12 Aug 2026',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF1F2937)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    _buildInfoItem('Login Time', '10:28 AM'),
                    _buildVerticalDivider(),
                    _buildInfoItem('Distance Travelled', '18.4 km'),
                    _buildVerticalDivider(),
                    _buildInfoItem('Total Stop', '3'),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Current Location',
                style: TextStyle(
                  color: Color(0xFF10B981),
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFDCFCE7),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Text(
            '884 Kalikapur Road (Gitanjali Park), Kolkata 700099.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF065F46),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF111827)),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 30,
      width: 1,
      color: const Color(0xFFE5E7EB),
    );
  }

  Widget _buildMapCard() {
    return Container(
      height: 320,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              AppImagesPng.trackmap,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          // Map Type Switcher
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)],
              ),
              child: Row(
                children: [
                  _buildMapTypeButton('Map', true),
                  _buildMapTypeButton('Satellite', false),
                ],
              ),
            ),
          ),
          // Zoom Controls
          Positioned(
            bottom: 60,
            right: 12,
            child: Column(
              children: [
                _buildZoomButton(Icons.add),
                const SizedBox(height: 8),
                _buildZoomButton(Icons.remove),
              ],
            ),
          ),
          // Route and Markers Overlay (Simplified representation)
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: MapJourneyPainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapTypeButton(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1C2263) : Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.white : const Color(0xFF1C2263),
        ),
      ),
    );
  }

  Widget _buildZoomButton(IconData icon) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)],
      ),
      child: Icon(icon, color: const Color(0xFF374151), size: 24),
    );
  }

  Widget _buildJourneyDetailsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Journey Details (12 Aug 2026)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF7C3AED),
            ),
          ),
          const SizedBox(height: 24),
          _buildTimelineItem(
            '1',
            '10:28 AM',
            'Attendance Check-in',
            'Salt Lake Sector V, Kolkata',
            const Color(0xFF10B981),
          ),
          _buildTimelineItem(
            '2',
            '11:28 AM',
            'Client Visit',
            'ABC Enterprises',
            const Color(0xFF7C3AED),
            subLocation: 'Sector V, Kolkata - 1h 10m',
            isVisit: true,
          ),
          _buildTimelineItem(
            '3',
            '12:50 PM',
            'Client Visit',
            'XYZ Solutions',
            const Color(0xFF7C3AED),
            subLocation: 'New Town, Kolkata - 1h',
            isVisit: true,
          ),
          _buildTimelineItem(
            '4',
            '14:18 PM',
            'Client Visit',
            'Acme Pvt. Ltd.',
            const Color(0xFF7C3AED),
            subLocation: 'Eco Park, Kolkata - 1h 20m',
            isVisit: true,
          ),
          _buildTimelineItem(
            '',
            '15:28 PM',
            'Current Location',
            'Park Street, Kolkata',
            const Color(0xFFEF4444),
            isLast: true,
            isLocation: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
    String index,
    String time,
    String title,
    String location,
    Color color, {
    bool isLast = false,
    bool isVisit = false,
    bool isLocation = false,
    String? subLocation,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: isLocation ? Colors.transparent : color,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: isLocation 
                  ? Icon(Icons.location_on, color: color, size: 30)
                  : Text(
                    index,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.5,
                    color: const Color(0xFFE5E7EB),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Text(
                        time,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1F2937)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: isVisit ? const Color(0xFF3B82F6) : const Color(0xFF1F2937),
                              decoration: isVisit ? TextDecoration.underline : null,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            location,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isVisit ? FontWeight.w800 : FontWeight.w500,
                              color: isVisit ? const Color(0xFF1C2263) : const Color(0xFF6B7280),
                            ),
                          ),
                          if (subLocation != null)
                             Padding(
                               padding: const EdgeInsets.only(top: 2),
                               child: Text(
                                subLocation,
                                style: const TextStyle(
                                  fontSize: 12, 
                                  color: Color(0xFF60A5FA), 
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                             ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (!isLast)
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: CustomPaint(
                      size: const Size(double.infinity, 1),
                      painter: HorizontalDashedLinePainter(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalDashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..strokeWidth = 1;
    var max = size.width;
    var dashWidth = 4;
    var dashSpace = 4;
    double startX = 0;
    while (startX < max) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class MapJourneyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3B82F6)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    // Simulate a route path on the map
    path.moveTo(size.width * 0.7, size.height * 0.2);
    path.lineTo(size.width * 0.6, size.height * 0.3);
    path.lineTo(size.width * 0.5, size.height * 0.45);
    path.lineTo(size.width * 0.4, size.height * 0.55);
    path.lineTo(size.width * 0.35, size.height * 0.75);
    path.lineTo(size.width * 0.25, size.height * 0.85);

    canvas.drawPath(path, paint);

    // Draw simulation markers
    _drawMarker(canvas, Offset(size.width * 0.7, size.height * 0.2), "1", const Color(0xFF10B981));
    _drawMarker(canvas, Offset(size.width * 0.5, size.height * 0.45), "2", const Color(0xFF7C3AED));
    _drawMarker(canvas, Offset(size.width * 0.4, size.height * 0.55), "3", const Color(0xFF7C3AED));
    _drawMarker(canvas, Offset(size.width * 0.25, size.height * 0.85), "", const Color(0xFFEF4444), isPin: true);
  }

  void _drawMarker(Canvas canvas, Offset position, String text, Color color, {bool isPin = false}) {
    if (isPin) {
      final pinPaint = Paint()..color = color;
      canvas.drawCircle(position, 8, pinPaint);
    } else {
      final circlePaint = Paint()..color = color;
      canvas.drawCircle(position, 10, circlePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
