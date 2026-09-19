import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'presentation/screens/splash/splash_page.dart';
import 'presentation/screens/login/login_page.dart';
import 'presentation/screens/signup/signup_page.dart';
import 'presentation/screens/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://uctogeedluqmbmyexnju.supabase.co',
    publishableKey: 'sb_publishable_s2tuXMp_mEGrV6yEUzVSQQ_kOwpwsf9',
  );

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