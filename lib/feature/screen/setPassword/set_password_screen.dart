import 'package:flutter/material.dart';
import 'package:hrms_app/core/constants/app_colors.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';

class SetPasswordScreen extends StatefulWidget {
  final String emailOrMobile;
  final String resetToken;

  const SetPasswordScreen({
    super.key,
    required this.emailOrMobile,
    required this.resetToken,
  });

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
              Color(0xFFFFF8F5),
              Color(0xFFDDD3E5),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Back Button - Transparent circular button with white border
              Positioned(
                top: 10,
                left: 20,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColors.primary200,
                      size: 20,
                    ),
                  ),
                ),
              ),

              // Main content matching Login Screen layout
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo section
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          AppImagesPng.splashLogo,
                          height: 110,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Heading
                      Center(
                        child: const Text(
                          'Password Reset',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1C2263),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),

                      // Subheading
                      const Text(
                        'Please enter your new password and confirm it to successfully reset your account credentials.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF3E2D4C),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),

                      // Set New Password Field
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
                          controller: _newPasswordController,
                          obscureText: _obscureNewPassword,
                          decoration: InputDecoration(
                            labelText: 'Set New Password',
                            labelStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                            border: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureNewPassword = !_obscureNewPassword;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Image.asset(
                                  AppImagesPng.eyeIcon,
                                  height: 14,
                                  width: 14,
                                  color: _obscureNewPassword
                                      ? const Color(0xFF6B7280)
                                      : AppColors.primary200,
                                ),
                              ),
                            ),
                          ),
                          style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Confirm Password Field
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
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                            border: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureConfirmPassword = !_obscureConfirmPassword;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Image.asset(
                                  AppImagesPng.eyeIcon,
                                  height: 14,
                                  width: 14,
                                  color: _obscureConfirmPassword
                                      ? const Color(0xFF6B7280)
                                      : AppColors.primary200,
                                ),
                              ),
                            ),
                          ),
                          style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Verify Button
                      GestureDetector(
                        onTap: () {
                          // Submit action
                        },
                        child: Container(
                          width: double.infinity,
                          height: 57,
                          decoration: BoxDecoration(
                            color: AppColors.primary200,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Verify',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // Version Text perfectly aligned (30px from bottom)
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
