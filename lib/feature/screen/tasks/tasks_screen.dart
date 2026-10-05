import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_colors.dart';

import '../../../core/constants/app_images_png.dart';
import 'create_task_screen.dart';
import 'task_details_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  int _activeTab = 0; // 0: All Jobs, 1: To Do, 2: In Progress, 3: Complete
  int _expandedIndex = 0; // TSK-101 expanded by default as in screenshot
  final TextEditingController _searchController = TextEditingController();

  // Mock task data matching the screenshot exactly
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
    if (_activeTab == 1) {
      tasks = tasks.where((t) => t.status == 'TO DO').toList();
    } else if (_activeTab == 2) {
      tasks = tasks.where((t) => t.status == 'In Progress' || t.status == 'In Review').toList();
    } else if (_activeTab == 3) {
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

  int _getTabCount(int tabIndex) {
    if (tabIndex == 0) return _allTasks.length;
    if (tabIndex == 1) return _allTasks.where((t) => t.status == 'TO DO').length;
    if (tabIndex == 2) return _allTasks.where((t) => t.status == 'In Progress' || t.status == 'In Review').length;
    if (tabIndex == 3) return _allTasks.where((t) => t.status == 'Completed').length;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF311040), // Dark Purple stop from user screenshot
              const Color(0xFF311040).withValues(alpha: 0.6), // Dark Purple stop from user screenshot,
            ],
            stops: const [0.0, 0.45],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // Custom Header App Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.maybePop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'My Tasks Lists',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      AppImagesPng.filterIcon,
                      width: 24,
                      height: 24,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),

              // Main White Body Container with rounded top corners
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),

                    ),

                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // Tabs Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: [
                              _buildTabItem('All Jobs', 0),
                              const SizedBox(width: 8),
                              _buildTabItem('To Do', 1),
                              const SizedBox(width: 8),
                              _buildTabItem('In Progress', 2),
                              const SizedBox(width: 8),
                              _buildTabItem('Complete', 3),
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
                            controller: _searchController,
                            onChanged: (value) => setState(() {}),
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: const InputDecoration(
                              hintText: 'Search tasks by title, project or client...',
                              hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 2.0,top: 5),
                                child: Icon(Icons.search, color: Color(0xFF9CA3AF), size: 18),
                              ),
                              prefixIconConstraints: const BoxConstraints(),
                              isDense: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 2),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Tasks List View
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
                          itemCount: _filteredTasks.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final task = _filteredTasks[index];
                            final isExpanded = _expandedIndex == index;

                            return TaskItemWidget(
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
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 37,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateTaskScreen()),
            );
          },
          backgroundColor: const Color(0xFF901AEA),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          icon: const Icon(Icons.add, color: Colors.white, size: 18),
          label: const Text(
            'Create Task',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildTabItem(String label, int index) {
    final isSelected = _activeTab == index;
    final count = _getTabCount(index);
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeTab = index;
          _expandedIndex = 0; // reset expansion to first item of new tab
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

// Reusable Task Item Component
class TaskItemWidget extends StatelessWidget {
  final TaskModel task;
  final bool isExpanded;
  final VoidCallback onTap;

  const TaskItemWidget({
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
                                  label: const Text('Start Work', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF901AEA),
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
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
                                  label: const Text('View Details', style: TextStyle(fontWeight:  FontWeight.w600, fontSize: 14, color: Color(0xFF1B2CF1))),
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

// Priority Config Helper Class
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

// Task Model Helper Data structure
class TaskModel {
  final String id;
  final String clientProject;
  final String title;
  final String assignBy;
  final String assignInitials;
  final String dueDate;
  final String status;
  final String priority;
  final String subTasksCount;
  final double progress;
  final int commentsCount;
  final int attachmentsCount;
  final String assignedOn;
  final String estimatedTime;
  final String durationCover;
  final String description;

  TaskModel({
    required this.id,
    required this.clientProject,
    required this.title,
    required this.assignBy,
    required this.assignInitials,
    required this.dueDate,
    required this.status,
    required this.priority,
    required this.subTasksCount,
    required this.progress,
    required this.commentsCount,
    required this.attachmentsCount,
    required this.assignedOn,
    required this.estimatedTime,
    required this.durationCover,
    required this.description,
  });
}
