import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_colors.dart';

class ClientMeetingCard extends StatelessWidget {
  final List<Map<String, String>> meetings;
  const ClientMeetingCard({super.key, required this.meetings});

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
                "Today's Client Meeting",
                style: TextStyle(
                  color: AppColors.primary200,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: const Text(
                  'View Calendar',
                  style: TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...meetings.asMap().entries.map((entry) {
            int idx = entry.key;
            Map<String, String> meeting = entry.value;
            return Padding(
              padding: EdgeInsets.only(bottom: idx == meetings.length - 1 ? 0 : 12),
              child: ClientMeetingItem(
                index: idx + 1,
                company: meeting['company'] ?? '',
                address: meeting['address'] ?? '',
                requirement: meeting['requirement'] ?? '',
                status: meeting['status'] ?? 'Upcoming',
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class ClientMeetingItem extends StatelessWidget {
  final int index;
  final String company;
  final String address;
  final String requirement;
  final String status;

  const ClientMeetingItem({
    super.key,
    required this.index,
    required this.company,
    required this.address,
    required this.requirement,
    this.status = 'Upcoming',
  });

  Widget _buildStatusTag() {
    Color textColor;
    Color bgColor;
    Color borderColor;

    switch (status.toLowerCase()) {
      case 'completed':
        textColor = AppColors.green200;
        bgColor = AppColors.green200.withOpacity(0.05);
        borderColor = AppColors.green200.withOpacity(0.2);
        break;
      case 'postponed':
        textColor = AppColors.purple200;
        bgColor = AppColors.purple200.withOpacity(0.05);
        borderColor = AppColors.purple200.withOpacity(0.2);
        break;
      case 'upcoming':
      default:
        textColor = AppColors.blue300;
        bgColor = const Color(0xFFEFF6FF);
        borderColor = const Color(0xFFDBEAFE);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppColors.green200,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$index',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      company,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    Text(
                      address,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.grey400,
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusTag(),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F6F7),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              requirement,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF000000),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
