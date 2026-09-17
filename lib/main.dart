import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hrms_app/core/di/injection_container.dart' as di;
import 'package:hrms_app/feature/provider/login_provider.dart';
import 'package:hrms_app/feature/provider/forgot_password_provider.dart';
import 'package:hrms_app/feature/provider/otp_verify_provider.dart';
import 'package:hrms_app/feature/provider/reset_password_provider.dart';
import 'package:hrms_app/feature/provider/managerProvider/employee_list_provider.dart';
import 'package:hrms_app/feature/provider/managerProvider/manager_employee_tracking_provider.dart';
import 'feature/bottom_navigation/bottom_navigation_screen.dart';
import 'feature/screen/splash/splash_screen.dart';

import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MapboxOptions.setAccessToken("pk.eyJ1IjoibmlsYWRyaTE5OTYiLCJhIjoiY211NTV1bWxlMG45ejJ3cXZyYmFtN2lnOSJ9.XH5-RUlsbr3ztLUwZznXIw");
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<LoginProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<ForgotPasswordProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<OtpVerifyProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<ResetPasswordProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<EmployeeListProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<ManagerEmployeeTrackingProvider>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HRMS App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF901AEA)),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
