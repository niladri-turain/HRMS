import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hrms_app/core/di/injection_container.dart' as di;
import 'package:hrms_app/feature/provider/login_provider.dart';
import 'feature/bottom_navigation/bottom_navigation_screen.dart';
import 'feature/screen/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
