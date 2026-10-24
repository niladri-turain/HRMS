import 'package:flutter/material.dart';
import 'package:hrms_app/feature/screen/attendance/widget/attendance_overview_card.dart';
import 'package:hrms_app/feature/screen/attendance/widget/attendance_history_item.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF311040), Color(0xFFFFFFFF)],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header matching AttendanceScreen style
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'History',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Export Button
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF901AEA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.description_outlined, size: 16, color: Colors.white),
                          const SizedBox(width: 4),
                          Text(
                            'Export',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.white),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Filter Button
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF901AEA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.tune, size: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const AttendanceOverviewCard(showHistoryLink: false),
                      const SizedBox(height: 16),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Attendance Records',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF901AEA),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const AttendanceHistoryItem(
                              date: '07 Aug - Thursday',
                              status: 'Half Day',
                              statusColor: Color(0xFFEDAA00),
                              statusBgColor: Color(0xFFFEFCE8),
                              loginTime: '12:45 PM',
                              logoutTime: '19:12 PM',
                              workingHours: '06h 35m',
                            ),
                            _buildDivider(),
                            const AttendanceHistoryItem(
                              date: '06 Aug - Wednesday',
                              status: 'Present',
                              statusColor: Color(0xFF03C95A),
                              statusBgColor: Color(0xFFECFDF5),
                              loginTime: '10:22 AM',
                              logoutTime: '19:21 PM',
                              workingHours: '08h 41m',
                            ),
                            _buildDivider(),
                            const AttendanceHistoryItem(
                              date: '05 Aug - Tuesday',
                              status: 'Late',
                              statusColor: Color(0xFFDF6C00),
                              statusBgColor: Color(0xFFFFFBEB),
                              loginTime: '10:38 AM',
                              logoutTime: '19:02 PM',
                              workingHours: '08h 22m',
                            ),
                            _buildDivider(),
                            const AttendanceHistoryItem(
                              date: '04 Aug - Monday',
                              status: 'Present',
                              statusColor: Color(0xFF03C95A),
                              statusBgColor: Color(0xFFECFDF5),
                              loginTime: '10:20 AM',
                              logoutTime: '19:15 PM',
                              workingHours: '08h 55m',
                            ),
                            _buildDivider(),
                            const AttendanceHistoryItem(
                              date: '03 Aug - Sunday',
                              status: 'Weekly Off',
                              statusColor: Color(0xFF6B7280),
                              statusBgColor: Color(0xFFF3F4F6),
                              loginTime: '--:--',
                              logoutTime: '--:--',
                              workingHours: '--:--',
                            ),
                            _buildDivider(),
                            const AttendanceHistoryItem(
                              date: '02 Aug - Saturday',
                              status: 'Present',
                              statusColor: Color(0xFF03C95A),
                              statusBgColor: Color(0xFFECFDF5),
                              loginTime: '10:28 AM',
                              logoutTime: '19:02 PM',
                              workingHours: '08h 32m',
                            ),
                            _buildDivider(),
                            const AttendanceHistoryItem(
                              date: '01 Aug - Friday',
                              status: 'Present',
                              statusColor: Color(0xFF03C95A),
                              statusBgColor: Color(0xFFECFDF5),
                              loginTime: '10:28 AM',
                              logoutTime: '19:02 PM',
                              workingHours: '08h 32m',
                            ),
                          ],
                        ),
                      ),
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

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Divider(height: 1, color: Colors.grey.withOpacity(0.1)),
    );
  }
}
