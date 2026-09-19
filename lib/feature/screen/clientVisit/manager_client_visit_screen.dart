import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_colors.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import 'package:hrms_app/core/service/shared_pref_service.dart';
import 'package:hrms_app/feature/provider/managerProvider/manager_client_visit_provider.dart';
import 'package:provider/provider.dart';
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
  String _userName = 'Manager';
  String _selectedStatus = 'all';
  String? _employeeId;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final name = await SharedPrefService().getName();
    final employeeId = await SharedPrefService().getEmployeeId();
    if (mounted) {
      setState(() {
        _userName = name ?? 'Manager';
        _employeeId = employeeId;
      });
      _fetchData();
    }
  }

  void _fetchData() {
    context.read<ManagerClientVisitProvider>().fetchManagerClientVisits(
          status: _selectedStatus,
          employeeId: _isTeamVisit ? null : _employeeId,
        );
  }

  void _onTabChanged(int index) {
    setState(() {
      _managerSubTab = index;
      if (index == 0) _selectedStatus = 'all';
      if (index == 1) _selectedStatus = 'upcoming';
      if (index == 2) _selectedStatus = 'completed';
    });
    _fetchData();
  }

  void _toggleVisitType(bool isTeamVisit) {
    if (_isTeamVisit != isTeamVisit) {
      setState(() {
        _isTeamVisit = isTeamVisit;
      });
      _fetchData();
    }
  }

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
      body: Consumer<ManagerClientVisitProvider>(
        builder: (context, provider, child) {
          final summary = provider.visitListModel?.data?.summary;
          final visits = provider.visitListModel?.data?.visits ?? [];
          final isLoading = provider.isLoading;

          return Container(
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
                              Text(
                                '$_userName, ${Timing.getCurrentDate()}',
                                style: const TextStyle(
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
                                      child: _buildToggleButton('My Visit', !_isTeamVisit, () => _toggleVisitType(false)),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: _buildToggleButton('Team Visit', _isTeamVisit, () => _toggleVisitType(true)),
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
                                        children: [
                                          const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF1F2937)),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              provider.visitListModel?.data?.filters?.date ?? Timing.getCurrentDate(),
                                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF1F2937)),
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
                                  onChanged: (value) {
                                    provider.fetchManagerClientVisits(
                                      status: _selectedStatus,
                                      search: value,
                                      employeeId: _isTeamVisit ? null : _employeeId,
                                    );
                                  },
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
                              Row(
                                children: [
                                  _buildSubTab('Total', '${summary?.total ?? 0}', 0),
                                  const SizedBox(width: 8),
                                  _buildSubTab('Upcoming', '${summary?.upcoming ?? 0}', 1),
                                  const SizedBox(width: 8),
                                  _buildSubTab('Completed', '${summary?.completed ?? 0}', 2),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // Visits List
                              isLoading
                                  ? const Center(child: CircularProgressIndicator())
                                  : visits.isEmpty
                                      ? const Center(child: Text('No visits found'))
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: visits.length,
                                          itemBuilder: (context, index) {
                                            final visit = visits[index];
                                            return _buildTeamVisitCard(
                                              context,
                                              visit.clientName ?? 'N/A',
                                              visit.clientAddress ?? 'N/A',
                                              visit.scheduleTime ?? 'N/A',
                                              visit.purpose ?? 'N/A',
                                              visit.employeeName ?? 'N/A',
                                              visit.statusLabel ?? 'N/A',
                                              visit.employeeAvatarUrl ?? '',
                                              visit.statusBadge?.color ?? '#6B7280',
                                              visit.statusBadge?.bgColor ?? '#F9FAFB',
                                              visit.statusBadge?.borderColor ?? '#F3F4F6',
                                            );
                                          },
                                        ),
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
          );
        },
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
        onTap: () => _onTabChanged(index),
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

  Widget _buildTeamVisitCard(
    BuildContext context,
    String companyName,
    String location,
    String time,
    String purpose,
    String employeeName,
    String status,
    String avatarUrl,
    String statusColor,
    String statusBgColor,
    String statusBorderColor,
  ) {
    Color hexToColor(String hex) {
      hex = hex.replaceFirst('#', '');
      if (hex.length == 6) hex = 'FF$hex';
      return Color(int.parse(hex, radix: 16));
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
                    backgroundImage: avatarUrl.startsWith('http') ? NetworkImage(avatarUrl) : AssetImage(AppImagesPng.persionIcon) as ImageProvider,
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
                  Expanded(
                    child: Column(
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
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: hexToColor(statusBgColor),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: hexToColor(statusBorderColor)),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: hexToColor(statusColor)),
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
