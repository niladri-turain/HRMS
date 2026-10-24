import 'package:flutter/material.dart';

class AttendanceOverviewCard extends StatelessWidget {
  const AttendanceOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'This Month Overview',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF901AEA),
                ),
              ),
              Row(
                children: [
                  const Text(
                    'August 2026',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2563EB),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(Icons.chevron_right, size: 16, color: Color(0xFF9CA3AF)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2.2,
            children: [
              _buildOverviewItem(
                icon: Icons.check_circle,
                label: 'Present Days',
                value: '9',
                color: const Color(0xFF10B981),
                bgColor: const Color(0xFFECFDF5),
              ),
              _buildOverviewItem(
                icon: Icons.access_time_filled,
                label: 'Late Days',
                value: '2',
                color: const Color(0xFFD47A17),
                bgColor: const Color(0xFFFFFBEB),
              ),
              _buildOverviewItem(
                icon: Icons.pause_circle_filled,
                label: 'Half Days',
                value: '0',
                color: const Color(0xFFD4A017),
                bgColor: const Color(0xFFFEFCE8),
              ),
              _buildOverviewItem(
                icon: Icons.cancel,
                label: 'Absent Days',
                value: '1',
                color: const Color(0xFFEF4444),
                bgColor: const Color(0xFFFEF2F2),
              ),
              _buildOverviewItem(
                icon: Icons.calendar_month,
                label: 'Weekly Off / Holiday',
                value: '4',
                color: const Color(0xFF6B7280),
                bgColor: const Color(0xFFF3F4F6),
              ),
              _buildOverviewItem(
                icon: Icons.access_time_filled,
                label: 'Total Working Hours',
                value: '89h 15m',
                color: const Color(0xFF901AEA),
                bgColor: const Color(0xFFF5F3FF),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'View Full Attendance History',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2563EB),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, size: 16, color: Color(0xFF2563EB)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 9, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  value,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
