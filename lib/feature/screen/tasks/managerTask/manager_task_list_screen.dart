import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_colors.dart';
import 'package:hrms_app/feature/model/tasks/task_model.dart';
import 'package:hrms_app/feature/screen/tasks/create_task_screen.dart';
import 'package:hrms_app/feature/screen/tasks/task_details_screen.dart';
import '../../../../core/constants/app_images_png.dart';

class ManagerTaskListScreen extends StatefulWidget {
  const ManagerTaskListScreen({super.key});

  @override
  State<ManagerTaskListScreen> createState() => _ManagerTaskListScreenState();
}

class _ManagerTaskListScreenState extends State<ManagerTaskListScreen> {
  int _selectedMainTab = 1; // 0: My Task, 1: Team Task
  int _activeStatusTab = 0; // 0: All Jobs, 1: To Do, 2: In Progress, 3: Complete
  int _expandedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<TaskModel> _allTasks = [
    TaskModel(
      id: 'TSK-101',
      clientProject: 'Bill Track',
      title: 'UI/UX Wireframe Redesign',
      assignBy: 'Sabyasachi Gupta',
      assignInitials: 'SP',
      dueDate: '25 Sep, 2026',
      status: 'In Progress',
      priority: 'Urgent',
      subTasksCount: '3/5',
      progress: 0.60,
      commentsCount: 3,
      attachmentsCount: 2,
      assignedOn: '15 Sep 2026 | 10:28 AM',
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
      dueDate: '27 Sep, 2026',
      status: 'In Review',
      priority: 'High',
      subTasksCount: '0/2',
      progress: 0.0,
      commentsCount: 0,
      attachmentsCount: 0,
      assignedOn: '16 Sep 2026 | 11:00 AM',
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
      dueDate: '24 Sep, 2026',
      status: 'Completed',
      priority: 'Normal',
      subTasksCount: '1/1',
      progress: 1.0,
      commentsCount: 1,
      attachmentsCount: 0,
      assignedOn: '12 Sep 2026 | 09:30 AM',
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
      dueDate: '31 Sep, 2026',
      status: 'TO DO',
      priority: 'Low',
      subTasksCount: '0/1',
      progress: 0.0,
      commentsCount: 0,
      attachmentsCount: 0,
      assignedOn: '18 Sep 2026 | 04:15 PM',
      estimatedTime: '30h 00m',
      durationCover: '0h 0m',
      description: 'Integrate Razorpay SDK for standard credit card, UPI, and net banking transactions including webhook validation.',
    ),
  ];

  List<TaskModel> get _filteredTasks {
    List<TaskModel> tasks = _allTasks;

    // Filter by status tab
    if (_activeStatusTab == 1) {
      tasks = tasks.where((t) => t.status == 'TO DO').toList();
    } else if (_activeStatusTab == 2) {
      tasks = tasks.where((t) => t.status == 'In Progress' || t.status == 'In Review').toList();
    } else if (_activeStatusTab == 3) {
      tasks = tasks.where((t) => t.status == 'Completed').toList();
    }

    // Filter by search query
    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      tasks = tasks.where((t) =>
          t.title.toLowerCase().contains(query) ||
          t.id.toLowerCase().contains(query) ||
          t.clientProject.toLowerCase().contains(query)).toList();
    }

