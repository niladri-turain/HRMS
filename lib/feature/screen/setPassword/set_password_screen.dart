import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hrms_app/core/constants/app_colors.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import 'package:hrms_app/core/common_functions/validation.dart';
import 'package:hrms_app/feature/provider/reset_password_provider.dart';
import 'package:hrms_app/feature/provider/login_provider.dart';
import 'package:hrms_app/feature/bottom_navigation/bottom_navigation_screen.dart';

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

class _SetPasswordScreenState extends State<SetPasswordScreen> with SingleTickerProviderStateMixin {
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  String? _newPasswordError;
  String? _confirmPasswordError;
  late final AnimationController _shakeController;
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  double _shakeOffset(double t) {
    return math.sin(t * math.pi * 6) * 8 * (1 - t);
  }

  void _handleResetPassword() async {
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // Validation
    final passwordError = AppValidators.validatePassword(newPassword);
    final confirmError = confirmPassword.isEmpty
        ? 'Please confirm your password'
        : (newPassword != confirmPassword ? 'Passwords do not match' : null);

    if (passwordError != null || confirmError != null) {
      setState(() {
        _newPasswordError = passwordError;
        _confirmPasswordError = confirmError;
      });
      _shakeController.forward(from: 0);
      return;
    }

    final resetProvider = Provider.of<ResetPasswordProvider>(context, listen: false);
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    bool success = await resetProvider.resetPassword(
      resetToken: widget.resetToken,
      password: newPassword,
      passwordConfirmation: confirmPassword,
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resetProvider.resetPasswordResponse?.message ?? 'Password reset successful'), backgroundColor: Colors.green),
      );

      // Automatically login
      bool loginSuccess = await loginProvider.login(widget.emailOrMobile, newPassword);

      if (loginSuccess && mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavigation()),
          (route) => false,
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(loginProvider.errorMessage ?? 'Automatic login failed. Please login manually.'), backgroundColor: Colors.orange),
        );
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resetProvider.errorMessage ?? 'Reset failed'), backgroundColor: Colors.redAccent),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final resetProvider = Provider.of<ResetPasswordProvider>(context);
    final loginProvider = Provider.of<LoginProvider>(context);
    final isLoading = resetProvider.isLoading || loginProvider.isLoading;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: constraints.maxHeight),
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
                      AnimatedBuilder(
                        animation: _shakeController,
                        builder: (context, child) {
                          final offset = _newPasswordError != null
                              ? _shakeOffset(_shakeController.value)
                              : 0.0;
                          return Transform.translate(
                            offset: Offset(offset, 0),
                            child: child,
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.20), // Fill: FFFFFF 20%
                            borderRadius: BorderRadius.circular(15), // Corner radius: 15
                            border: Border.all(
                              color: _newPasswordError != null
                                  ? Colors.redAccent
                                  : Colors.white.withOpacity(0.50), // Stroke: FFFFFF 50%
                              width: _newPasswordError != null ? 1.4 : 1,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: TextField(
                            controller: _newPasswordController,
                            obscureText: _obscureNewPassword,
                            onChanged: (_) {
                              if (_newPasswordError != null) {
                                setState(() {
                                  _newPasswordError = null;
                                });
                              }
                            },
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
                      ),
                      if (_newPasswordError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 6, left: 4),
                          child: Text(
                            _newPasswordError!,
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      const SizedBox(height: 16),

                      // Confirm Password Field
                      AnimatedBuilder(
                        animation: _shakeController,
                        builder: (context, child) {
                          final offset = _confirmPasswordError != null
                              ? _shakeOffset(_shakeController.value)
                              : 0.0;
                          return Transform.translate(
                            offset: Offset(offset, 0),
                            child: child,
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.20), // Fill: FFFFFF 20%
                            borderRadius: BorderRadius.circular(15), // Corner radius: 15
                            border: Border.all(
                              color: _confirmPasswordError != null
                                  ? Colors.redAccent
                                  : Colors.white.withOpacity(0.50), // Stroke: FFFFFF 50%
                              width: _confirmPasswordError != null ? 1.4 : 1,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: TextField(
                            controller: _confirmPasswordController,
                            obscureText: _obscureConfirmPassword,
                            onChanged: (_) {
                              if (_confirmPasswordError != null) {
                                setState(() {
                                  _confirmPasswordError = null;
                                });
                              }
                            },
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
                      ),
                      if (_confirmPasswordError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 6, left: 4),
                          child: Text(
                            _confirmPasswordError!,
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      const SizedBox(height: 18),

                      // Verify Button
                      GestureDetector(
                        onTap: isLoading ? null : _handleResetPassword,
                        child: Container(
                          width: double.infinity,
                          height: 57,
                          decoration: BoxDecoration(
                            color: AppColors.primary200,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.center,
                          child: isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
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
                      );
                    },
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
