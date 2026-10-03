import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';

class ManagerProjectListScreen extends StatelessWidget {
  const ManagerProjectListScreen({super.key});

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
        titleSpacing: 0,

        title: const Text(
          'Project Lists',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 18),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 18, color: Colors.white),
              label: const Text('Project', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF901AEA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
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
            colors: [
              Color(0xFF311040),
              Color(0x00FFFFFF),
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const ProjectFilterTabs(),
              const ProjectSearchBar(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    ProjectListItem(
                      logo: AppImagesPng.splashLogo, // Using a placeholder for now
                      title: 'HRMS software crm',
                      tasks: '28 / 120 Tasks',
                      category: 'HRMS',
                      progress: 0.23,
                      description:
                          'Create high-fidelity UI for employee dashboard as per latest discussion. Follow the approved design system and...',
                      estimatedTime: '50d 14h',
                      dueDate: '25 Nov 2026',
                      teamImages: const [
                        'https://i.pravatar.cc/150?u=1',
                        'https://i.pravatar.cc/150?u=2',
                        'https://i.pravatar.cc/150?u=3',
                        'https://i.pravatar.cc/150?u=4',
                      ],
                    ),
                    const SizedBox(height: 16),
                    ProjectListItem(
                      logo: AppImagesPng.splashLogo, // Placeholder
                      title: 'Quick billing application',
                      tasks: '48 / 54 Tasks',
                      category: 'Billtrack',
                      progress: 0.88,
                      description:
                          'Create high-fidelity UI for employee dashboard as per latest discussion. Follow the approved design system and...',
                      estimatedTime: '28h 30m',
                      dueDate: '30 Sep 2026',
                      teamImages: const [
                        'https://i.pravatar.cc/150?u=5',
                        'https://i.pravatar.cc/150?u=6',
                        'https://i.pravatar.cc/150?u=7',
                        'https://i.pravatar.cc/150?u=8',
                      ],
                    ),
                    const SizedBox(height: 16),
                    ProjectListItem(
                      logo: AppImagesPng.splashLogo,
                      title: 'Website design EV sector',
                      tasks: '2 / 12 Tasks',
                      category: 'HRMS',
                      progress: 0.16,
                      description:
                          'Create high-fidelity UI for employee dashboard as per latest discussion. Follow the approved design system and...',
                      estimatedTime: '48h 30m',
                      dueDate: '25 Nov 2026',
                      teamImages: const [
                        'https://i.pravatar.cc/150?u=9',
                        'https://i.pravatar.cc/150?u=10',
                      ],
                    ),
                    const SizedBox(height: 16),
                    ProjectListItem(
                      logo: AppImagesPng.splashLogo, // Placeholder
                      title: 'Website new page create',
                      tasks: '2 / 2 Tasks',
                      category: 'Turain',
                      progress: 1.0,
                      description:
                          'Create high-fidelity UI for employee dashboard as per latest discussion. Follow the approved design system and...',
                      estimatedTime: '13h 30m',
                      dueDate: '24 Sep 2026',
                      teamImages: const [
                        'https://i.pravatar.cc/150?u=11',
                        'https://i.pravatar.cc/150?u=12',
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
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
  const ProjectFilterTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      color: Colors.transparent,
      child: Row(
        children: [
          _buildTab('All Projects (8)', true),
          const SizedBox(width: 8),
          _buildTab('Active (5)', false),
          const SizedBox(width: 8),
          _buildTab('Completed (3)', false),
        ],
      ),
    );
  }

  Widget _buildTab(String label, bool isActive) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFA020F0) : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFFA020F0),
            fontWeight: FontWeight.bold,
            fontSize: 12,
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
      color: Colors.transparent,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search Projects...',
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class ProjectListItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
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
                width: 48,
                height: 48,
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
              CircularPercentIndicator(
                percent: progress,
                progressColor: const Color(0xFF00C853),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(color: Colors.grey, fontSize: 12, height: 1.4),
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
                height: 24,
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
                        estimatedTime,
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
                        dueDate,
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
                decoration: BoxDecoration(color: Colors.grey.shade300),
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
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00C853),
            ),
          ),
        ],
      ),
    );
  }
}
