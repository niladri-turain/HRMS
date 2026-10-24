import 'package:flutter/material.dart';

class AttendanceTimelineCard extends StatelessWidget {
  const AttendanceTimelineCard({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Timeline",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF901AEA),
            ),
          ),
          const SizedBox(height: 20),
          _buildTimelineItem(
            icon: Icons.login,
            title: 'Login',
            time: '10:28 AM',
            status: 'On Time',
            color: const Color(0xFF10B981),
            bgColor: const Color(0xFFECFDF5),
            isFirst: true,
            isCompleted: true,
          ),
          _buildTimelineItem(
            icon: Icons.restaurant,
            title: 'Lunch Break',
            time: '14:00 PM - 14:30 PM',
            status: 'Upcoming',
            color: const Color(0xFF9333EA),
            bgColor: const Color(0xFFF5F3FF),
            isCompleted: false,
          ),
          _buildTimelineItem(
            icon: Icons.coffee,
            title: 'Tea Break',
            time: '17:00 PM - 17:30 PM',
            status: 'Upcoming',
            color: const Color(0xFF9333EA),
            bgColor: const Color(0xFFF5F3FF),
            isCompleted: false,
          ),
          _buildTimelineItem(
            icon: Icons.logout,
            title: 'Logout',
            time: '19:00 PM',
            status: 'Upcoming',
            color: const Color(0xFF4B5563),
            bgColor: const Color(0xFFF9FAFB),
            isLast: true,
            isCompleted: false,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.info_outline, size: 16, color: Color(0xFF4F46E5)),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Timeline will update as per your attendance activity.',
                  style: TextStyle(fontSize: 11, color: Color(0xFF4F46E5)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required IconData icon,
    required String title,
    required String time,
    required String status,
    required Color color,
    required Color bgColor,
    bool isFirst = false,
    bool isLast = false,
    required bool isCompleted,
  }) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              if (isCompleted)
                const Icon(Icons.check_circle, size: 16, color: Color(0xFF10B981))
              else
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE5E7EB), width: 2),
                  ),
                ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: const Color(0xFFE5E7EB),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(icon, size: 20, color: color),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: color,
                          ),
                        ),
                        Text(
                          time,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isCompleted ? const Color(0xFF10B981) : Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: isCompleted ? Colors.transparent : const Color(0xFFE5E7EB)),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: isCompleted ? Colors.white : const Color(0xFF6B7280),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
