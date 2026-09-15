import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import 'package:hrms_app/feature/bottom_navigation/bottom_navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavigation()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFEDEAE9),
              Color(0xFFEDD5F8),
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Centered Splash Logo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Image.asset(
                AppImagesPng.splashLogo,
                fit: BoxFit.contain,
                height: 140,
                width: 179,
              ),
            ),
            // Bottom Version Text
            const Positioned(
              bottom: 30,
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF1C2263),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
