import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hrms_app/core/constants/app_colors.dart';
import 'package:hrms_app/core/constants/app_images_png.dart';
import 'package:hrms_app/core/common_functions/validation.dart';
import 'package:hrms_app/feature/screen/forgotPassword/otp_verify_screen.dart';
import 'package:hrms_app/feature/provider/forgot_password_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final forgotPasswordProvider = Provider.of<ForgotPasswordProvider>(context);

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
                            controller: _contactController,
                            textAlign: TextAlign.left,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: const InputDecoration(
                              hintText: 'Email Address or Mobile Number',
                              hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
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
                                  
                                  // Basic validation: Check if empty
                                  if (contact.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Please enter email or mobile number'),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                    );
                                    return;
                                  }

                                  // If it looks like email, validate email format
                                  if (contact.contains('@')) {
                                    final emailError = AppValidators.validateEmail(contact);
                                    if (emailError != null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(emailError),
                                          backgroundColor: Colors.redAccent,
                                        ),
                                      );
                                      return;
                                    }
                                  }

                                  bool success = await forgotPasswordProvider.forgotPassword(contact);

                                  if (success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(forgotPasswordProvider.forgotPasswordResponse?.message ?? 'OTP Sent Successful'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const OtpVerifyScreen(),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(forgotPasswordProvider.errorMessage ?? 'Request Failed'),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                    );
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
                bottom: 30,
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
