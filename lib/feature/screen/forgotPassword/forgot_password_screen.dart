import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hrms_app/core/constants/app_colors.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import 'package:hrms_app/core/common_functions/validation.dart';
import 'package:hrms_app/feature/screen/forgotPassword/otp_verify_screen.dart';
import 'package:hrms_app/feature/provider/forgot_password_provider.dart';
import 'package:hrms_app/core/widgets/app_toast.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _contactController = TextEditingController();
  String? _contactError;
  late final AnimationController _shakeController;

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
    _contactController.dispose();
    super.dispose();
  }

  double _shakeOffset(double t) {
    return math.sin(t * math.pi * 6) * 8 * (1 - t);
  }

  @override
  Widget build(BuildContext context) {
    final forgotPasswordProvider = Provider.of<ForgotPasswordProvider>(context);

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
              // Back Button
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

              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: SingleChildScrollView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 100),
                        // Logo
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
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1C2263),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Subheading
                        const Text(
                          'No worries. Enter your registered email address or mobile number, and we\'ll send you a 6-digit OTP to reset your password.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF3E2D4C),
                            height: 1.5,

                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 20),

                        // Input Field
                        AnimatedBuilder(
                          animation: _shakeController,
                          builder: (context, child) {
                            final offset = _contactError != null
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
                                color: _contactError != null
                                    ? Colors.redAccent
                                    : Colors.white.withOpacity(0.50),
                                width: _contactError != null ? 1.4 : 1,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: 59,
                            alignment: Alignment.center,
                            child: TextField(
                              controller: _contactController,
                              textAlignVertical: TextAlignVertical.center,
                              onChanged: (_) {
                                if (_contactError != null) {
                                  setState(() {
                                    _contactError = null;
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Email Address or Mobile Number',
                                hintStyle: const TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                                // suffixIcon: Padding(
                                //   padding: const EdgeInsets.symmetric(vertical: 14),
                                //   child: Image.asset(
                                //     AppImagesPng.eyeIcon,
                                //     height: 18,
                                //     width: 18,
                                //     color: const Color(0xFF6B7280),
                                //   ),
                                // ),
                                suffixIconConstraints: const BoxConstraints(
                                  minHeight: 18,
                                  minWidth: 18,
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        if (_contactError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 6, left: 4),
                            child: Text(
                              _contactError!,
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        const SizedBox(height: 24),

                        // Send OTP Button
                        GestureDetector(
                          onTap: forgotPasswordProvider.isLoading
                              ? null
                              : () async {
                                  final contact = _contactController.text.trim();

                                  final validationError = AppValidators.validateEmail(contact);
                                  if (validationError != null) {
                                    setState(() {
                                      _contactError = validationError;
                                    });
                                    _shakeController.forward(from: 0);
                                    return;
                                  }

                                  bool success = await forgotPasswordProvider.forgotPassword(contact);

                                  if (success) {
                                    AppToast.show(
                                      context,
                                      forgotPasswordProvider.forgotPasswordResponse?.message ?? 'OTP Sent Successful',
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OtpVerifyScreen(emailOrMobile: contact),
                                      ),
                                    );
                                  } else {
                                    AppToast.show(context, forgotPasswordProvider.errorMessage ?? 'Request Failed');
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
                            child: forgotPasswordProvider.isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text(
                                    'Send OTP',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Back to Login Link
                        Center(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: RichText(
                              text: const TextSpan(
                                text: 'Remember your password? ',
                                style: TextStyle(
                                  color: Color(0xFF3E2D4C),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Back to Login',
                                    style: TextStyle(
                                      color: Color(0xFF1B2CF1),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
