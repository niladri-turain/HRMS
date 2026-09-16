import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:hrms_app/feature/model/managerModel/employee_tracking_model.dart';
import 'package:hrms_app/feature/provider/managerProvider/manager_employee_tracking_provider.dart';

class EmployeeJourneyScreen extends StatefulWidget {
  final String employeeId;
  const EmployeeJourneyScreen({super.key, required this.employeeId});

  @override
  State<EmployeeJourneyScreen> createState() => _EmployeeJourneyScreenState();
}

class _EmployeeJourneyScreenState extends State<EmployeeJourneyScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // For demonstration/testing with the mock-responsive API, 
      // we use the date expected by the backend mock data
      Provider.of<ManagerEmployeeTrackingProvider>(context, listen: false)
          .fetchEmployeeJourney(widget.employeeId, "2026-09-16"); 
    });
  }

  String _formatTime(String? dateTimeStr) {
    if (dateTimeStr == null || dateTimeStr.isEmpty) return '--:--';
    try {
      final dt = DateTime.parse(dateTimeStr);
      return DateFormat('hh:mm a').format(dt);
    } catch (e) {
      return dateTimeStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ManagerEmployeeTrackingProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Scaffold(
            backgroundColor: Color(0xFFF3F4F6),
            body: Center(child: CircularProgressIndicator(color: Color(0xFF7C3AED))),
          );
        }

        if (provider.errorMessage != null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Employee Journey'),
              backgroundColor: const Color(0xFF311040),
              foregroundColor: Colors.white,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      provider.errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<ManagerEmployeeTrackingProvider>(context, listen: false)
                            .fetchEmployeeJourney(widget.employeeId, "2026-09-16");
                      },
                      child: const Text('Retry'),
                    )
                  ],
                ),
              ),
            ),
          );
        }

        final tracking = provider.trackingData?.data;
        final employee = tracking?.employee;
        final attendance = tracking?.attendance;
        final summary = tracking?.journeySummary;
        final session = tracking?.session;
        final stoppages = tracking?.stoppages ?? [];

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
                          _buildEmployeeInfoCard(employee, attendance, summary, session),
                          const SizedBox(height: 16),
                          // Map Card
                          _buildMapCard(),
                          const SizedBox(height: 16),
                          // Journey Details Card
                          _buildJourneyDetailsCard(attendance, stoppages, tracking?.date),
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
      },
    );
  }

  Widget _buildEmployeeInfoCard(
    EmployeeInfo? employee,
    AttendanceInfo? attendance,
    JourneySummary? summary,
    SessionInfo? session,
  ) {
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
                      children: [
                        Text(
                          employee?.name ?? 'N/A',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        Text(
                          employee?.designation?.name ?? 'N/A',
                          style: const TextStyle(
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
                      children: [
                        const Icon(Icons.calendar_today_outlined, size: 14, color: Color(0xFF6B7280)),
                        const SizedBox(width: 6),
                        Text(
                          attendance?.attendanceDate ?? '--',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF1F2937)),
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
                    _buildInfoItem('Login Time', _formatTime(attendance?.loginAt)),
                    _buildVerticalDivider(),
                    _buildInfoItem('Distance Travelled', "${session?.totalDistanceKm?.toStringAsFixed(1) ?? '0.0'} km"),
                    _buildVerticalDivider(),
                    _buildInfoItem('Total Stop', "${summary?.totalStoppages ?? 0}"),
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
          child: Text(
            attendance?.loginLocationName ?? 'Location not available',
            textAlign: TextAlign.center,
            style: const TextStyle(
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
              fit: BoxFit.cover,
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
            bottom: 20,
            right: 12,
            child: Column(
              children: [
                _buildZoomButton(Icons.add),
                const SizedBox(height: 8),
                _buildZoomButton(Icons.remove),
              ],
            ),
          ),
          // Center Marker Simulation
          const Center(
            child: Icon(Icons.location_on, color: Colors.red, size: 40),
          )
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

  Widget _buildJourneyDetailsCard(AttendanceInfo? attendance, List<StoppageInfo> stoppages, String? date) {
    String formattedDate = '';
    if (date != null) {
      try {
        formattedDate = DateFormat('d MMM yyyy').format(DateTime.parse(date));
      } catch (_) {
        formattedDate = date;
      }
    }

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
          Text(
            'Journey Details ($formattedDate)',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF7C3AED),
            ),
          ),
          const SizedBox(height: 24),
          
          // Check-in Item
          _buildTimelineItem(
            '1',
            _formatTime(attendance?.loginAt),
            'Attendance Check-in',
            attendance?.loginLocationName ?? 'N/A',
            const Color(0xFF10B981),
            isLast: stoppages.isEmpty,
          ),

          // Stoppages / Client Visits
          ...List.generate(stoppages.length, (index) {
            final stop = stoppages[index];
            final isLast = index == stoppages.length - 1;
            return _buildTimelineItem(
              (index + 2).toString(),
              _formatTime(stop.arrivedAt),
              'Stoppage / Client Visit',
              stop.locationName ?? 'Unknown Location',
              const Color(0xFF7C3AED),
              subLocation: '${stop.durationMinutes ?? 0}m duration',
              isVisit: true,
              isLast: isLast,
            );
          }),

          if (stoppages.isEmpty && attendance?.isLoggedIn == true)
            _buildTimelineItem(
              '',
              'Now',
              'Current Status',
              'Actively Tracking',
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
