import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import 'package:hrms_app/feature/screen/tasks/widgets/manager_task_dashboard_widgets.dart';

import 'manager_project_list_screen.dart';

class ManagerProjectDetailsScreen extends StatelessWidget {
  final String title;
  final String description;
  final String logo;
  final String category;
  final String tasks;
  final List<String> teamImages;
  final String estimatedTime;
  final String dueDate;

  const ManagerProjectDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.logo,
    required this.category,
    required this.tasks,
    required this.teamImages,
    required this.estimatedTime,
    required this.dueDate,
  });

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
          'Project Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
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
            colors: [Color(0xFF311040), Color(0x00FFFFFF)],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProjectHeaderCard(),
                const SizedBox(height: 20),
                _buildTaskSummarySection(),
                const SizedBox(height: 20),
                TaskChartCard(
                  totalTasks: '120',
                  data: const [
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
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectHeaderCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
                child: Image.asset(logo),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          tasks,
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFA020F0).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            category,
                            style: const TextStyle(
                              color: Color(0xFFA020F0),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
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
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(color: Color(0XFF6B7280), fontSize: 14, fontWeight: FontWeight.w400, height: 1.5),
          ),
          const SizedBox(height: 16),
          const DottedDivider(),
          const SizedBox(height: 16),
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=100'),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Assigned By', style: TextStyle(color: Colors.grey, fontSize: 10)),
                  Text(
                    'Sabyasachi Gupta',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: 100,
                height: 30,
                child: Stack(
                  children: [
                    for (int i = 0; i < (teamImages.length > 4 ? 4 : teamImages.length); i++)
                      Positioned(
                        left: i * 18.0,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(teamImages[i]),
                          ),
                        ),
                      ),
                    if (teamImages.length > 4)
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
                              '+${teamImages.length - 4}',
                              style: const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const DottedDivider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoColumn(Icons.calendar_today_outlined, 'Assigned On', '15 Sep 2026', const Color(0xFF6B7280)),
              _buildInfoColumn(Icons.access_time, 'Estimated Time', estimatedTime, const Color(0xFF4361EE)),
              _buildInfoColumn(Icons.calendar_month, 'Due Date', dueDate, const Color(0xFFD4A017)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(IconData icon, String label, String value, Color valueColor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: Colors.grey.shade600),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 8)),
            Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTaskSummarySection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Task Summary',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFFA020F0),
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.8,
            children: [
              ManagerProjectTaskCard(
                color: const Color(0xFF4361EE),
                imagePath: AppImagesPng.inProgressTask,
                title: 'In Progress Tasks',
                value: '18',
              ),
              ManagerProjectTaskCard(
                color: const Color(0xFF06D6A0),
                imagePath: AppImagesPng.completeTask,
                title: 'Completed Tasks',
                value: '7',
              ),
              ManagerProjectTaskCard(
                color: const Color(0xFFEF233C),
                imagePath: AppImagesPng.overdueTask,
                title: 'Overdue Tasks',
                value: '3',
              ),
              ManagerProjectTaskCard(
                color: const Color(0xFF8D99AE),
                imagePath: AppImagesPng.todoProject,
                title: 'To Do Tasks',
                value: '92',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
