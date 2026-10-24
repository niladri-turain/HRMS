import 'package:flutter/material.dart';

class AttendanceStatusCard extends StatelessWidget {
  const AttendanceStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        '11:55',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Text(
                        'AM',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        '01:37:20',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF03C95A),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Work Time',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF03C95A),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'On Time',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildInfoItem(
                icon: Icons.access_time,
                label: 'Login Time',
                value: '10:28 AM',
                valueColor: const Color(0xFF10B981),
              ),
              _buildInfoItem(
                icon: Icons.access_time,
                label: 'Logout Time',
                value: '--:--',
                valueColor: const Color(0xFF1F2937),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _buildInfoItem(
                icon: Icons.phone_android,
                label: 'Login Form',
                value: 'Mobile (Android)',
                valueColor: const Color(0xFF1B2CF1),
              ),
              _buildInfoItem(
                icon: Icons.check_circle_outline,
                label: 'GPS Status',
                value: 'Captured',
                valueColor: const Color(0xFF03C95A),
                isGps: true,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on_outlined, size: 20, color: Color(0xFFD4A017)),
              const SizedBox(width: 8),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                      style: TextStyle(fontSize: 12, color: Color(0xFF746F77),fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Salt Lake Sector V, Kolkata, West Bengal',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
    required Color valueColor,
    bool isGps = false,
  }) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF592680)),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Color(0xFF746F77),fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  if (isGps) ...[
                    const Icon(Icons.check_circle, size: 16, color: Color(0xFF03C95A),fontWeight: FontWeight.w600),
                    const SizedBox(width: 4),
                  ],
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: valueColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
