import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_colors.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import '../../../core/common_functions/timing.dart';
import 'client_details/client_details_screen.dart';

class ClientVisitScreen extends StatefulWidget {
  const ClientVisitScreen({super.key});

  @override
  State<ClientVisitScreen> createState() => _ClientVisitScreenState();
}

class _ClientVisitScreenState extends State<ClientVisitScreen> {
  int _selectedTab = 0; // 0 for Upcoming, 1 for Completed

  @override
  Widget build(BuildContext context) {
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
              // Header Section (Copied from Dashboard)
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
                            'Subrata Poriya, 08 Sep, 2026',
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
              
              // White Container for Content
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // Filter Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            const Text(
                              'Filter Search',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFFE5E7EB)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.primary200),
                                  SizedBox(width: 6),
                                  Text('01 Aug 2026', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFFE5E7EB)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.edit_outlined, size: 14, color: Color(0xFF6B7280)),
                                  SizedBox(width: 6),
                                  Text('All Status', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                                  SizedBox(width: 4),
                                  Icon(Icons.keyboard_arrow_down, size: 14, color: Color(0xFF6B7280)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Search Bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          height: 44,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search by Name, Client name, Location...',
                              hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                              prefixIcon: const Icon(Icons.search, color: Color(0xFF9CA3AF)),
                              contentPadding: const EdgeInsets.symmetric(vertical: 0),
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
                      ),
                      const SizedBox(height: 16),
                      // Tabs
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primary200.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() => _selectedTab = 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _selectedTab == 0 ? AppColors.primary200 : Colors.transparent,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Upcoming (5)',
                                      style: TextStyle(
                                        color: _selectedTab == 0 ? Colors.white : AppColors.primary200,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() => _selectedTab = 1),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _selectedTab == 1 ? AppColors.primary200 : Colors.transparent,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Completed (0)',
                                      style: TextStyle(
                                        color: _selectedTab == 1 ? Colors.white : AppColors.primary200,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // List of Visits
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          children: [
                            _buildVisitCard(
                              context,
                              'ABC Enterprises',
                              'Salt Lake Sector V, Kolkata',
                              '10:15 AM - 11:00 AM',
                              '1 Lac Bulksms & Whatsapp api requirement',
                            ),
                            _buildVisitCard(
                              context,
                              'XYZ Solutions',
                              'New Town, Kolkata',
                              '12:15 PM - 13:00 PM',
                              '1 Lac Bulksms & Whatsapp api requirement',
                            ),
                            _buildVisitCard(
                              context,
                              'Acme Pvt. Ltd.',
                              'Howrah Maidan, Howrah',
                              '15:00 PM - 15:30 PM',
                              'Billtrack Demo and installation',
                            ),
                            _buildVisitCard(
                              context,
                              'Acme Pvt. Ltd.',
                              'Howrah Maidan, Howrah',
                              '17:15 PM - 17:50 PM',
                              'Billtrack Demo and installation',
                            ),
                            _buildVisitCard(
                              context,
                              'Merlin group Ltd.',
                              'Tallyganj, Kolkata',
                              '18:05 PM - 18:30 PM',
                              'Billtrack Demo and installation',
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
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

  Widget _buildVisitCard(
    BuildContext context,
    String companyName,
    String location,
    String time,
    String purpose,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB), style: BorderStyle.solid),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
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
                  builder: (context) => const ClientDetailsScreen(status: 'Upcoming'),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF), // Light blue background
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                purpose,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E40AF), // Dark blue text
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
