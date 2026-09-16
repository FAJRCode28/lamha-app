import 'package:flutter/material.dart';
import 'presentation/screens/splash/splash_page.dart';
import 'presentation/screens/login/login_page.dart';
import 'presentation/screens/signup/signup_page.dart';
import 'presentation/screens/home/home_page.dart';

void main() {
  runApp(const LamhaApp());
}

class LamhaApp extends StatelessWidget {
  const LamhaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: '/',

      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}