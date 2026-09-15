import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_colors.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';

class ClientDetailsInfoCard extends StatelessWidget {
  final String status;
  const ClientDetailsInfoCard({super.key, this.status = 'Upcoming'});

  @override
  Widget build(BuildContext context) {
    final isCompleted = status.toLowerCase() == 'completed';
    final isInProgress = status.toLowerCase() == 'in progress';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ABC Enterprises',
                      style: TextStyle(
                        color: Color(0xFF1F2937),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Salt Lake Sector V, Kolkata',
                      style: TextStyle(
                        color: AppColors.grey100,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (isCompleted || isInProgress)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        isInProgress ? 'In Progress' : 'Completed',
                        style: TextStyle(
                          color: isInProgress ? AppColors.brightBlue200 : AppColors.green200,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.primary200),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.location_on_outlined, color: AppColors.primary200, size: 14),
                        SizedBox(width: 4),
                        Text(
                          'View on Map',
                          style: TextStyle(
                            color: AppColors.primary200,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),


          const SizedBox(height: 16),
          Row(
            children: [
              _buildInfoItem(
                icon: AppImagesPng.scheduleDate,
                label: 'Schedule Date',
                value: 'Tuesday, 12 Aug 2026',
                iconBgColor: AppColors.yellow200.withOpacity(0.1),
              ),
              const SizedBox(width: 16),
              _buildInfoItem(
                icon: AppImagesPng.scheduleTime,
                label: 'Schedule Time',
                value: '10:15 AM - 11:00 AM',
                iconBgColor: AppColors.brightBlue200.withOpacity(0.1),
              ),
            ],
          ),
          if (isCompleted) ...[
            const SizedBox(height: 12),
            const Divider(height: 1, color: Color(0xFFE5E7EB), thickness: 0.5, indent: 40),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildInfoItem(
                  icon: AppImagesPng.scheduleTime,
                  label: 'Actual Start Time',
                  value: '10:28 AM',
                  iconBgColor: AppColors.brightBlue200.withOpacity(0.1),
                ),
                const SizedBox(width: 8),
                _buildInfoItem(
                  icon: AppImagesPng.scheduleTime,
                  label: 'Actual End Time',
                  value: '11:08 AM',
                  iconBgColor: AppColors.brightBlue200.withOpacity(0.1),
                ),
                const SizedBox(width: 8),
                _buildInfoItem(
                  icon: AppImagesPng.scheduleTime,
                  label: 'Visit Duration',
                  value: '00 h 40 m',
                  iconBgColor: AppColors.brightBlue200.withOpacity(0.1),
                ),
              ],
            ),
          ],
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE5E7EB), thickness: 0.5, indent: 40),
          const SizedBox(height: 12),
          _buildDetailRow(
            icon: AppImagesPng.purpose,
            label: 'Purpose',
            value: '1 Lac Bulksms & Whatsapp api requirement',
            iconBgColor: AppColors.darkBlue200.withOpacity(0.1),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE5E7EB), thickness: 0.5, indent: 40),
          const SizedBox(height: 12),
          _buildDetailRow(
            icon: AppImagesPng.contactPerson,
            label: 'Contact Person',
            value: 'Mr. Amit Sarkar (IT Head)',
            iconBgColor: AppColors.primary200.withOpacity(0.1),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE5E7EB), thickness: 0.5, indent: 40),
          const SizedBox(height: 12),
          _buildDetailRow(
            icon: AppImagesPng.phone,
            label: 'Phone No.',
            value: '+91 98962 94569',
            iconBgColor: AppColors.pink200.withOpacity(0.1),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE5E7EB), thickness: 0.5, indent: 40),
          const SizedBox(height: 12),
          _buildDetailRow(
            icon: AppImagesPng.email,
            label: 'Email ID',
            value: 'amitsarkar1978@abcenterprize.com',
            iconBgColor: const Color(0xFF03C95A).withOpacity(0.1),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required String icon,
    required String label,
    required String value,
    required Color iconBgColor,
  }) {
    return Expanded(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Image.asset(icon, width: 20, height: 20),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: AppColors.grey100, fontSize: 10,fontWeight: FontWeight.w500),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required String icon,
    required String label,
    required String value,
    required Color iconBgColor,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: iconBgColor,
            shape: BoxShape.circle,
          ),
          child: Image.asset(icon, width: 20, height: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: AppColors.grey100, fontSize: 10,fontWeight: FontWeight.w500),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF1F2937),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
