import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_colors.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import '../../../core/common_functions/timing.dart';
import 'client_details/client_details_screen.dart';
import 'create_schedule/create_schedule_screen.dart';
import 'client_visit_screen.dart'; // For DashedBorderPainter

class ManagerClientVisitScreen extends StatefulWidget {
  const ManagerClientVisitScreen({super.key});

  @override
  State<ManagerClientVisitScreen> createState() => _ManagerClientVisitScreenState();
}

class _ManagerClientVisitScreenState extends State<ManagerClientVisitScreen> {
  bool _isTeamVisit = true;
  int _managerSubTab = 0; // 0: Total, 1: Upcoming, 2: Completed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateScheduleScreen()),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.primary200,
            borderRadius: BorderRadius.circular(25),

          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.add, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                'Create Schedule',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
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
              // Header Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage(AppImagesPng.persionIcon),
                          ),
                        ),
                        Positioned(
                          right: 2,
                          bottom: 2,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 1.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                Timing.getGreeting(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                Timing.getGreetingEmoji(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const Text(
                            'Niladri Roy, 09 Sep, 2026',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Image.asset(
                          AppImagesPng.notificationIcon,
                          width: 22,
                          height: 22,
                          color: Colors.white,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Container(
                      height: 24,
                      width: 24,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          AppImagesPng.powerButtonIcon,
                          width: 12,
                          color: AppColors.black,
                          height: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content Area
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    // Toggle Card (My Visit / Team Visit)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primary200.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildToggleButton('My Visit (2)', !_isTeamVisit, () => setState(() => _isTeamVisit = false)),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _buildToggleButton('Team Visit (5)', _isTeamVisit, () => setState(() => _isTeamVisit = true)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Filter Search',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Filter Row
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFE5E7EB)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF1F2937)),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          '01 Aug 2026 - 31 Aug 2026',
                                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF1F2937)),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFE5E7EB)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.edit_outlined, size: 16, color: Color(0xFF6B7280)),
                                      SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          'All Status',
                                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF1F2937)),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF6B7280)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Search Bar
                          SizedBox(
                            height: 38,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search by Name, Client name, Location...',
                                hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                                prefixIcon: const Icon(Icons.search, color: Color(0xFF1F2937), size: 20),
                                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                filled: true,
                                fillColor: const Color(0xFFF9FAFB),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Main List Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Sub-tabs
                          if (_isTeamVisit)
                            Row(
                              children: [
                                _buildSubTab('Total', '05', 0),
                                const SizedBox(width: 8),
                                _buildSubTab('Upcoming', '0', 1),
                                const SizedBox(width: 8),
                                _buildSubTab('Completed', '0', 2),
                              ],
                            ),
                          if (_isTeamVisit) const SizedBox(height: 20),

                          // Visits List
                          if (_isTeamVisit) ...[
                            _buildTeamVisitCard(
                              context,
                              'ABC Enterprises',
                              'Salt Lake Sector V, Kolkata',
                              '10:15 AM - 11:00 AM',
                              '1 Lac Bulksms & Whatsapp api requirement',
                              'Goutam Mazumder',
                              'In Progress',
                              AppImagesPng.persionIcon,
                            ),
                            _buildTeamVisitCard(
                              context,
                              'ABC Enterprises',
                              'Salt Lake Sector V, Kolkata',
                              '10:15 AM - 11:00 AM',
                              '1 Lac Bulksms & Whatsapp api requirement',
                              'Santanu Das',
                              'Upcoming',
                              AppImagesPng.persionIcon,
                            ),
                            _buildTeamVisitCard(
                              context,
                              'ABC Enterprises',
                              'Salt Lake Sector V, Kolkata',
                              '10:15 AM - 11:00 AM',
                              '1 Lac Bulksms & Whatsapp api requirement',
                              'Goutam Bakshi',
                              'Completed',
                              AppImagesPng.persionIcon,
                            ),
                            _buildTeamVisitCard(
                              context,
                              'ABC Enterprises',
                              'Salt Lake Sector V, Kolkata',
                              '10:15 AM - 11:00 AM',
                              '1 Lac Bulksms & Whatsapp api requirement',
                              'Priyanka Ghosh',
                              'Postponed',
                              AppImagesPng.persionIcon,
                            ),
                            _buildTeamVisitCard(
                              context,
                              'ABC Enterprises',
                              'Salt Lake Sector V, Kolkata',
                              '10:15 AM - 11:00 AM',
                              '1 Lac Bulksms & Whatsapp api requirement',
                              'Goutam Mazumder',
                              'Cancel',
                              AppImagesPng.persionIcon,
                            ),
                          ] else ...[
                            _buildMyVisitCard(
                              context,
                              'ABC Enterprises',
                              'Salt Lake Sector V, Kolkata',
                              '10:15 AM - 11:00 AM',
                              '1 Lac Bulksms & Whatsapp api requirement',
                            ),
                            _buildMyVisitCard(
                              context,
                              'XYZ Solutions',
                              'New Town, Kolkata',
                              '12:15 PM - 13:00 PM',
                              '1 Lac Bulksms & Whatsapp api requirement',
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 80), // Space for FAB
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary200 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: !isSelected ? Border.all(color: AppColors.primary200.withOpacity(0.5)) : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.primary200,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildSubTab(String label, String count, int index) {
    bool isSelected = _managerSubTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _managerSubTab = index),
        child: Container(
          height: 38,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary200 : Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isSelected ? AppColors.primary200 : const Color(0xFFC084FC).withOpacity(0.5),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            '$label ($count)',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.primary200,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMyVisitCard(
    BuildContext context,
    String companyName,
    String location,
    String time,
    String purpose,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: CustomPaint(
        foregroundPainter: DashedBorderPainter(
          color: const Color(0xFFD1D5DB),
          borderRadius: 8,
          dashWidth: 3,
          dashSpace: 2,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          companyName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          location,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Schedule Time',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111827),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ClientDetailsScreen(
                        status: 'Upcoming',
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A79D7).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    purpose,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1C2263),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamVisitCard(
    BuildContext context,
    String companyName,
    String location,
    String time,
    String purpose,
    String employeeName,
    String status,
    String avatarUrl,
  ) {
    Color statusTextColor;
    Color statusBgColor;
    Color statusBorderColor;

    switch (status) {
      case 'In Progress':
        statusTextColor = const Color(0xFFDFAF00);
        statusBgColor = const Color(0xFFFFFBEB);
        statusBorderColor = const Color(0xFFFEF3C7);
        break;
      case 'Upcoming':
        statusTextColor = const Color(0xFF2563EB);
        statusBgColor = const Color(0xFFEFF6FF);
        statusBorderColor = const Color(0xFFDBEAFE);
        break;
      case 'Completed':
        statusTextColor = const Color(0xFF10B981);
        statusBgColor = const Color(0xFFECFDF5);
        statusBorderColor = const Color(0xFFD1FAE5);
        break;
      case 'Postponed':
        statusTextColor = const Color(0xFF6366F1);
        statusBgColor = const Color(0xFFEEF2FF);
        statusBorderColor = const Color(0xFFE0E7FF);
        break;
      case 'Cancel':
        statusTextColor = const Color(0xFFEF4444);
        statusBgColor = const Color(0xFFFEF2F2);
        statusBorderColor = const Color(0xFFFEE2E2);
        break;
      default:
        statusTextColor = const Color(0xFF6B7280);
        statusBgColor = const Color(0xFFF9FAFB);
        statusBorderColor = const Color(0xFFF3F4F6);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: CustomPaint(
        foregroundPainter: DashedBorderPainter(
          color: const Color(0xFFE5E7EB),
          borderRadius: 8,
          dashWidth: 3,
          dashSpace: 2,
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage(avatarUrl),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Employee Details',
                          style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF), fontWeight: FontWeight.w500),
                        ),
                        Text(
                          employeeName,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1F2937)),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Schedule Time',
                        style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF), fontWeight: FontWeight.w500),
                      ),
                      Text(
                        time,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        companyName,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1C2263)),
                      ),
                      Text(
                        location,
                        style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusBgColor,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: statusBorderColor),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: statusTextColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClientDetailsScreen(status: status),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBF5FF),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    purpose,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1C2263)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
