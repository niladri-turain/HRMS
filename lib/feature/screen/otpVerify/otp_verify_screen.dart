import 'package:flutter/material.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  @override
  State<OtpVerifyScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<OtpVerifyScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(child: Text("OtpVerifyScreen"),),
    );
  }
}
