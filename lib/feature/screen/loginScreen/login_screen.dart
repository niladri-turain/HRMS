import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_colors.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import 'package:hrms_app/feature/bottom_navigation/bottom_navigation_screen.dart';
import 'package:hrms_app/feature/screen/forgotPassword/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = true;
  bool _obscureText = true;
  final TextEditingController _userIdController = TextEditingController(text: 'TU0564');
  final TextEditingController _passwordController = TextEditingController();

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
              Color(0xFFFFF8F5),
              Color(0xFFDDD3E5),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Scrollable Content
              Positioned.fill(

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Logo section
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          AppImagesPng.splashLogo,
                          height: 110,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Heading
                      const Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1C2263),
                        ),
                      ),
                      // Subheading
                      const SizedBox(height: 5),
                      const Text(
                        'Sign in to manage your attendance, tasks, leaves, and work updates—all in one place.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF3E2D4C),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // User ID Field
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.20), // Fill: FFFFFF 20%
                          borderRadius: BorderRadius.circular(15), // Corner radius: 15
                          border: Border.all(
                            color: Colors.white.withOpacity(0.50), // Stroke: FFFFFF 50%
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        child: TextField(
                          controller: _userIdController,
                          decoration: InputDecoration(
                            labelText: 'Enter User ID',
                            labelStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                            border: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.auto, // Floats up on focus/click
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset(
                                AppImagesPng.editIcon,
                                height: 14,
                                width: 14,
                              ),
                            ),
                          ),
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.20), // Fill: FFFFFF 20%
                          borderRadius: BorderRadius.circular(15), // Corner radius: 15
                          border: Border.all(
                            color: Colors.white.withOpacity(0.50), // Stroke: FFFFFF 50%
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                            border: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.auto, // Floats up on focus/click
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Image.asset(
                                  AppImagesPng.eyeIcon,
                                  height: 14,
                                  width: 14,
                                  color: _obscureText
                                      ? const Color(0xFF6B7280)
                                      : AppColors.primary200,
                                ),
                              ),
                            ),
                          ),
                          style: const TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Login Button
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const BottomNavigation()),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primary200,
                            borderRadius: BorderRadius.circular(16),

                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Login to HRMS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Remember Me & Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _rememberMe = !_rememberMe;
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 34,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.20), // Fill: FFFFFF 20%
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.50), // Stroke: FFFFFF 50%
                                      width: 1,
                                    ),
                                  ),
                                  child: AnimatedAlign(
                                    duration: const Duration(milliseconds: 200),
                                    alignment: _rememberMe
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Container(
                                      width: 14,
                                      height: 14,
                                      margin: const EdgeInsets.symmetric(horizontal: 2),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _rememberMe
                                            ? AppColors.primary200
                                            : const Color(0xFF6B7280), // Selection color from your image
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Remember Me',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1B2CF1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Need help
                      Center(
                        child: GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Need help? Contact HR Support',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1C2263),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // Version Text perfectly aligned with Splash screen (30px from bottom)
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF1C2263),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
