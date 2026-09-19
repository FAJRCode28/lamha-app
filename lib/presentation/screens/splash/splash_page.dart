import 'package:flutter/material.dart';
import '../onboarding/onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String animatedTitle = '';
  bool showTagline = false;
  bool showBottomText = false;

  final String title = 'لمحة';

  @override
  void initState() {
    super.initState();

    startAnimation();

    Future.delayed(
      const Duration(seconds: 8),
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

  Future<void> startAnimation() async {
    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    for (int i = 0; i < title.length; i++) {
      if (!mounted) return;

      setState(() {
        animatedTitle += title[i];
      });

      await Future.delayed(
        const Duration(milliseconds: 350),
      );
    }

    await Future.delayed(
      const Duration(milliseconds: 300),
    );

    if (!mounted) return;

    setState(() {
      showTagline = true;
    });

    await Future.delayed(
      const Duration(milliseconds: 600),
    );

    if (!mounted) return;

    setState(() {
      showBottomText = true;
    });
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

                  TweenAnimationBuilder<double>(
                    tween: Tween(
                      begin: 0.0,
                      end: 1.0,
                    ),
                    duration: const Duration(
                      milliseconds: 900,
                    ),
                    curve: Curves.easeOutBack,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value.clamp(0.0, 1.0),
                        child: Transform.scale(
                          scale: 0.8 + (0.2 * value),
                          child: child,
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/images/palm_logo.png',
                      width: 68,
                      height: 78,
                      fit: BoxFit.contain,
                      color: mainCream,
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    height: 80,
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(
                          milliseconds: 250,
                        ),
                        transitionBuilder:
                            (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: Text(
                          animatedTitle,
                          key: ValueKey(animatedTitle),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
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
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  AnimatedOpacity(
                    opacity: showTagline ? 1 : 0,
                    duration: const Duration(
                      milliseconds: 800,
                    ),
                    child: AnimatedSlide(
                      offset: showTagline
                          ? Offset.zero
                          : const Offset(0, 0.25),
                      duration: const Duration(
                        milliseconds: 800,
                      ),
                      curve: Curves.easeOut,
                      child: const Text(
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
                    ),
                  ),

                  const Spacer(flex: 5),

                  AnimatedOpacity(
                    opacity: showBottomText ? 1 : 0,
                    duration: const Duration(
                      milliseconds: 900,
                    ),
                    child: const Text(
                      'رحلتك تبدأ من لمحة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Amiri',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: bottomCream,
                      ),
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