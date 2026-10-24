import 'package:flutter/material.dart';
import 'package:hrms_app/core/common_functions/timing.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import 'package:hrms_app/core/service/shared_pref_service.dart';
import 'package:hrms_app/feature/screen/attendance/widget/attendance_overview_card.dart';
import 'package:hrms_app/feature/screen/attendance/widget/attendance_status_card.dart';
import 'package:hrms_app/feature/screen/attendance/widget/attendance_timeline_card.dart';
import 'package:provider/provider.dart';
import '../../provider/login_provider.dart';
import '../loginScreen/login_screen.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String _userName = 'User';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final name = await SharedPrefService().getName();
    if (name != null && mounted) {
      setState(() {
        _userName = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF311040), Color(0xFFFFFFFF)],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(AppImagesPng.persionIcon),
                      ),
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
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        const Icon(Icons.notifications_outlined, color: Colors.white, size: 24),
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
                    GestureDetector(
                      onTap: () async {
                        final success = await context.read<LoginProvider>().logout();
                        if (success && mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                            (route) => false,
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.power_settings_new, size: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const AttendanceStatusCard(),
                      const SizedBox(height: 16),
                      const AttendanceOverviewCard(),
                      const SizedBox(height: 16),
                      const AttendanceTimelineCard(),
                      const SizedBox(height: 20),
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
}
