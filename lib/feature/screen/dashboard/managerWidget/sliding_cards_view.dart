import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_colors.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';

class SlidingCardsView extends StatefulWidget {
  const SlidingCardsView({super.key});

  @override
  State<SlidingCardsView> createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  bool isTeamTracking = true;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
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
                    _pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
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
                      'Team Tracking (4)',
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
                    _pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
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
                      'Client Visit (5)',
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
        const SizedBox(height: 16),
        // Sliding Cards
        SizedBox(
          height: 200,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => isTeamTracking = index == 0);
            },
            children: [
              _buildTeamTrackingList(),
              _buildClientVisitList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTeamTrackingList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return _buildTeamTrackingCard(index);
      },
    );
  }

  Widget _buildTeamTrackingCard(int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF3B4760),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 18, backgroundImage: AssetImage(AppImagesPng.persionIcon)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Employee Details', style: TextStyle(color: Colors.grey, fontSize: 10)),
                    Text('Priyanka Ghosh', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                      const SizedBox(width: 4),
                      const Text('Live', style: TextStyle(color: Colors.green, fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Last Location', style: TextStyle(color: Colors.grey, fontSize: 10)),
            const Text(
              'Salt Lake, Sector V, Kolkata West Bengal, 700078',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Last Seen', style: TextStyle(color: Colors.grey, fontSize: 10)),
                      Text('18:55 PM', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.location_on, size: 14),
                    label: const Text('View on Map', style: TextStyle(fontSize: 10)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.2),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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

  Widget _buildClientVisitList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return _buildClientVisitCard(index);
      },
    );
  }

  Widget _buildClientVisitCard(int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF3E2D4C),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 18, backgroundImage: AssetImage(AppImagesPng.persionIcon)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Employee Details', style: TextStyle(color: Colors.grey, fontSize: 10)),
                    Text('Goutam Mazumder', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text('Schedule Time', style: TextStyle(color: Colors.grey, fontSize: 10)),
                    Text('10:15 AM - 11:00 AM', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('ABC Enterprises', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('Salt Lake Sector V, Kolkata', style: TextStyle(color: Colors.grey, fontSize: 10)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('In Progress', style: TextStyle(color: Colors.orange, fontSize: 10)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '1 Lac Bulksms & Whatsapp api requirement',
                style: TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
