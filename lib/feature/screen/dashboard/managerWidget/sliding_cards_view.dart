import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hrms_app/core/constants/app_colors.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import 'package:hrms_app/feature/provider/managerProvider/employee_list_provider.dart';
import 'package:hrms_app/feature/model/employee_list_model.dart';

class SlidingCardsView extends StatefulWidget {
  const SlidingCardsView({super.key});

  @override
  State<SlidingCardsView> createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  bool isTeamTracking = true;
  final PageController _teamPageController = PageController(viewportFraction: 0.93);
  final PageController _clientPageController = PageController(viewportFraction: 0.93);

  // Mock Data for Client Visit
  final List<Map<String, dynamic>> clientData = [
    {
      'name': 'Goutam Mazumder',
      'company': 'ABC Enterprises',
      'location': 'Salt Lake Sector V, Kolkata',
      'time': '10:15 AM - 11:00 AM',
      'status': 'In Progress',
      'requirement': '1 Lac Bulksms & Whatsapp api requirement',
    },
    {
      'name': 'Niladri Roy',
      'company': 'XYZ Solutions',
      'location': 'Sector III, Salt Lake, Kolkata',
      'time': '12:00 PM - 01:00 PM',
      'status': 'Scheduled',
      'requirement': 'Cloud migration discussion & architecture planning',
    },
    {
      'name': 'Tanmay Pal',
      'company': 'PQR Technologies',
      'location': 'Sector V, Kolkata',
      'time': '02:30 PM - 03:30 PM',
      'status': 'Completed',
      'requirement': 'HRMS product demo & feature walkthrough',
    },
    {
      'name': 'Vikram Jit',
      'company': 'WebSpiders',
      'location': 'Sector I, Salt Lake, Kolkata',
      'time': '04:00 PM - 05:00 PM',
      'status': 'Scheduled',
      'requirement': 'Annual maintenance contract renewal discussion',
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EmployeeListProvider>(context, listen: false).fetchEmployeeList();
    });
  }

  @override
  void dispose() {
    _teamPageController.dispose();
    _clientPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeListProvider>(context);

    return Column(
      children: [
        // Toggle Buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => isTeamTracking = true);
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: isTeamTracking ? AppColors.primary200 : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.primary200,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Team Tracking (${employeeProvider.employees.length})',
                      style: TextStyle(
                        color: isTeamTracking ? Colors.white : AppColors.primary200,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => isTeamTracking = false);
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: !isTeamTracking ? AppColors.primary200 : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.primary200,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Client Visit (${clientData.length})',
                      style: TextStyle(
                        color: !isTeamTracking ? Colors.white : AppColors.primary200,
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
        const SizedBox(height: 20),
        
        // Card Deck Content View
        isTeamTracking ? _buildTeamTrackingDeck(employeeProvider) : _buildClientVisitDeck(),
      ],
    );
  }

  // Beautiful Stacked Deck for Team Tracking
  Widget _buildTeamTrackingDeck(EmployeeListProvider provider) {
    if (provider.isLoading) {
      return const SizedBox(
        height: 210,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (provider.errorMessage != null) {
      return SizedBox(
        height: 210,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              provider.errorMessage!,
              style: const TextStyle(color: Colors.redAccent, fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    if (provider.employees.isEmpty) {
      return const SizedBox(
        height: 210,
        child: Center(
          child: Text(
            'No employee list found',
            style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return SizedBox(
      height: 210,
      child: PageView.builder(
        controller: _teamPageController,
        itemCount: provider.employees.length,
        itemBuilder: (context, index) {
          final item = provider.employees[index];
          final remaining = provider.employees.length - 1 - index;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                // 3rd Deepest Layer
                if (remaining >= 2)
                  Positioned(
                    top: 24,
                    left: 24,
                    right: 24,
                    child: Container(
                      height: 165,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B4760).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                // 2nd Middle Layer
                if (remaining >= 1)
                  Positioned(
                    top: 12,
                    left: 12,
                    right: 12,
                    child: Container(
                      height: 165,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B4760).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                // Top Main Card Card
                _buildTeamTrackingCard(item),
              ],
            ),
          );
        },
      ),
    );
  }

  // Individual Team Tracking Card Layout matching the screenshot perfectly
  Widget _buildTeamTrackingCard(EmployeeData item) {
    final bool isLive = item.status == 'Live';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF3B4760),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Employee Header Row
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: item.avatarUrl != null && item.avatarUrl!.isNotEmpty
                    ? NetworkImage(item.avatarUrl!)
                    : const AssetImage(AppImagesPng.persionIcon) as ImageProvider,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Employee Details',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    item.name ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Live Status Pill Container
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: (isLive ? Colors.green : Colors.orange).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: (isLive ? Colors.green : Colors.orange).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: isLive ? const Color(0xFF00C853) : Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item.status ?? 'Live',
                      style: TextStyle(
                        color: isLive ? const Color(0xFF00C853) : Colors.orange,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Last Location Section
          Text(
            'Last Location',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            item.lastLocation ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 14),
          // Inner Translucent Details Box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.12),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last Seen',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.lastSeen ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                // Outlined Button matching image
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withOpacity(0.6),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'View on Map',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Beautiful Stacked Deck for Client Visit
  Widget _buildClientVisitDeck() {
    return SizedBox(
      height: 190,
      child: PageView.builder(
        controller: _clientPageController,
        itemCount: clientData.length,
        itemBuilder: (context, index) {
          final item = clientData[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: _buildClientVisitCard(item),
          );
        },
      ),
    );
  }

  // Individual Client Visit Card Layout matching the branding colors
  Widget _buildClientVisitCard(Map<String, dynamic> item) {
    final bool isCompleted = item['status'] == 'Completed';
    final bool isInProgress = item['status'] == 'In Progress';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF3E2D4C),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header Row
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage(AppImagesPng.persionIcon),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Employee Details',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    item['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Schedule Time',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    item['time'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Company details & Status Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['company'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    item['location'],
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: (isCompleted
                          ? Colors.green
                          : isInProgress
                              ? Colors.orange
                              : Colors.blue)
                      .withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: (isCompleted
                            ? Colors.green
                            : isInProgress
                                ? Colors.orange
                                : Colors.blue)
                        .withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  item['status'],
                  style: TextStyle(
                    color: isCompleted
                        ? const Color(0xFF00C853)
                        : isInProgress
                            ? Colors.orange
                            : Colors.blue,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Requirements inner container box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.12),
                width: 1,
              ),
            ),
            child: Text(
              item['requirement'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
