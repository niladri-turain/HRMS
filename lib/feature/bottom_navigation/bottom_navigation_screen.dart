import 'package:flutter/material.dart';
import 'package:hrms_app/core/service/shared_pref_service.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images_png.dart';
import '../screen/accounts/account_screen.dart';
import '../screen/attendance/attendance_screen.dart';
import '../screen/clientVisit/client_visit_screen.dart';
import '../screen/dashboard/dashboard_screen.dart';
import '../screen/tasks/tasks_screen.dart';
import '../screen/dashboard/manager_dashboard_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  String _designationCode = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    final prefService = SharedPrefService();
    final code = await prefService.getDesignationCode();
    setState(() {
      _designationCode = code ?? '';
      _isLoading = false;
    });
  }

  List<Widget> get _screens {
    final bool isManager = _designationCode == 'MKT-HEAD';
    return [
      isManager ? const ManagerDashboardScreen() : const DashboardScreen(role: 'employee'),
      ClientVisitScreen(role: isManager ? "manager" : "employee"),
      const AttendanceScreen(),
      const TasksScreen(),
      const AccountScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildNavItem(int index, String icon, String label) {
    final isSelected = _selectedIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                icon,
                width: 16,
                height: 16,
                color: isSelected ? AppColors.primary200 : AppColors.grey100,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: isSelected ? AppColors.primary200 : AppColors.grey100,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.greyLight,
          border: Border(
            top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildNavItem(0, AppImagesPng.dashboardIcon, 'Dashboard'),
                SizedBox(width: 15,),
                _buildNavItem(1, AppImagesPng.clientVisitIcon, 'Clients Visits'),
                SizedBox(width: 15,),
                _buildNavItem(2, AppImagesPng.attendanceIcon, 'Attendance'),
                SizedBox(width: 0,),
                _buildNavItem(3, AppImagesPng.taskIcon, 'Tasks'),
                SizedBox(width: 0,),
                _buildNavItem(4, AppImagesPng.accountIcon, 'Account'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
