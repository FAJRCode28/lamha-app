import 'package:flutter/material.dart';
import 'presentation/screens/splash/splash_page.dart';

void main() {
  runApp(const LamhaApp());
}

class LamhaApp extends StatelessWidget {
  const LamhaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}