import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';

class TeamListScreen extends StatefulWidget {
  const TeamListScreen({super.key});

  @override
  State<TeamListScreen> createState() => _TeamListScreenState();
}

class _TeamListScreenState extends State<TeamListScreen> {
  int _selectedTabIndex = 0;

  final List<Map<String, dynamic>> teamMembers = [
    {
      'name': 'Niladri Roy',
      'role': 'Flutter Developer',
      'image': AppImagesPng.one,
      'progress': 0.35,
      'status': 'online',
      'tasks': {'blue': 4, 'green': 5, 'red': 2, 'grey': 4}
    },
    {
      'name': 'Mousin Ali',
      'role': 'Frontend Designer',
      'image': AppImagesPng.two,
      'progress': 0.23,
      'status': 'online',
      'tasks': {'blue': 8, 'green': 5, 'red': 2, 'grey': 4}
    },
    {
      'name': 'Moulina Kundu',
      'role': 'UI/UX Designer',
      'image': AppImagesPng.three,
      'progress': 0.80,
      'status': 'online',
      'tasks': {'blue': 1, 'green': 5, 'red': 0, 'grey': 1}
    },
    {
      'name': 'Bikash Prasad',
      'role': 'Software Developer',
      'image': AppImagesPng.four,
      'progress': 0.40,
      'status': 'offline',
      'tasks': {'blue': 2, 'green': 5, 'red': 2, 'grey': 1}
    },
    {
      'name': 'Manoj Sarkar',
      'role': 'Fullstack Developer',
      'image': AppImagesPng.five,
      'progress': 0.50,
      'status': 'away',
      'tasks': {'blue': 4, 'green': 8, 'red': 2, 'grey': 2}
    },
    {
      'name': 'Biswajit Maity',
      'role': 'Fullstack Developer',
      'image': AppImagesPng.six,
      'progress': 0.70,
      'status': 'online',
      'tasks': {'blue': 3, 'green': 15, 'red': 4, 'grey': 2}
    },
  ];

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
          'Team List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 18, color: Colors.white),
              label: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Text('Employee', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
              ),
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
              TeamFilterTabs(
                selectedIndex: _selectedTabIndex,
                onTabChanged: (index) {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
              ),
              const TeamSearchBar(),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.92,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: teamMembers.length,
                  itemBuilder: (context, index) {
                    final member = teamMembers[index];
                    return TeamMemberCard(member: member);
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

class TeamFilterTabs extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChanged;

  const TeamFilterTabs({
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
          _buildTab('All Teams (18)', 0),
          const SizedBox(width: 8),
          _buildTab('Active (5)', 1),
          const SizedBox(width: 8),
          _buildTab('On Leave (3)', 2),
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

class TeamSearchBar extends StatelessWidget {
  const TeamSearchBar({super.key});

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

class TeamMemberCard extends StatelessWidget {
  final Map<String, dynamic> member;

  const TeamMemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(member['image']),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Status Indicator in a white container
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: _getStatusColor(member['status']),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          // Info Overlay (Floating Card with margins)
          Positioned(
            left: 8,
            right: 8,
            bottom: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    member['name'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 1),
                                  Text(
                                    member['role'],
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.8),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            _buildCircularProgress(member['progress']),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'Task',
                              style: TextStyle(
                                color: Color(0xFFFFD700),
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(width: 8),
                            _buildTaskCount(const Color(0xFF4361EE), member['tasks']['blue']),
                            const SizedBox(width: 6),
                            _buildTaskCount(const Color(0xFF06D6A0), member['tasks']['green']),
                            const SizedBox(width: 6),
                            _buildTaskCount(const Color(0xFFEF233C), member['tasks']['red']),
                            const SizedBox(width: 6),
                            _buildTaskCount(const Color(0xFF8D99AE), member['tasks']['grey']),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularProgress(double progress) {
    return SizedBox(
      width: 32,
      height: 32,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 4.2,
            backgroundColor: Colors.white,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF06D6A0)),
          ),
          Text(
            '${(progress * 100).toInt()}%',
            style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCount(Color color, int count) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 2),
        Text(
          '$count',
          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'online':
        return const Color(0xFF06D6A0);
      case 'offline':
        return const Color(0xFFEF233C);
      case 'away':
        return const Color(0xFF8D99AE);
      default:
        return const Color(0xFF8D99AE);
    }
  }
}
