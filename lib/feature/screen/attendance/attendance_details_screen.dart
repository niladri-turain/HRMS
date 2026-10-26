import 'package:flutter/material.dart';
import 'package:hrms_app/core/widgets/dotted_border_painter.dart';

class AttendanceDetailsScreen extends StatelessWidget {
  final String date;
  final String status;
  final Color statusColor;
  final Color statusBgColor;
  final String loginTime;
  final String logoutTime;
  final String workingHours;

  const AttendanceDetailsScreen({
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
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Attendance Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Main Content Card
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date & Status Header
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_month_outlined, color: Color(0xFF374151), size: 22),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  date,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1F2937),
                                  ),
                                ),
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
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: statusColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Login Details
                        _buildDottedSection(
                          icon: Icons.login,
                          iconBgColor: const Color(0xFFECFDF5),
                          iconColor: const Color(0xFF03C95A),
                          title: 'Login Time',
                          time: loginTime,
                          tag: loginTime == '--:--' ? 'N/A' : 'On Time',
                          tagColor: loginTime == '--:--' ? Colors.grey : const Color(0xFF00B650),
                          source: loginTime == '--:--' ? '--' : 'Mobile HRMS App',
                          sourceIcon: Icons.smartphone,
                          location: loginTime == '--:--' ? '--' : 'Salt Lake Sector V, Kolkata, West Bengal',
                        ),
                        const SizedBox(height: 16),

                        // Logout Details
                        _buildDottedSection(
                          icon: Icons.logout,
                          iconBgColor: const Color(0xFFFEF2F2),
                          iconColor: const Color(0xFFEF4444),
                          title: 'Logout Time',
                          time: logoutTime,
                          tag: logoutTime == '--:--' ? 'N/A' : 'On Time',
                          tagColor: logoutTime == '--:--' ? Colors.grey : const Color(0xFF00B650),
                          source: logoutTime == '--:--' ? '--' : 'Web HRMS Portal',
                          sourceIcon: Icons.laptop,
                          location: logoutTime == '--:--' ? '--' : 'Kalikapur Road, Kolkata, West Bengal',
                        ),
                        const SizedBox(height: 20),

                        // Summary Rows
                        _buildSummaryRow('Total Working Hours', workingHours),
                        _buildSummaryRow('Break Time', workingHours == '--:--' ? '--:--' : '00h 30m'),
                        _buildSummaryRow('First Login', loginTime),
                        _buildSummaryRow('Last Logout', logoutTime),
                        
                        const SizedBox(height: 24),

                        // Info Box
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F2FF),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFD1D5DB).withOpacity(0.5)),
                          ),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.error_outline, color: Color(0xFF3F37C9), size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Attendance is based on your login and logout times. For any discrepancy, please contact HR.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF1F2937),
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDottedSection({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String time,
    required String tag,
    required Color tagColor,
    required String source,
    required IconData sourceIcon,
    required String location,
  }) {
    return CustomPaint(
      painter: DottedBorderPainter(
        color: const Color(0xFFD1D5DB),
        dashWidth: 4,
        dashSpace: 3,
        borderRadius: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
                    ),
                    Text(
                      time,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: tagColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildDetailInfo('Source', source, sourceIcon),
            const SizedBox(height: 12),
            _buildDetailInfo('GPS Status', time == '--:--' ? 'Not Captured' : 'Captured', Icons.check_circle_outline, checkColor: time == '--:--' ? Colors.grey : const Color(0xFF03C95A)),
            const SizedBox(height: 12),
            _buildDetailInfo('Location', location, Icons.location_on_outlined, iconColor: time == '--:--' ? Colors.grey : const Color(0xFFEDAA00)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailInfo(String label, String value, IconData icon, {Color? checkColor, Color? iconColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(icon, size: 16, color: iconColor ?? (checkColor ?? const Color(0xFF3F37C9))),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF374151)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1F2937)),
          ),
        ],
      ),
    );
  }
}
