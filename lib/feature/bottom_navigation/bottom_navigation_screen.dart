import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images_png.dart';
import '../screen/accounts/account_screen.dart';
import '../screen/attendance/attendance_screen.dart';
import '../screen/clientVisit/client_visit_screen.dart';
import '../screen/dashboard/dashboard_screen.dart';
import '../screen/tasks/tasks_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const ClientVisitScreen(role: "manager"),
    const AttendanceScreen(),
    const TasksScreen(),
    const AccountScreen(),
  ];

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
