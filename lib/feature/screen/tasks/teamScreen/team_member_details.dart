import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import 'package:hrms_app/core/constants/app_sizes.dart';
import 'package:hrms_app/feature/screen/tasks/widgets/manager_task_dashboard_widgets.dart';
import 'package:hrms_app/feature/model/tasks/task_model.dart';
import 'package:hrms_app/feature/screen/tasks/task_details_screen.dart';

import '../projectScreen/manager_project_list_screen.dart';

class TeamMemberDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> member;

  const TeamMemberDetailsScreen({super.key, required this.member});

  @override
  State<TeamMemberDetailsScreen> createState() => _TeamMemberDetailsScreenState();
}

class _TeamMemberDetailsScreenState extends State<TeamMemberDetailsScreen> {
  int _selectedTabIndex = 0; // 0: Overview, 1: Projects, 2: Tasks

  // Tasks Tab State
  int _activeTaskTab = 0; // 0: All Jobs, 1: To Do, 2: In Progress, 3: Complete
  int _expandedTaskIndex = 0;
  final TextEditingController _taskSearchController = TextEditingController();

  final List<TaskModel> _allTasks = [
    TaskModel(
      id: 'TSK-101',
      clientProject: 'Bill Track',
      title: 'UI/UX Wireframe Redesign',
      assignBy: 'Sabyasachi Gupta',
      assignInitials: 'SP',
      dueDate: '25 Sep, 2024',
      status: 'In Progress',
      priority: 'Urgent',
      subTasksCount: '3/5',
      progress: 0.60,
      commentsCount: 3,
      attachmentsCount: 2,
      assignedOn: '15 Sep 2026 | 10:46 AM',
      estimatedTime: '48h 30m',
      durationCover: '38h 30m',
      description: 'Create high-fidelity UI for employee dashboard as per latest discussion. Follow the approved design system and ensure mobile responsive layouts.',
    ),
    TaskModel(
      id: 'TSK-102',
      clientProject: 'Bill Track',
      title: 'User Authentication API Fix',
      assignBy: 'Rahul Maji',
      assignInitials: 'RM',
      dueDate: '27 Sep, 2024',
      status: 'In Review',
      priority: 'High',
      subTasksCount: '0/2',
      progress: 0.0,
      commentsCount: 0,
      attachmentsCount: 0,
      assignedOn: '16 Sep 2024 | 11:00 AM',
      estimatedTime: '12h 00m',
      durationCover: '0h 0m',
      description: 'Resolve session timeout issue and optimize JWT token refresh mechanism across all client platforms.',
    ),
    TaskModel(
      id: 'TSK-103',
      clientProject: 'HRMS',
      title: 'QA Testing for Mobile App',
      assignBy: 'Rahul Maji',
      assignInitials: 'RM',
      dueDate: '24 Sep, 2024',
      status: 'Completed',
      priority: 'Normal',
      subTasksCount: '1/1',
      progress: 1.0,
      commentsCount: 1,
      attachmentsCount: 0,
      assignedOn: '12 Sep 2024 | 09:30 AM',
      estimatedTime: '20h 00m',
      durationCover: '20h 00m',
      description: 'Perform full regression testing on the beta build, focus specifically on offline check-in/out scenarios.',
    ),
    TaskModel(
      id: 'TSK-104',
      clientProject: 'STTN',
      title: 'Payment Gateway Integration',
      assignBy: 'Buddhadeb Changdar',
      assignInitials: 'BC',
      dueDate: '21 Sep, 2024',
      status: 'TO DO',
      priority: 'Low',
      subTasksCount: '0/1',
      progress: 0.0,
      commentsCount: 0,
      attachmentsCount: 0,
      assignedOn: '18 Sep 2024 | 04:15 PM',
      estimatedTime: '30h 00m',
      durationCover: '0h 0m',
      description: 'Integrate Razorpay SDK for standard credit card, UPI, and net banking transactions including webhook validation.',
    ),
  ];

