import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hrms_app/core/constants/app_colors.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import 'package:hrms_app/core/common_functions/validation.dart';
import 'package:hrms_app/feature/bottom_navigation/bottom_navigation_screen.dart';
import 'package:hrms_app/feature/screen/forgotPassword/forgot_password_screen.dart';
import 'package:hrms_app/feature/provider/login_provider.dart';
import 'package:hrms_app/core/constants/app_sizes.dart';
import 'package:hrms_app/core/widgets/app_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppSize.init(context);
    });
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _userIdController.dispose();
    _passwordController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  bool _rememberMe = true;
  bool _obscureText = true;
  bool _isOtpLogin = false;
  String? _userIdError;
  String? _passwordError;
  late final AnimationController _shakeController;
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  double _shakeOffset(double t) {
    return math.sin(t * math.pi * 6) * 8 * (1 - t);
  }

  Widget _buildLoginModeOption({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.primary200 : const Color(0xFF9CA3AF),
                width: 1.5,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary200,
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isSelected ? const Color(0xFF1C2263) : const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

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
              // Scrollable Content
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 80),
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
                            'Welcome Back',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1C2263),
                            ),
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
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 16),

                        // Login Mode Selector
                        Row(
                          children: [
                            _buildLoginModeOption(
                              label: 'User ID',
                              isSelected: !_isOtpLogin,
                              onTap: () {
                                setState(() {
                                  _isOtpLogin = false;
                                });
                              },
                            ),
                            const SizedBox(width: 24),
                            _buildLoginModeOption(
                              label: 'OTP',
                              isSelected: _isOtpLogin,
                              onTap: () {
                                setState(() {
                                  _isOtpLogin = true;
                                  _userIdError = null;
                                  _passwordError = null;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        if (!_isOtpLogin) ...[
                          // User ID Field
                          AnimatedBuilder(
                            animation: _shakeController,
                            builder: (context, child) {
                              final offset = _userIdError != null
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
                                color: Colors.white.withOpacity(0.20),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: _userIdError != null
                                      ? Colors.redAccent
                                      : Colors.white.withOpacity(0.50),
                                  width: _userIdError != null ? 1.4 : 1,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                              child: TextField(
                                controller: _userIdController,
                                onChanged: (_) {
                                  if (_userIdError != null) {
                                    setState(() {
                                      _userIdError = null;
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: 'Enter User ID',
                                  labelStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                                  border: InputBorder.none,
                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  // suffixIcon: Padding(
                                  //   padding: const EdgeInsets.all(15.0),
                                  //   child: Image.asset(
                                  //     AppImagesPng.editIcon,
                                  //     height: 14,
                                  //     width: 14,
                                  //   ),
                                  // ),
                                ),
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
                              ),
                            ),
                          ),
                          if (_userIdError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 6, left: 4),
                              child: Text(
                                _userIdError!,
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          const SizedBox(height: 16),

                          // Password Field
                          AnimatedBuilder(
                            animation: _shakeController,
                            builder: (context, child) {
                              final offset = _passwordError != null
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
                                color: Colors.white.withOpacity(0.20),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: _passwordError != null
                                      ? Colors.redAccent
                                      : Colors.white.withOpacity(0.50),
                                  width: _passwordError != null ? 1.4 : 1,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                              child: TextField(
                                controller: _passwordController,
                                obscureText: _obscureText,
                                onChanged: (_) {
                                  if (_passwordError != null) {
                                    setState(() {
                                      _passwordError = null;
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                                  border: InputBorder.none,
                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
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
                                style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          if (_passwordError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 6, left: 4),
                              child: Text(
                                _passwordError!,
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ] else ...[
                          // Mobile Number Field
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.20),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.50),
                                width: 1,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                            child: TextField(
                              controller: _mobileNumberController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Enter Mobile Number',
                                labelStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                                border: InputBorder.none,
                                floatingLabelBehavior: FloatingLabelBehavior.auto,
                                // suffixIcon: Padding(
                                //   padding: const EdgeInsets.all(15.0),
                                //   child: Image.asset(
                                //     AppImagesPng.editIcon,
                                //     height: 14,
                                //     width: 14,
                                //   ),
                                // ),
                              ),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
                            ),
                          ),
                        ],
                        const SizedBox(height: 18),

                        // Login Button
                        GestureDetector(
                          onTap: loginProvider.isLoading
                              ? null
                              : () async {
                                  if (_isOtpLogin) {
                                    AppToast.show(context, 'OTP login is coming soon');
                                    return;
                                  }

                                  final usernameError = AppValidators.validateUsername(_userIdController.text);
                                  final passwordError = AppValidators.validatePassword(_passwordController.text);

                                  if (usernameError != null || passwordError != null) {
                                    setState(() {
                                      _userIdError = usernameError;
                                      _passwordError = passwordError;
                                    });
                                    _shakeController.forward(from: 0);
                                    return;
                                  }

                                  bool success = await loginProvider.login(
                                    _userIdController.text.trim(),
                                    _passwordController.text,
                                  );

                                  if (success) {
                                    AppToast.show(context, 'Login Successful');
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const BottomNavigation()),
                                    );
                                  } else {
                                    AppToast.show(context, loginProvider.errorMessage ?? 'Login Failed');
                                  }
                                },
                          child: Container(
                            width: double.infinity,
                            height: 57,
                            decoration: BoxDecoration(
                              color: AppColors.primary200,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            alignment: Alignment.center,
                            child: loginProvider.isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    _isOtpLogin ? 'Send OTP' : 'Login to HRMS',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        if (!_isOtpLogin)
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
                                        color: Colors.white.withOpacity(0.20),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.50),
                                          width: 1,
                                        ),
                                      ),
                                      child: AnimatedAlign(
                                        duration: const Duration(milliseconds: 200),
                                        alignment: _rememberMe ? Alignment.centerRight : Alignment.centerLeft,
                                        child: Container(
                                          width: 14,
                                          height: 14,
                                          margin: const EdgeInsets.symmetric(horizontal: 2),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _rememberMe ? AppColors.primary200 : const Color(0xFF6B7280),
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
              ),

              // Version Text
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
