import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_colors.dart';

class ClientVisitReportCard extends StatelessWidget {
  const ClientVisitReportCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Statistics',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  Text(
                    'Client Visit Report',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary200,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: const [
                    Text('Last 7 Day', style: TextStyle(fontSize: 12)),
                    Icon(Icons.keyboard_arrow_down, size: 16),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar(16, 12, 8, 4),
                _buildBar(12, 8, 6, 2),
                _buildBar(18, 14, 10, 6),
                _buildBar(14, 10, 5, 3),
                _buildBar(10, 6, 4, 1),
                _buildBar(15, 11, 7, 3),
                _buildBar(13, 9, 6, 2),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegend('Total', Colors.grey),
              const SizedBox(width: 8),
              _buildLegend('Completed', Colors.green),
              const SizedBox(width: 8),
              _buildLegend('Upcoming', Colors.blue),
              const SizedBox(width: 8),
              _buildLegend('Progress', Colors.orange),
              const SizedBox(width: 8),
              _buildLegend('Cancel', Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBar(double h1, double h2, double h3, double h4) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(width: 8, height: h1 * 6, color: Colors.grey.shade300),
            Container(width: 8, height: h2 * 6, color: Colors.green),
            Container(width: 8, height: h3 * 6, color: Colors.orange),
            Container(width: 8, height: h4 * 6, color: Colors.red),
          ],
        ),
        const SizedBox(height: 4),
        const Text('12 Aug', style: TextStyle(fontSize: 8, color: Colors.grey)),
      ],
    );
  }

  Widget _buildLegend(String label, Color color) {
    return Row(
      children: [
        Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 8, color: Colors.grey)),
      ],
    );
  }
}
