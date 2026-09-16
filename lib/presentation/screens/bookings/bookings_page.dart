import 'package:flutter/material.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color background = Color(0xFFFCFAF8);
    const Color cream = Color(0xFFF8F3EC);
    const Color burgundy = Color(0xFF6D2536);
    const Color darkBrown = Color(0xFF49372E);
    const Color softBrown = Color(0xFF796A61);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: background,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 20,
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFEDE5DF),
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    color: darkBrown,
                    size: 21,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              const Text(
                'حجوزاتي',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: darkBrown,
                ),
              ),
            ],
          ),
        ),

        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: cream,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.confirmation_number_outlined,
                    color: burgundy,
                    size: 44,
                  ),
                ),

                const SizedBox(height: 22),

                const Text(
                  'ما عندك حجوزات للحين',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkBrown,
                  ),
                ),

                const SizedBox(height: 9),

                const Text(
                  'إذا حجزت تجربة أو فعالية، بتلقى تفاصيل حجزك هنا.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.6,
                    color: softBrown,
                  ),
                ),

                const SizedBox(height: 22),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    color: cream,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 17,
                        color: burgundy,
                      ),
                      SizedBox(width: 7),
                      Flexible(
                        child: Text(
                          'الحجز يظهر للأماكن والتجارب التي تتطلب تذكرة.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            color: darkBrown,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}