  List<TaskModel> get _filteredTasks {
    List<TaskModel> tasks = _allTasks;

    // Filter by tab
    if (_activeTaskTab == 1) {
      tasks = tasks.where((t) => t.status == 'TO DO').toList();
    } else if (_activeTaskTab == 2) {
      tasks = tasks.where((t) => t.status == 'In Progress' || t.status == 'In Review').toList();
    } else if (_activeTaskTab == 3) {
      tasks = tasks.where((t) => t.status == 'Completed').toList();
    }

    // Filter by search query
    if (_taskSearchController.text.isNotEmpty) {
      final query = _taskSearchController.text.toLowerCase();
      tasks = tasks.where((t) =>
      t.title.toLowerCase().contains(query) ||
          t.id.toLowerCase().contains(query) ||
          t.clientProject.toLowerCase().contains(query)).toList();
    }

    return tasks;
  }

  int _getTaskTabCount(int tabIndex) {
    if (tabIndex == 0) return _allTasks.length;
    if (tabIndex == 1) return _allTasks.where((t) => t.status == 'TO DO').length;
    if (tabIndex == 2) return _allTasks.where((t) => t.status == 'In Progress' || t.status == 'In Review').length;
    if (tabIndex == 3) return _allTasks.where((t) => t.status == 'Completed').length;
    return 0;
  }

