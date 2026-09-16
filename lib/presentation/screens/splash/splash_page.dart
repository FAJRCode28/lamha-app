import 'package:flutter/material.dart';
import '../onboarding/onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 11),
      () {
        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OnboardingPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color mainCream = Color(0xFFF8EAD8);
    const Color softCream = Color(0xFFEBD7C2);
    const Color bottomCream = Color(0xFFDCC7B3);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/splash_alula.jpg',
            fit: BoxFit.cover,
          ),

          Container(
            color: Colors.black.withOpacity(0.22),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.05),
                  Colors.black.withOpacity(0.12),
                  Colors.black.withOpacity(0.28),
                  Colors.black.withOpacity(0.58),
                ],
                stops: const [
                  0.0,
                  0.35,
                  0.68,
                  1.0,
                ],
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
              ),
              child: Column(
                children: [
                  const Spacer(flex: 4),

                  Image.asset(
                    'assets/images/palm_logo.png',
                    width: 68,
                    height: 78,
                    fit: BoxFit.contain,
                    color: mainCream,
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'لمحة',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Rakkas',
                      fontSize: 72,
                      fontWeight: FontWeight.w400,
                      height: 1.1,
                      color: Color(0xFFFFF4E6),
                      shadows: [
                        Shadow(
                          color: Colors.black38,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'اعرف قبل ما تروح',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      color: softCream,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 5),

                  const Text(
                    'رحلتك تبدأ من لمحة',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: bottomCream,
                    ),
                  ),

                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}