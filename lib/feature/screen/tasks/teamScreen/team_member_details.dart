import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import 'package:hrms_app/core/constants/app_sizes.dart';
import 'package:hrms_app/feature/screen/tasks/widgets/manager_task_dashboard_widgets.dart';

import '../projectScreen/manager_project_list_screen.dart';

class TeamMemberDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> member;

  const TeamMemberDetailsScreen({super.key, required this.member});

  @override
  State<TeamMemberDetailsScreen> createState() => _TeamMemberDetailsScreenState();
}

class _TeamMemberDetailsScreenState extends State<TeamMemberDetailsScreen> {
  int _selectedTabIndex = 0; // 0: Overview, 1: Projects, 2: Tasks

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: false,
        titleSpacing: -10,
        title: Text(
          widget.member['name'],
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
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
              _buildMemberProfileCard(),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    children: [

                      Container(

                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 15),
                          decoration: BoxDecoration(
                            color: const Color(0xFF901AEA).withValues(alpha: 0.05),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: _buildTabSection()),
                      const SizedBox(height: 8),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: _buildTabContent(),
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

  Widget _buildMemberProfileCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              widget.member['image'],
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.member['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Text(
                  widget.member['role'],
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF901AEA),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.phone_outlined, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    const Text(
                      '91 9932985137',
                      style: TextStyle(fontSize: 10, color: Color(0xFF6B7280),fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.email_outlined, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${widget.member['name'].toLowerCase().replaceAll(' ', '')}@gmail.com',
                        style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280),fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTabItem('Overview', 0),
            const SizedBox(width: 8),
            _buildTabItem('Projects', 1),
            const SizedBox(width: 8),
            _buildTabItem('Tasks', 2),
          ],

            ),
      );
  }

  Widget _buildTabItem(String title, int index) {
    bool isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTabIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF901AEA) : Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: isSelected ? Colors.transparent : const Color(0xFF901AEA).withValues(alpha: 0.2),
            ),

          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF901AEA),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildOverviewTab();
      case 1:
        return _buildProjectsTab();
      case 2:
        return _buildTasksTab();
      default:
        return _buildOverviewTab();
    }
  }

  Widget _buildOverviewTab() {
    return Column(
      children: [
        _buildProjectDetailsGrid(),
        const SizedBox(height: 20),
        const TaskChartCard(
          totalTasks: '120',
          data: [
            ChartData(color: Color(0xFF4361EE), label: 'In Progress', value: '18', percentage: 15.00),
            ChartData(color: Color(0xFF06D6A0), label: 'Completed', value: '7', percentage: 5.88),
            ChartData(color: Color(0xFFEF233C), label: 'Overdue', value: '3', percentage: 2.5),
            ChartData(color: Color(0xFF8D99AE), label: 'To Do', value: '92', percentage: 76.60),
          ],
        ),
        const SizedBox(height: 20),
        const RecentActivitiesSection(),
      ],
    );
  }

  static Widget _buildProjectDetailsGrid() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFC6C6C6).withValues(alpha: 0.20),
            blurRadius: 2,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Project Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF901AEA),
            ),
          ),
          const SizedBox(height: 8),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.8,
            children: [
              _buildOverviewProjectCard(
                color: const Color(0xFF7C45DA),
                icon: AppImagesPng.totalProject,
                title: 'Total Projects',
                value: '6',
              ),
              _buildOverviewProjectCard(
                color: const Color(0xFF111827),
                icon: AppImagesPng.totalAssign,
                title: 'Total Assign Tasks',
                value: '120',
              ),
              _buildOverviewProjectCard(
                color: const Color(0xFF03C95A),
                icon: AppImagesPng.completeTask,
                title: 'Completed Project',
                value: '2',
              ),
              _buildOverviewProjectCard(
                color: const Color(0xFF1A79D7),
                icon: AppImagesPng.inProgressTask,
                title: 'In Progress Tasks',
                value: '18',
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildOverviewProjectCard({
    required Color color,
    required String icon,
    required String title,
    required String value,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: double.infinity,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(9),
                bottomLeft: Radius.circular(9),
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Center(
              child: Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Image.asset(icon, color: color),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 20,
                      color: color,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildProjectsTab() {
    final List<Map<String, dynamic>> projects = [
      {
        'logo': AppImagesPng.splashLogo,
        'title': 'HRMS software crm',
        'tasks': '28 / 120 Tasks',
        'category': 'HRMS',
        'progress': 0.23,
        'description': 'Create high-fidelity UI for employee dashboard as per latest discussion. Follow the approved design system and...',
        'estimatedTime': '50d 14h',
        'dueDate': '25 Nov 2026',
        'assignedBy': 'Sabyasachi...',
        'assignedByImage': 'https://i.pravatar.cc/150?u=100',
      },
      {
        'logo': AppImagesPng.splashLogo,
        'title': 'Quick billing application',
        'tasks': '48 / 54 Tasks',
        'category': 'Billtrack',
        'progress': 0.88,
        'description': 'Create high-fidelity UI for employee dashboard as per latest discussion. Follow the approved design system and...',
        'estimatedTime': '28h 30m',
        'dueDate': '30 Sep 2026',
        'assignedBy': 'Sabyasachi...',
        'assignedByImage': 'https://i.pravatar.cc/150?u=100',
      },
      {
        'logo': AppImagesPng.splashLogo,
        'title': 'Website design EV sector',
        'tasks': '2 / 12 Tasks',
        'category': 'HRMS',
        'progress': 0.16,
        'description': 'Create high-fidelity UI for employee dashboard as per latest discussion. Follow the approved design system and...',
        'estimatedTime': '48h 30m',
        'dueDate': '25 Nov 2026',
        'assignedBy': 'Sabyasachi...',
        'assignedByImage': 'https://i.pravatar.cc/150?u=100',
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: projects.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final project = projects[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFC6C6C6).withValues(alpha: 0.20),
                blurRadius: 2,
                offset: const Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Image.asset(project['logo']),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project['title'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              project['tasks'],
                              style: const TextStyle(color: Color(0xFF6B7280), fontSize: 10, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFF901AEA).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                project['category'],
                                style: const TextStyle(
                                  color: Color(0xFF901AEA),
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  CircularPercentIndicator(
                    percent: project['progress'],
                    progressColor: const Color(0xFF00C853),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                project['description'],
                style: const TextStyle(color: Color(0XFF6B7280), fontSize: 12, fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              const DottedDivider(),
              const SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundImage: NetworkImage(project['assignedByImage']),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Assigned By', style: TextStyle(color: Colors.grey, fontSize: 8)),
                      Text(
                        project['assignedBy'],
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Estimated Time', style: TextStyle(color: Colors.grey, fontSize: 8)),
                          Text(
                            project['estimatedTime'],
                            style: const TextStyle(
                              color: Color(0xFF4361EE),
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Due Date', style: TextStyle(color: Colors.grey, fontSize: 8)),
                          Text(
                            project['dueDate'],
                            style: const TextStyle(
                              color: Color(0xFFD4A017),
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTasksTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100),
          Icon(Icons.assignment_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No Tasks Found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
