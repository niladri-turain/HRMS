import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import '../../../../core/constants/app_colors.dart';
import 'widget/client_details_info_card.dart';
import 'widget/visit_live_tracking_card.dart';
import 'widget/start_visit_button_card.dart';
import 'widget/visit_note_section.dart';

class ClientDetailsScreen extends StatelessWidget {
  final String status;
  const ClientDetailsScreen({super.key, this.status = 'Upcoming'});

  @override
  Widget build(BuildContext context) {
    final isCompleted = status.toLowerCase() == 'completed';
    final isInProgress = status.toLowerCase() == 'in progress' || status.toLowerCase() == 'postponed';

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
              // Custom App Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'Client Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    children: [
                      if (isCompleted) ...[
                        _buildCompletedBanner(),
                        const SizedBox(height: 16),
                      ],
                      if (isInProgress) ...[
                        _buildInProgressBanner(),
                        const SizedBox(height: 16),
                      ],
                      ClientDetailsInfoCard(status: status),
                      const SizedBox(height: 16),
                      if (isInProgress) ...[
                        _buildCurrentLocationCard(),
                        const SizedBox(height: 16),
                        _buildUploadAndNoteSection(),
                        const SizedBox(height: 16),
                        _buildEndVisitButtons(context),
                      ] else if (isCompleted) ...[
                        _buildCompletedDetails(),
                      ] else ...[
                        const VisitLiveTrackingCard(),
                        const SizedBox(height: 16),
                        const StartVisitButtonCard(),
                        const SizedBox(height: 16),
                        const VisitNoteSection(),
                      ],
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

  Widget _buildCompletedBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFDCFCE7)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: AppColors.green200, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Visit Completed Successfully',
                  style: TextStyle(
                    color: AppColors.green200,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Your visit has been recorded. All details and documents have been uploaded successfully at 08 Aug, 2026, 11:45 Am',
                  style: TextStyle(
                    color: Color(0xFF166534),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedDetails() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Visit Location & Details',
                style: TextStyle(
                  color: AppColors.primary200,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Divider(height: 1, color: Color(0xFFF3F4F6)),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, color: AppColors.yellow200, size: 20),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Sector 5, Salt Lake, Westbengal',
                      style: TextStyle(
                        color: Color(0xFF1F2937),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Uploaded Documents',
                style: TextStyle(
                  color: Color(0xFF1F2937),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.description_outlined, color: AppColors.grey200, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'ABC_VisitingCard.jpg',
                        style: TextStyle(
                          color: Color(0xFF1F2937),
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Text(
                      '24 KB',
                      style: TextStyle(
                        color: AppColors.grey200,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(Icons.remove_red_eye_outlined, color: AppColors.primary200, size: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const VisitNoteSection(),
      ],
    );
  }

  Widget _buildInProgressBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFDCFCE7)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.play_arrow, color: AppColors.green200, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Visit Started (10:28 AM)',
                  style: TextStyle(
                    color: AppColors.green200,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Your visit is in progress. Keep the app running to capture your location. Started at 08 Aug, 2026, 10:28 Am',
                  style: TextStyle(
                    color: Color(0xFF166534),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentLocationCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Current Location (Capture by GPS)',
                style: TextStyle(
                  color: AppColors.purple200,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: const [
                  Icon(Icons.refresh, color: AppColors.grey200, size: 16),
                  SizedBox(width: 4),
                  Text(
                    'Last updated: 10:28 AM',
                    style: TextStyle(color: AppColors.grey200, fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: AppColors.yellow200, size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Sector 5, Salt Lake, Westbengal',
                  style: TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.green200.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.green200.withOpacity(0.2)),
                ),
                child: const Text(
                  'Re Cpatured',
                  style: TextStyle(
                    color: AppColors.green200,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUploadAndNoteSection() {
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
          const Text(
            'Upload Visiting Card / Document *',
            style: TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              children: [
                const Icon(Icons.description_outlined, color: AppColors.grey200, size: 20),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'ABC_VisitingCard.jpg',
                    style: TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 13,
                    ),
                  ),
                ),
                const Text(
                  '24 KB',
                  style: TextStyle(
                    color: AppColors.grey200,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.check_circle, color: AppColors.green200, size: 20),
                const SizedBox(width: 8),
                const Icon(Icons.delete_outline, color: AppColors.red200, size: 20),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE5E7EB), style: BorderStyle.solid),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.upload_outlined, color: AppColors.primary200, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Upload Documents',
                      style: TextStyle(
                        color: AppColors.primary200,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Drag & drop or browse (JPG, PNG, PDF - Max 5MB)',
                  style: TextStyle(color: AppColors.grey200, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Add Visit Note (Optional)',
            style: TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 100,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: const TextField(
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Enter notes about this visit...',
                hintStyle: TextStyle(color: AppColors.grey200, fontSize: 13),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEndVisitButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.red200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      color: AppColors.red200,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'End Visit',
                      style: TextStyle(
                        color: AppColors.red200,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: AppColors.primary200,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
