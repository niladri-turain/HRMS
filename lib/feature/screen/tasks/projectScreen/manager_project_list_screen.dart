import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import 'package:hrms_app/feature/screen/tasks/projectScreen/manager_project_details_screen.dart';

import 'manager_project_create_screen.dart';
import '../manager_project_task_create_screen.dart';

class ManagerProjectListScreen extends StatefulWidget {
  const ManagerProjectListScreen({super.key});

  @override
  State<ManagerProjectListScreen> createState() => _ManagerProjectListScreenState();
}

class _ManagerProjectListScreenState extends State<ManagerProjectListScreen> {
  int _selectedTabIndex = 0; // 0: All, 1: Active, 2: Completed

  final List<Map<String, dynamic>> allProjects = [
    {
      'logo': AppImagesPng.splashLogo,
      'title': 'HRMS software crm',
      'tasks': '28 / 120 Tasks',
      'category': 'HRMS',
      'progress': 0.23,
      'description': 'Create high-fidelity UI for employee dashboard as per latest discussion. Follow the approved design system and...',
      'estimatedTime': '50d 14h',
      'dueDate': '25 Nov 2026',
      'teamImages': ['https://i.pravatar.cc/150?u=1', 'https://i.pravatar.cc/150?u=2', 'https://i.pravatar.cc/150?u=3', 'https://i.pravatar.cc/150?u=4'],
      'status': 'active',
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
      'teamImages': ['https://i.pravatar.cc/150?u=5', 'https://i.pravatar.cc/150?u=6', 'https://i.pravatar.cc/150?u=7', 'https://i.pravatar.cc/150?u=8'],
      'status': 'active',
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
      'teamImages': ['https://i.pravatar.cc/150?u=9', 'https://i.pravatar.cc/150?u=10'],
      'status': 'active',
    },
    {
      'logo': AppImagesPng.splashLogo,
      'title': 'Website new page create',
      'tasks': '2 / 2 Tasks',
      'category': 'Turain',
      'progress': 1.0,
      'description': 'Create high-fidelity UI for employee dashboard as per latest discussion. Follow the approved design system and...',
      'estimatedTime': '13h 30m',
      'dueDate': '24 Sep 2026',
      'teamImages': ['https://i.pravatar.cc/150?u=11', 'https://i.pravatar.cc/150?u=12'],
      'status': 'completed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> displayedProjects;
    if (_selectedTabIndex == 1) {
      // Show only 2 active projects as requested
      displayedProjects = allProjects.where((p) => p['status'] == 'active').take(2).toList();
    } else if (_selectedTabIndex == 2) {
      // Show only 1 completed project (which is 100%)
      displayedProjects = allProjects.where((p) => p['status'] == 'completed').take(1).toList();
    } else {
      displayedProjects = allProjects;
    }

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
          'Project Lists',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManagerProjectCreateScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add, size: 18, color: Colors.white),
              label: const Text('Project', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
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
              ProjectFilterTabs(
                selectedIndex: _selectedTabIndex,
                onTabChanged: (index) {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
              ),
              const ProjectSearchBar(),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: displayedProjects.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final project = displayedProjects[index];
                    return ProjectListItem(
                      logo: project['logo'],
                      title: project['title'],
                      tasks: project['tasks'],
                      category: project['category'],
                      progress: project['progress'],
                      description: project['description'],
                      estimatedTime: project['estimatedTime'],
                      dueDate: project['dueDate'],
                      teamImages: project['teamImages'],
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
}

class ProjectFilterTabs extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;

  const ProjectFilterTabs({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.transparent,
      child: Row(
        children: [
          _buildTab('All Projects (8)', 0),
          const SizedBox(width: 8),
          _buildTab('Active (5)', 1),
          const SizedBox(width: 8),
          _buildTab('Completed (3)', 2),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final bool isActive = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabChanged(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF901AEA) : Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : const Color(0xFF901AEA),
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}


class ProjectSearchBar extends StatelessWidget {
  const ProjectSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.transparent,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: TextField(
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          hintText: 'Search Projects...',
          hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF9CA3AF), size: 20),
          prefixIconConstraints: const BoxConstraints(minWidth: 40),
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
    );
  }
}

class ProjectListItem extends StatefulWidget {
  final String logo;
  final String title;
  final String tasks;
  final String category;
  final double progress;
  final String description;
  final String estimatedTime;
  final String dueDate;
  final List<String> teamImages;

  const ProjectListItem({
    super.key,
    required this.logo,
    required this.title,
    required this.tasks,
    required this.category,
    required this.progress,
    required this.description,
    required this.estimatedTime,
    required this.dueDate,
    required this.teamImages,
  });

  @override
  State<ProjectListItem> createState() => _ProjectListItemState();
}

class _ProjectListItemState extends State<ProjectListItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
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
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Image.asset(widget.logo),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
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
                            widget.tasks,
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
                              widget.category,
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
                  percent: widget.progress,
                  progressColor: const Color(0xFF00C853),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              style: const TextStyle(color: Color(0XFF6B7280), fontSize: 12, fontWeight: FontWeight.w500),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            const DottedDivider(),
            const SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 30,
                  child: Stack(
                    children: [
                      for (int i = 0; i < (widget.teamImages.length > 4 ? 4 : widget.teamImages.length); i++)
                        Positioned(
                          left: i * 18.0,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage(widget.teamImages[i]),
                            ),
                          ),
                        ),
                      if (widget.teamImages.length > 4)
                        Positioned(
                          left: 4 * 18.0,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.grey.shade200,
                              child: Text(
                                '+${widget.teamImages.length - 4}',
                                style: const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 18, color: Colors.grey.shade600),
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Estimated Time', style: TextStyle(color: Colors.grey, fontSize: 8)),
                        Text(
                          widget.estimatedTime,
                          style: const TextStyle(
                            color: Color(0xFF4361EE),
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 18, color: Colors.grey.shade600),
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Due Date', style: TextStyle(color: Colors.grey, fontSize: 8)),
                        Text(
                          widget.dueDate,
                          style: const TextStyle(
                            color: Color(0xFFD4A017),
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox(width: double.infinity),
              secondChild: Column(
                children: [
                  const SizedBox(height: 16),
                  const DottedDivider(),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ManagerProjectTaskCreateScreen(projectName: widget.title),
                              ),
                            );
                          },
                          child: _buildActionButton(Icons.add, 'Task', const Color(0xFF901AEA)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: _buildActionButton(Icons.group_outlined, 'Teams', const Color(0xFF00B5AD))),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ManagerProjectDetailsScreen(
                                  title: widget.title,
                                  description: widget.description,
                                  logo: widget.logo,
                                  category: widget.category,
                                  tasks: widget.tasks,
                                  teamImages: widget.teamImages,
                                  estimatedTime: widget.estimatedTime,
                                  dueDate: widget.dueDate,
                                ),
                              ),
                            );
                          },
                          child: _buildActionButton(Icons.visibility_outlined, 'View', const Color(0xFF4361EE)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        border: Border.all(color: color.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}


class DottedDivider extends StatelessWidget {
  const DottedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        const dashSpace = 4.0;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.12)),
              ),
            );
          }),
        );
      },
    );
  }
}

class CircularPercentIndicator extends StatelessWidget {
  final double percent;
  final Color progressColor;

  const CircularPercentIndicator({
    super.key,
    required this.percent,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: percent,
            strokeWidth: 4,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          ),
          Text(
            '${(percent * 100).toInt()}%',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Color(0xFF00C853),
            ),
          ),
        ],
      ),
    );
  }
}
