import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_colors.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import 'package:intl/intl.dart';

class TaskTrackingCard extends StatefulWidget {
  const TaskTrackingCard({super.key});

  @override
  State<TaskTrackingCard> createState() => _TaskTrackingCardState();
}

class _TaskTrackingCardState extends State<TaskTrackingCard> {
  bool _isTaskOn = false;
  String _startTime = '--:-- --';

  void _toggleTask() {
    setState(() {
      _isTaskOn = !_isTaskOn;
      if (_isTaskOn) {
        _startTime = DateFormat('hh:mm a').format(DateTime.now());
      } else {
        _startTime = '--:-- --';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
            'Task Tracking',
            style: TextStyle(
              color: AppColors.primary200,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Active Task',
                    style: TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _isTaskOn ? AppColors.green200.withOpacity(0.1) : const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: _isTaskOn ? AppColors.green200.withOpacity(0.2) : const Color(0xFFE5E7EB)),
                    ),
                    child: Text(
                      _isTaskOn ? 'ON' : 'OFF',
                      style: TextStyle(
                        color: _isTaskOn ? AppColors.green200 : const Color(0xFF6B7280),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Started At',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _startTime,
                    style: const TextStyle(
                      color: AppColors.green200,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Current Task',
            style: TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _isTaskOn ? 'HRMS Dashboard UI Implementation' : 'No Active Task',
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _toggleTask,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF374151)),
                borderRadius: BorderRadius.circular(8),
                color: _isTaskOn ? const Color(0xFF374151).withOpacity(0.05) : Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _isTaskOn ? Icons.stop_circle_outlined : Icons.play_arrow,
                    color: const Color(0xFF374151),
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isTaskOn ? 'Task Off' : 'Task On',
                    style: const TextStyle(
                      color: Color(0xFF374151),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Image.asset(
                AppImagesPng.light,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Login to attendance before starting a task.',
                  style: TextStyle(
                    color: AppColors.yellow200,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