    return tasks;
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
        title: const Text(
          'Task Lists',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateTaskScreen()),
                );
              },
              icon: const Icon(Icons.add, size: 18, color: Colors.white),
              label: const Text('Task', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF901AEA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                minimumSize: const Size(0, 28),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ],
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
              const SizedBox(height: 8),

              // Main Tabs (My Task | Team Task)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildMainTabItem('My Task (0)', 0),
                      ),
                      Expanded(
                        child: _buildMainTabItem('Team Task (120)', 1),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Status Tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      _buildStatusTabItem('All Jobs (120)', 0),
                      const SizedBox(width: 8),
                      _buildStatusTabItem('To Do (92)', 1),
                      const SizedBox(width: 8),
                      _buildStatusTabItem('In Progress (18)', 2),
                      const SizedBox(width: 8),
                      _buildStatusTabItem('Complete (10)', 3),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Search tasks by title, project or clients...',
                      hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                      prefixIcon: const Icon(Icons.search, color: Color(0xFF9CA3AF), size: 20),
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Tasks List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: _filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = _filteredTasks[index];
                    final isExpanded = _expandedIndex == index;
                    return ManagerTaskItemWidget(
                      task: task,
                      isExpanded: isExpanded,
                      onTap: () {
                        setState(() {
                          _expandedIndex = isExpanded ? -1 : index;
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildMainTabItem(String label, int index) {
    final isSelected = _selectedMainTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedMainTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF901AEA) : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : const Color(0xFF901AEA),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusTabItem(String label, int index) {
    final isSelected = _activeStatusTab == index;
    return GestureDetector(
      onTap: () => setState(() => _activeStatusTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF901AEA) : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : const Color(0xFF901AEA),
          ),
        ),
      ),
    );
  }
}

class ManagerTaskItemWidget extends StatelessWidget {
  final TaskModel task;
  final bool isExpanded;
  final VoidCallback onTap;

  const ManagerTaskItemWidget({
    super.key,
    required this.task,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getPriorityConfig(task.priority);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 10,
              bottom: 10,
              width: 2,
              child: Container(color: config.leftBarColor),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        task.id,
                        style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                      const Text(' | ', style: TextStyle(color: Colors.grey, fontSize: 10)),
                      Text(
                        task.clientProject,
                        style: const TextStyle(fontSize: 10, color: Color(0xFF2563EB), fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      _buildPriorityBadge(task.priority, config),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    task.title,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.grey.shade200,
                        child: Text(task.assignInitials, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(fontSize: 11, color: Colors.grey),
                                children: [
                                  const TextSpan(text: 'Assign By: '),
                                  TextSpan(text: task.assignBy, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(fontSize: 11, color: Colors.grey),
                                children: [
                                  const TextSpan(text: 'Due Date: '),
                                  TextSpan(text: task.dueDate, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildStatusBadge(task.status),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        'Sub Tasks: ${task.subTasksCount}',
                        style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: task.progress,
                            backgroundColor: Colors.grey.shade100,
                            color: task.progress == 1.0 ? const Color(0xFF06D6A0) : const Color(0xFFD4A017),
                            minHeight: 4,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${(task.progress * 100).toInt()}%',
                        style: const TextStyle(fontSize: 10, color: Color(0xFFD4A017), fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.chat_bubble_outline, size: 12, color: Colors.grey),
                      const SizedBox(width: 2),
                      Text('${task.commentsCount}', style: const TextStyle(fontSize: 10, color: Colors.grey)),
                      const SizedBox(width: 8),
                      const Icon(Icons.attach_file, size: 12, color: Colors.grey),
                      const SizedBox(width: 2),
                      Text('${task.attachmentsCount}', style: const TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                  
                  // Expandable Content
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    firstChild: const SizedBox(height: 0),
                    secondChild: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(height: 1, color: Color(0xFFF3F4F6)),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildDetailItem(Icons.calendar_today, 'Assigned On', task.assignedOn),
                              _buildDetailItem(Icons.timer_outlined, 'Estimated Time', task.estimatedTime, valueColor: const Color(0xFF2563EB)),
                              _buildDetailItem(Icons.timer_outlined, 'Duration Covered', task.durationCover, valueColor: const Color(0xFF06D6A0)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          task.description,
                          style: const TextStyle(fontSize: 11, color: Colors.grey, height: 1.5),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            if (task.status != 'Completed')
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.play_arrow, color: Colors.white, size: 16),
                                  label: const Text('Start', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF901AEA),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.add, color: Color(0xFF06D6A0), size: 16),
                                label: const Text('Sub Task', style: TextStyle(color: Color(0xFF06D6A0), fontWeight: FontWeight.bold)),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Color(0xFF06D6A0)),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => TaskDetailsScreen(task: task)),
                                  );
                                },
                                icon: const Icon(Icons.visibility, color: Color(0xFF2563EB), size: 16),
                                label: const Text('View', style: TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold)),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Color(0xFF2563EB)),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
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

  Widget _buildPriorityBadge(String priority, PriorityConfig config) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: config.bgColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: config.borderColor),
      ),
      child: Text(
        priority,
        style: TextStyle(fontSize: 8, color: config.textColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor = const Color(0xFFF3F4F6);
    Color textColor = const Color(0xFF374151);
    if (status == 'In Progress') {
      bgColor = const Color(0xFFEFF6FF);
      textColor = const Color(0xFF2563EB);
    } else if (status == 'In Review') {
      bgColor = const Color(0xFFF3E8FF);
      textColor = const Color(0xFF9333EA);
    } else if (status == 'Completed') {
      bgColor = const Color(0xFFDCFCE7);
      textColor = const Color(0xFF16A34A);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: textColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(status, style: TextStyle(fontSize: 10, color: textColor, fontWeight: FontWeight.w600)),
          const SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down, size: 12, color: textColor),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value, {Color? valueColor}) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 7, color: Colors.grey), overflow: TextOverflow.ellipsis),
                Text(value, style: TextStyle(fontSize: 7, color: valueColor ?? Colors.black, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
          textColor: const Color(0xFFD4A017),
          bgColor: const Color(0xFFFFFBEB),
          borderColor: const Color(0xFFFEF3C7),
          leftBarColor: const Color(0xFFD4A017),
        );
      case 'normal':
        return PriorityConfig(
          textColor: const Color(0xFFD4A017),
          bgColor: const Color(0xFFFEFCE8),
          borderColor: const Color(0xFFFEF08A),
          leftBarColor: const Color(0xFFD4A017),
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
}
