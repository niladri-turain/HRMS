import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_colors.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import 'widget/account_profile_header.dart';
import 'widget/account_menu_section.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImagesPng.accountsBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const AccountProfileHeader(),
                
                AccountMenuSection(
                  title: 'HR & Leave',
                  items: [
                    AccountMenuItem(
                      iconPath: AppImagesPng.applyLeave,
                      label: 'Apply Leave',
                      subLabel: 'Submit a leave request',
                      iconBgColor: const Color(0xFFFEF3C7),
                    ),
                    AccountMenuItem(
                      iconPath: AppImagesPng.leaveHistory,
                      label: 'Leave History',
                      subLabel: 'View your leave requests and status',
                      iconBgColor: const Color(0xFFFFF7ED),
                    ),
                  ],
                ),
                
                AccountMenuSection(
                  title: 'Work & Productivity',
                  items: [
                    AccountMenuItem(
                      iconPath: AppImagesPng.myTask,
                      label: 'My Tasks',
                      subLabel: 'View and manage your tasks',
                      iconBgColor: const Color(0xFFEEF2FF),
                    ),
                    AccountMenuItem(
                      iconPath: AppImagesPng.report,
                      label: 'Reports',
                      subLabel: 'View your reports and activity summary',
                      iconBgColor: const Color(0xFFF5F3FF),
                    ),
                  ],
                ),
                
                AccountMenuSection(
                  title: 'Communication',
                  items: [
                    AccountMenuItem(
                      iconPath: AppImagesPng.announcement,
                      label: 'Announcements',
                      subLabel: 'Company updates and important information',
                      iconBgColor: const Color(0xFFECFDF5),
                    ),
                    AccountMenuItem(
                      iconPath: AppImagesPng.notifications,
                      label: 'Notification',
                      subLabel: 'View your notifications',
                      trailingBadge: '12',
                      iconBgColor: const Color(0xFFF0FDF4),
                    ),
                  ],
                ),
                
                AccountMenuSection(
                  title: 'Support & Account',
                  items: [
                    AccountMenuItem(
                      iconPath: AppImagesPng.help,
                      label: 'Help & Support',
                      subLabel: 'FAQs, user guides and support',
                      iconBgColor: const Color(0xFFF5F3FF),
                    ),
                    AccountMenuItem(
                      iconPath: AppImagesPng.appSettings,
                      label: 'App Settings',
                      subLabel: 'Language, privacy and app preference',
                      iconBgColor: const Color(0xFFFDF4FF),
                    ),
                    AccountMenuItem(
                      iconPath: AppImagesPng.profileSettings,
                      label: 'My Profile',
                      subLabel: 'View and updates your profile',
                      iconBgColor: const Color(0xFFF5F3FF),
                    ),
                  ],
                ),
                
                AccountMenuSection(
                  title: 'Support & Account',
                  items: [
                    AccountMenuItem(
                      iconPath: AppImagesPng.logout,
                      label: 'Logout',
                      subLabel: 'Sign out securely from your account',
                      iconBgColor: const Color(0xFFFFF1F2),
                    ),
                    AccountMenuItem(
                      iconPath: AppImagesPng.deleteAccount,
                      label: 'Delete Account',
                      subLabel: 'Permanently remove your account and data',
                      iconBgColor: const Color(0xFFFFF1F2),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
