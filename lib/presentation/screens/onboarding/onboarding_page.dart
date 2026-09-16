import 'package:flutter/material.dart';
import '../login/login_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/onboarding1.jpg',
      'title': 'اعرف المكان قبل ما تروح',
      'description':
          'شوف الزحمة، المواقف، الأوقات، وأهم التفاصيل قبل ما تطلع.',
    },
    {
      'image': 'assets/images/onboarding2.jpg',
      'title': 'اكتشف أماكن جديدة',
      'description':
          'وجهات مختارة وتجارب مميزة تساعدك تختار المكان المناسب لك.',
    },
    {
      'image': 'assets/images/onboarding3.jpg',
      'title': 'كل اللي تحتاجه في مكان واحد',
      'description':
          'كل التفاصيل المهمة اللي تحتاجها قبل ما تروح، في مكان واحد.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color cream = Color(0xFFFFF4E6);
    const Color softCream = Color(0xFFEBD7C2);

    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: onboardingData.length,

        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },

        itemBuilder: (context, index) {
          final item = onboardingData[index];

          return Stack(
            fit: StackFit.expand,
            children: [
              // =========================
              // Background Image
              // =========================
              Image.asset(
                item['image']!,
                fit: BoxFit.cover,
              ),

              // =========================
              // Dark Overlay
              // =========================
              Container(
                color: Colors.black.withOpacity(0.18),
              ),

              // =========================
              // Bottom Gradient
              // =========================
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.08),
                      Colors.black.withOpacity(0.72),
                    ],
                    stops: const [
                      0.0,
                      0.50,
                      1.0,
                    ],
                  ),
                ),
              ),

              // =========================
              // Content
              // =========================
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      const Spacer(),

                      // =========================
                      // Title
                      // =========================
                      Text(
                        item['title']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Amiri',
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: cream,
                          height: 1.4,
                          shadows: [
                            Shadow(
                              color: Colors.black45,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // =========================
                      // Description
                      // =========================
                      Text(
                        item['description']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Amiri',
                          fontSize: 18,
                          color: softCream,
                          height: 1.6,
                          shadows: [
                            Shadow(
                              color: Colors.black38,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 26),

                      // =========================
                      // Page Indicators
                      // =========================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          onboardingData.length,
                          (dotIndex) {
                            final bool isActive =
                                currentPage == dotIndex;

                            return AnimatedContainer(
                              duration:
                                  const Duration(milliseconds: 250),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              width: isActive ? 22 : 7,
                              height: 7,
                              decoration: BoxDecoration(
                                color: isActive
                                    ? cream
                                    : Colors.white.withOpacity(0.40),
                                borderRadius:
                                    BorderRadius.circular(20),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 24),

                      // =========================
                      // Start - Last Page Only
                      // =========================
                      if (currentPage ==
                          onboardingData.length - 1)
                        SizedBox(
                          height: 54,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const LoginPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'ابدأ الآن',
                              style: TextStyle(
                                fontFamily: 'Amiri',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: cream,
                              ),
                            ),
                          ),
                        )
                      else
                        const SizedBox(height: 54),

                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}