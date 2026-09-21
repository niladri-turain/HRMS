import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_colors.dart';

class RecentActivitiesCard extends StatelessWidget {
  const RecentActivitiesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Activities',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primary200,
            ),
          ),
          const SizedBox(height: 16),
          _buildActivityItem('Santanu Das login and tracking start', '10:25 AM'),
          const Divider(),
          _buildActivityItem('Santanu Das Client Visit ABC Enterprises', '11:25 PM'),
          const Divider(),
          _buildActivityItem('Goutam Mazumder Client Visit XYZ Solutions', '11:28 AM'),
          const Divider(),
          _buildActivityItem('Goutam Mazumder Client Visit Acme Pvt. Ltd.', '12:55 PM'),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String activity, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            activity,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF1C2263)),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
