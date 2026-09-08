import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_colors.dart';
import 'package:intl/intl.dart';

class LoginLogoutCard extends StatefulWidget {
  const LoginLogoutCard({super.key});

  @override
  State<LoginLogoutCard> createState() => _LoginLogoutCardState();
}

class _LoginLogoutCardState extends State<LoginLogoutCard> {
  bool isLoggedIn = false;
  String loginTime = "--:-- --";
  String logoutTime = "--:-- --";
  String currentTime = "";
  late var timer;
  double _dragPosition = 0;
  final double _sliderHeight = 52;
  final double _handleWidth = 44;

  @override
  void initState() {
    super.initState();
    _updateTime();
    timer = Stream.periodic(const Duration(seconds: 1)).listen((_) {
      if (mounted) {
        setState(() {
          _updateTime();
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _updateTime() {
    currentTime = DateFormat('hh:mm a').format(DateTime.now());
  }

  void _onSlideComplete() {
    setState(() {
      if (!isLoggedIn) {
        // Logging In
        isLoggedIn = true;
        loginTime = currentTime;
        logoutTime = "--:-- --";
      } else {
        // Logging Out
        logoutTime = currentTime;
        // The user said "reset hoye blue ta chole asbe" - meaning it returns to login state?
        // Let's wait a bit then reset or just reset immediately. 
        // Usually, logout time is shown, then it resets for the next day or shift.
        // For now, let's keep the logout time visible but reset the button to "Login" state.
        isLoggedIn = false;
      }
      _dragPosition = 0;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CURRENT TIME',
                    style: TextStyle(
                      color: AppColors.grey200,
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    currentTime,
                    style: const TextStyle(
                      color: Color(0xFF2E2E3E),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    isLoggedIn ? '01:37:20 Work Time' : '10:30 - 19:00 Work Schedule',
                    style: TextStyle(
                      color: isLoggedIn ? AppColors.green200 : AppColors.blue150,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: AppColors.green200.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.green200.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.green200,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'On Time',
                      style: TextStyle(
                        color: AppColors.green200,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Custom Slider Button
          LayoutBuilder(builder: (context, constraints) {
            double maxDrag = constraints.maxWidth - _handleWidth - 8;
            return Container(
              width: double.infinity,
              height: _sliderHeight,
              decoration: BoxDecoration(
                color: isLoggedIn ? AppColors.red200 : AppColors.blue200,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      isLoggedIn ? 'Slide to Logged Out' : 'Slide to Logged In',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 100),
                    left: 10 + _dragPosition,
                    top: 5,
                    bottom: 5,
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          _dragPosition += details.delta.dx;
                          if (_dragPosition < 0) _dragPosition = 0;
                          if (_dragPosition > maxDrag) _dragPosition = maxDrag;
                        });
                      },
                      onHorizontalDragEnd: (details) {
                        if (_dragPosition >= maxDrag * 0.8) {
                          _onSlideComplete();
                        } else {
                          setState(() {
                            _dragPosition = 0;
                          });
                        }
                      },
                      child: Container(
                        width: _handleWidth,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('|', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 16),
          Center(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: AppColors.grey200, fontSize: 12),
                children: [
                  const TextSpan(text: 'You\'re Currently: '),
                  TextSpan(
                    text: isLoggedIn ? 'Working' : 'Not Logged In',
                    style: TextStyle(
                      color: isLoggedIn ? AppColors.green200 : AppColors.grey200,
                      fontWeight: FontWeight.w500,
                      fontSize: 12
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Dotted Divider
          Row(
            children: List.generate(
                60,
                (index) => Expanded(
                      child: Container(
                        color: index % 2 == 0 ? Colors.transparent : AppColors.grey200.withOpacity(0.3),
                        height: 1,
                      ),
                    )),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login Time',
                    style: TextStyle(
                      color: AppColors.grey50,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    loginTime,
                    style: const TextStyle(
                      color: Color(0xFF2E2E3E),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Logout Time',
                    style: TextStyle(
                      color: AppColors.grey50,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    logoutTime,
                    style: const TextStyle(
                      color: Color(0xFF2E2E3E),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
