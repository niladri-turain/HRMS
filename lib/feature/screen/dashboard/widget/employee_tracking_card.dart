import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_colors.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import '../../employee_tracking/employee_journey_screen.dart';

class EmployeeTrackingCard extends StatelessWidget {
  const EmployeeTrackingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Employee Tracking',
                style: TextStyle(
                  color: AppColors.primary200,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Image.asset(
                AppImagesPng.locationTrack,
                width: 24,
                height: 24,
                color: AppColors.primary200,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'View live location and daily movement journey of your team members.',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EmployeeJourneyScreen()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primary200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Track Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