  @override
  void dispose() {
    _taskSearchController.dispose();
    super.dispose();
  }

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
        color: const Color(0xFF311040),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildMemberProfileCard(),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
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
        const SizedBox(height: 20),
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
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(10),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                          const Text('Assigned By', style: TextStyle(color: Color(0xFF6B7280), fontSize: 8, fontWeight: FontWeight.w500)),
                          Text(
                            project['assignedBy'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 20, color: Color(0xFF6B7280)),
                      const SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Estimated Time', style: TextStyle(color: Color(0xFF6B7280), fontSize: 8, fontWeight: FontWeight.w500)),
                          Text(
                            project['estimatedTime'],
                            style: const TextStyle(
                              color: Color(0xFF1A79D7),
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 20, color: Color(0xFF6B7280)),
                      const SizedBox(width: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Due Date', style: TextStyle(color: Color(0xFF6B7280), fontSize: 8, fontWeight: FontWeight.w500)),
                          Text(
                            project['dueDate'],
                            style: const TextStyle(
                              color: Color(0xFFDFAF00),
                              fontWeight: FontWeight.w700,
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
    return Column(
      children: [
        // Tabs Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildTaskTabItem('All Jobs', 0),
                const SizedBox(width: 8),
                _buildTaskTabItem('To Do', 1),
                const SizedBox(width: 8),
                _buildTaskTabItem('In Progress', 2),
                const SizedBox(width: 8),
                _buildTaskTabItem('Complete', 3),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Search Input Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: TextField(
              controller: _taskSearchController,
              onChanged: (value) => setState(() {}),
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              decoration: const InputDecoration(
                hintText: 'Search tasks by title, project or client...',
                hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 2.0, top: 5),
                  child: Icon(Icons.search, color: Color(0xFF9CA3AF), size: 18),
                ),
                prefixIconConstraints: BoxConstraints(),
                isDense: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 2),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        const TaskChartCard(
          totalTasks: '120',
          data: [
            ChartData(color: Color(0xFF4361EE), label: 'In Progress', value: '18', percentage: 15.00),
            ChartData(color: Color(0xFF06D6A0), label: 'Completed', value: '7', percentage: 5.88),
            ChartData(color: Color(0xFFEF233C), label: 'Overdue', value: '3', percentage: 2.5),
            ChartData(color: Color(0xFF8D99AE), label: 'To Do', value: '92', percentage: 76.60),
          ],
        ),

        const SizedBox(height: 16),

        // Tasks List
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _filteredTasks.length,
          itemBuilder: (context, index) {
            final task = _filteredTasks[index];
            final isExpanded = _expandedTaskIndex == index;

            return InternalTaskItemWidget(
              task: task,
              isExpanded: isExpanded,
              onTap: () {
                setState(() {
                  _expandedTaskIndex = isExpanded ? -1 : index;
                });
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildTaskTabItem(String label, int index) {
    final isSelected = _activeTaskTab == index;
    final count = _getTaskTabCount(index);
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeTaskTab = index;
          _expandedTaskIndex = 0; // reset expansion to first item of new tab
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF901AEA) : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? const Color(0xFF901AEA) : const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
        child: Text(
          '$label ($count)',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF901AEA),
          ),
        ),
      ),
    );
  }
}

class InternalTaskItemWidget extends StatelessWidget {
  final TaskModel task;
  final bool isExpanded;
  final VoidCallback onTap;

  const InternalTaskItemWidget({
    super.key,
    required this.task,
    required this.isExpanded,
    required this.onTap,
  });

  // Get Priority configurations mapping
  PriorityConfig _getPriorityConfig(String priority) {
    switch (priority.toLowerCase()) {
      case 'urgent':
        return PriorityConfig(
          textColor: const Color(0xFFEF4444),
          bgColor: const Color(0xFFFEF2F2),
          borderColor: const Color(0xFFFEE2E2),
          leftBarColor: const Color(0xFFEF4444),
        );
      case 'high':
        return PriorityConfig(
          textColor: const Color(0xFFDFAF00),
          bgColor: const Color(0xFFFFFBEB),
          borderColor: const Color(0xFFFEF3C7),
          leftBarColor: const Color(0xFFDFAF00),
        );
      case 'normal':
        return PriorityConfig(
          textColor: const Color(0xFFDFC900),
          bgColor: const Color(0xFFFEFCE8),
          borderColor: const Color(0xFFFEF08A),
          leftBarColor: const Color(0xFFDFC900),
        );
      case 'low':
      default:
        return PriorityConfig(
          textColor: const Color(0xFF6B7280),
          bgColor: const Color(0xFFF9FAFB),
          borderColor: const Color(0xFFE5E7EB),
          leftBarColor: const Color(0xFF6B7280),
        );
    }
  }

  // Get Status dropdown style configurations
  Color _getStatusBgColor(String status) {
    if (status == 'Completed') return const Color(0xFFDCFCE7);
    if (status == 'In Review') return const Color(0xFFF3E8FF);
    if (status == 'In Progress') return const Color(0xFFEFF6FF);
    return const Color(0xFFF3F4F6); // TO DO
  }

  Color _getStatusTextColor(String status) {
    if (status == 'Completed') return const Color(0xFF16A34A);
    if (status == 'In Review') return const Color(0xFF9333EA);
    if (status == 'In Progress') return const Color(0xFF2563EB);
    return const Color(0xFF374151); // TO DO
  }

  @override
  Widget build(BuildContext context) {
    final config = _getPriorityConfig(task.priority);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Left Border Indicator Bar Only
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 1.5,
              child: Container(
                color: config.leftBarColor,
              ),
            ),

            // Content Area
            Padding(
              padding: const EdgeInsets.only(left: 15.5, right: 14, top: 12, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Info Row (ID | Project --- Priority Badge)
                  Row(
                    children: [
                      Text(
                        task.id,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Text('|', style: TextStyle(color: Color(0xFFD1D5DB), fontSize: 11)),
                      ),
                      Text(
                        task.clientProject,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                      const Spacer(),
                      // Priority Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: config.bgColor,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: config.borderColor, width: 0.8),
                        ),
                        child: Text(
                          task.priority,
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            color: config.textColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Task Title
                  Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111827),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Assignee Avatar & Info Row + Status Badge dropdown
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: const Color(0xFF4B5563),
                        child: Text(
                          task.assignInitials,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Assign By: ',
                                style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF), fontWeight: FontWeight.w500),
                                children: [
                                  TextSpan(
                                    text: task.assignBy,
                                    style: const TextStyle(color: Color(0xFF1F2937), fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 1),
                            RichText(
                              text: TextSpan(
                                text: 'Due Date: ',
                                style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF), fontWeight: FontWeight.w500),
                                children: [
                                  TextSpan(
                                    text: task.dueDate,
                                    style: const TextStyle(color: Color(0xFF374151), fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Status Badge Dropdown
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(
                          color: _getStatusBgColor(task.status),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: _getStatusTextColor(task.status).withValues(alpha: 0.3), width: 0.8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              task.status,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: _getStatusTextColor(task.status),
                              ),
                            ),
                            const SizedBox(width: 3),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 12,
                              color: _getStatusTextColor(task.status),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Sub Tasks Progress row
                  Row(
                    children: [
                      Text(
                        'Sub Tasks: ${task.subTasksCount}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 5,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE5E7EB),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: task.progress,
                              child: Container(
                                height: 5,
                                decoration: BoxDecoration(
                                  color: task.progress == 1.0
                                      ? const Color(0xFF16A34A)
                                      : const Color(0xFFDFAF00),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${(task.progress * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(width: 14),
                      // Comment and attachment counters
                      const Icon(Icons.chat_bubble_outline, size: 12, color: Color(0xFF9CA3AF)),
                      const SizedBox(width: 2),
                      Text('${task.commentsCount}', style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280))),
                      const SizedBox(width: 8),
                      const Icon(Icons.attach_file, size: 12, color: Color(0xFF9CA3AF)),
                      const SizedBox(width: 1),
                      Text('${task.attachmentsCount}', style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280))),
                    ],
                  ),

                  // Collapsible Extra Contents Section
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    firstChild: const SizedBox(width: double.infinity),
                    secondChild: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Divider(color: Color(0xFFF3F4F6), height: 1),
                        ),

                        // Extra meta info row
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFFE8E9EA), width: 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildMetaInfoItem(Icons.calendar_month_outlined, 'Assigned On', task.assignedOn),
                              const SizedBox(width: 8),
                              _buildMetaInfoItem(Icons.access_time, 'Estimated Time', task.estimatedTime, valueColor: const Color(0xFF335F88)),
                              const SizedBox(width: 8),
                              _buildMetaInfoItem(Icons.access_time, 'Duration Covered', task.durationCover, valueColor: const Color(0xFF16A34A)),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Description block
                        Text(
                          task.description,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF4B5563),
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Actions Button Row
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.play_arrow, size: 16, color: Colors.white),
                                label: const Text('Start', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF901AEA),
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.add, size: 16, color: Color(0xFF03C95A)),
                                label: const Text('Sub Task', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF03C95A))),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Color(0xFF03C95A), width: 0.8),
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TaskDetailsScreen(task: task),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.visibility_outlined, size: 16, color: Color(0xFF1B2CF1)),
                                label: const Text('View', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF1B2CF1))),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Color(0xFF1B2CF1), width: 0.8),
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaInfoItem(IconData icon, String title, String value, {Color? valueColor}) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 15, color: const Color(0xFF6B7280)),
          const SizedBox(width: 3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 8,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 7,
                      fontWeight: FontWeight.w600,
                      color: valueColor ?? const Color(0xFF335F88),
                      fontFamily: 'Inter',
                    ),
                    children: [
                      if (value.contains('|')) ...[
                        TextSpan(text: value.split('|')[0]),
                        TextSpan(
                          text: ' | ',
                          style: TextStyle(
                            color: const Color(0xFF335F88).withValues(alpha: 0.5),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(text: value.split('|')[1].trim()),
                      ] else
                        TextSpan(text: value),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PriorityConfig {
  final Color textColor;
  final Color bgColor;
  final Color borderColor;
  final Color leftBarColor;

  PriorityConfig({
    required this.textColor,
    required this.bgColor,
    required this.borderColor,
    required this.leftBarColor,
  });
}
