import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';

class ManagerProjectTaskGrid extends StatelessWidget {
  const ManagerProjectTaskGrid({super.key});

  @override
  Widget build(BuildContext context) {
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
            'Project / Task Dashboard',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFFA020F0),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_month_outlined, size: 18, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                const Text(
                  "14 Aug 2026 - 30 Sep 2026",
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
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
            children: const [
              ManagerProjectTaskCard(
                color: Color(0xFF901AEA),
                imagePath: AppImagesPng.totalProject,
                title: 'Total Projects',
                value: '8',
              ),
              ManagerProjectTaskCard(
                color: Color(0xFF00B4D8),
                imagePath: AppImagesPng.teamMember,
                title: 'Team Members',
                value: '18',
              ),
              ManagerProjectTaskCard(
                color: Color(0xFF1B1B2F),
                imagePath: AppImagesPng.totalAssign,
                title: 'Total Assign Tasks',
                value: '362',
              ),
              ManagerProjectTaskCard(
                color: Color(0xFF4361EE),
                imagePath: AppImagesPng.inProgressTask,
                title: 'In Progress Tasks',
                value: '124',
              ),
              ManagerProjectTaskCard(
                color: Color(0xFF06D6A0),
                imagePath: AppImagesPng.completeTask,
                title: 'Completed Tasks',
                value: '118',
              ),
              ManagerProjectTaskCard(
                color: Color(0xFFEF233C),
                imagePath: AppImagesPng.overdueTask,
                title: 'Overdue Tasks',
                value: '95',
              ),
              ManagerProjectTaskCard(
                color: Color(0xFF8D99AE),
                imagePath: AppImagesPng.todoProject,
                title: 'To Do Tasks',
                value: '25',
              ),
              ManagerProjectTaskCard(
                color: Color(0xFFD4A017),
                imagePath: AppImagesPng.taskCompletion,
                title: 'Task Completion',
                value: '67%',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ManagerTaskIconContainer extends StatelessWidget {
  final String imagePath;
  final Color color;
  final double rightRadius;

  const ManagerTaskIconContainer({
    super.key,
    required this.imagePath,
    required this.color,
    this.rightRadius = 40.15,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(0),
          bottomLeft: const Radius.circular(0),
          topRight: Radius.circular(rightRadius),
          bottomRight: Radius.circular(rightRadius),
        ),
      ),
      child: Center(
        child: Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Image.asset(
              imagePath,
              color: color,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class ManagerProjectTaskCard extends StatelessWidget {
  final Color color;
  final String imagePath;
  final String title;
  final String value;

  const ManagerProjectTaskCard({
    super.key,
    required this.color,
    required this.imagePath,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.4), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ManagerTaskIconContainer(
            imagePath: imagePath,
            color: color,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 9,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 18,
                      color: color,
                      fontWeight: FontWeight.bold,
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
}

class TaskChartCard extends StatelessWidget {
  const TaskChartCard({super.key});

  @override
  Widget build(BuildContext context) {
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
            'Task Dashboard',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFFA020F0),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              // Donut Chart
              SizedBox(
                height: 140,
                width: 140,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(140, 140),
                      painter: DonutChartPainter(),
                    ),
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '368',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Tasks',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              // Legend
              const Expanded(
                child: Column(
                  children: [
                    LegendItem(color: Color(0xFF4361EE), label: 'In Progress', value: '124', percentage: '34.25%'),
                    SizedBox(height: 12),
                    LegendItem(color: Color(0xFF06D6A0), label: 'Completed', value: '118', percentage: '32.59%'),
                    SizedBox(height: 12),
                    LegendItem(color: Color(0xFFEF233C), label: 'Overdue', value: '95', percentage: '26.24%'),
                    SizedBox(height: 12),
                    LegendItem(color: Color(0xFF8D99AE), label: 'To Do', value: '25', percentage: '6.90%'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    double startAngle = -pi / 2;

    // In Progress - Blue
    paint.color = const Color(0xFF4361EE);
    double sweepAngle = (34.25 / 100) * 2 * pi;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 10), startAngle, sweepAngle, false, paint);
    startAngle += sweepAngle;

    // Completed - Green
    paint.color = const Color(0xFF06D6A0);
    sweepAngle = (32.59 / 100) * 2 * pi;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 10), startAngle, sweepAngle, false, paint);
    startAngle += sweepAngle;

    // Overdue - Red
    paint.color = const Color(0xFFEF233C);
    sweepAngle = (26.24 / 100) * 2 * pi;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 10), startAngle, sweepAngle, false, paint);
    startAngle += sweepAngle;

    // To Do - Grey
    paint.color = const Color(0xFF8D99AE);
    sweepAngle = (6.90 / 100) * 2 * pi;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 10), startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String value;
  final String percentage;

  const LegendItem({
    super.key,
    required this.color,
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500),
        ),
        const Spacer(),

        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
            children: [
              TextSpan(text: value),
              TextSpan(
                text: ' ($percentage)',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RecentActivitiesSection extends StatelessWidget {
  const RecentActivitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
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
            'Recent Activities',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFFA020F0),
            ),
          ),
          const SizedBox(height: 16),
          _buildActivityItem(
            'Homepage UI',
            'TSK-101',
            'Billtrack',
            'In Progress',
            const Color(0xFF4361EE),
            'Today | 15:23',
            'https://i.pravatar.cc/150?u=11',
          ),
          const SizedBox(height: 16),
          _buildActivityItem(
            'API Integration',
            'TSK-125',
            'HRMS',
            'Completed',
            const Color(0xFF06D6A0),
            'Today | 15:10',
            'https://i.pravatar.cc/150?u=12',
          ),
          const SizedBox(height: 16),
          _buildActivityItem(
            'Home page modification',
            'TSK-115',
            'HRMS',
            'Completed',
            const Color(0xFF06D6A0),
            'Today | 15:10',
            'https://i.pravatar.cc/150?u=13',
          ),
          const SizedBox(height: 16),
          _buildActivityItem(
            'SEO Content',
            'TSK-225',
            'Billtrack',
            'Overdue',
            const Color(0xFFEF233C),
            '25 Sep | 12:10',
            'https://i.pravatar.cc/150?u=14',
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    String title,
    String tskId,
    String project,
    String status,
    Color statusColor,
    String time,
    String imageUrl,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundImage: NetworkImage(imageUrl),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    time,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                  children: [
                    TextSpan(text: tskId),
                    const TextSpan(text: '  |  '),
                    TextSpan(
                      text: project,
                      style: const TextStyle(color: Color(0xFF00B4D8), fontWeight: FontWeight.w600),
                    ),
                    const TextSpan(text: '  |  '),
                    TextSpan(
                      text: status,
                      style: TextStyle(color: statusColor, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
