import 'package:flutter/material.dart';
import 'feature/bottom_navigation/bottom_navigation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HRMS App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF901AEA)),
        useMaterial3: true,
      ),
      home: const BottomNavigation(),
    );
  }
}
