import 'package:flutter/material.dart';
import '../login/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/splash_background.png',
              fit: BoxFit.cover,
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 70),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/lamha_logo.png',
                    width: 240,
                  ),

                  const SizedBox(height: 2),

                  const Text(
                    'لمحة',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 54,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff6D2536),
                      letterSpacing: 1,

                      shadows: [
                        Shadow(
                          color: Color(0x306D2536),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 2),

                  const Text(
                    'LAMHA',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 5,
                      color: Color(0xffA67C7C),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}