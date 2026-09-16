import 'package:flutter/material.dart';
import '../suggest_place/suggest_place_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    const Color background = Color(0xFFFCFAF8);
    const Color cream = Color(0xFFF8F3EC);
    const Color burgundy = Color(0xFF6D2536);
    const Color darkBrown = Color(0xFF49372E);
    const Color softBrown = Color(0xFF796A61);
    const Color borderColor = Color(0xFFEDE5DF);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: borderColor,
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
                      'حسابي',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: darkBrown,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // PROFILE CARD
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: burgundy,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: burgundy.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 76,
                            height: 76,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.18),
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person_rounded,
                                size: 40,
                                color: burgundy,
                              ),
                            ),
                          ),

                          const SizedBox(width: 15),

                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'فجر',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'fajr@example.com',
                                  style: TextStyle(
                                    color: Color(0xFFE7D7DB),
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 7),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: Color(0xFFF0E4E7),
                                      size: 15,
                                    ),
                                    SizedBox(width: 3),
                                    Text(
                                      'السعودية',
                                      style: TextStyle(
                                        color: Color(0xFFF0E4E7),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'تعديل الملف الشخصي قريبًا',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.white.withOpacity(0.55),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            foregroundColor: Colors.white,
                          ),
                          icon: const Icon(
                            Icons.edit_outlined,
                            size: 17,
                          ),
                          label: const Text(
                            'تعديل الملف الشخصي',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // MY INFO
                const Text(
                  'معلوماتي',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkBrown,
                  ),
                ),

                const SizedBox(height: 11),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: borderColor,
                    ),
                  ),
                  child: const Column(
                    children: [
                      _AccountRow(
                        icon: Icons.person_outline_rounded,
                        title: 'الاسم',
                        value: 'فجر',
                      ),
                      _DividerLine(),
                      _AccountRow(
                        icon: Icons.email_outlined,
                        title: 'البريد الإلكتروني',
                        value: 'fajr@example.com',
                      ),
                      _DividerLine(),
                      _AccountRow(
                        icon: Icons.phone_outlined,
                        title: 'رقم الجوال',
                        value: '05X XXX XXXX',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 27),

                // PREFERENCES
                const Text(
                  'تفضيلاتي',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkBrown,
                  ),
                ),

                const SizedBox(height: 11),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: borderColor,
                    ),
                  ),
                  child: Column(
                    children: [
                      const _SettingsRow(
                        icon: Icons.location_city_outlined,
                        title: 'المدينة',
                        subtitle: 'حدد مدينتك',
                        trailingText: 'جدة',
                      ),

                      const _DividerLine(),

                      const _SettingsRow(
                        icon: Icons.favorite_border_rounded,
                        title: 'اهتماماتي',
                        subtitle: 'الأماكن اللي تفضلها',
                        trailingText: 'تعديل',
                      ),

                      const _DividerLine(),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: cream,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.notifications_none_rounded,
                                color: burgundy,
                                size: 21,
                              ),
                            ),

                            const SizedBox(width: 12),

                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'الإشعارات',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: darkBrown,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'تنبيهات الحجوزات والتحديثات',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: softBrown,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Switch(
                              value: notificationsEnabled,
                              activeColor: Colors.white,
                              activeTrackColor: burgundy,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor:
                                  const Color(0xFFD8CCC5),
                              onChanged: (value) {
                                setState(() {
                                  notificationsEnabled = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 27),

                // LAMHA
                Row(
                  children: [
                    const Text(
                      'لمحة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: darkBrown,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'LAMHA',
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 1.5,
                        color: softBrown.withOpacity(0.75),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 11),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: borderColor,
                    ),
                  ),
                  child: Column(
                    children: [
                      _MenuRow(
                        icon: Icons.add_location_alt_outlined,
                        title: 'اقترح مكان',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SuggestPlacePage(),
                            ),
                          );
                        },
                      ),
                      const _DividerLine(),
                      _MenuRow(
                        icon: Icons.info_outline_rounded,
                        title: 'عن لمحة',
                        onTap: () {
                          showMessage(context, 'عن لمحة قريبًا');
                        },
                      ),
                      const _DividerLine(),
                      _MenuRow(
                        icon: Icons.chat_bubble_outline_rounded,
                        title: 'تواصل معنا',
                        onTap: () {
                          showMessage(context, 'تواصل معنا قريبًا');
                        },
                      ),
                      const _DividerLine(),
                      _MenuRow(
                        icon: Icons.shield_outlined,
                        title: 'سياسة الخصوصية',
                        onTap: () {
                          showMessage(context, 'سياسة الخصوصية قريبًا');
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // LOGOUT
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: AlertDialog(
                            backgroundColor: background,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                            title: const Text(
                              'تسجيل الخروج',
                              style: TextStyle(
                                color: darkBrown,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: const Text(
                              'متأكد إنك تبي تسجل خروج؟',
                              style: TextStyle(
                                color: softBrown,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'إلغاء',
                                  style: TextStyle(
                                    color: softBrown,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);

                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/login',
                                    (route) => false,
                                  );
                                },
                                child: const Text(
                                  'تسجيل الخروج',
                                  style: TextStyle(
                                    color: burgundy,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 54,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF5F5),
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(
                        color: const Color(0xFFF1DCDC),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout_rounded,
                          color: burgundy,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'تسجيل الخروج',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: burgundy,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                const Center(
                  child: Column(
                    children: [
                      Text(
                        'لمحة',
                        style: TextStyle(
                          fontFamily: 'Rakkas',
                          fontSize: 23,
                          color: burgundy,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'اعرف قبل ما تروح',
                        style: TextStyle(
                          fontSize: 10,
                          color: softBrown,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'الإصدار 1.0.0',
                        style: TextStyle(
                          fontSize: 9,
                          color: Color(0xFFB3A69E),
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

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// INFORMATION ROW
class _AccountRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _AccountRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    const Color cream = Color(0xFFF8F3EC);
    const Color burgundy = Color(0xFF6D2536);
    const Color darkBrown = Color(0xFF49372E);
    const Color softBrown = Color(0xFF796A61);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 14,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: cream,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: burgundy,
              size: 21,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    color: softBrown,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: darkBrown,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// SETTINGS ROW
class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String trailingText;

  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    const Color cream = Color(0xFFF8F3EC);
    const Color burgundy = Color(0xFF6D2536);
    const Color darkBrown = Color(0xFF49372E);
    const Color softBrown = Color(0xFF796A61);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 13,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: cream,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: burgundy,
              size: 21,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: darkBrown,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: softBrown,
                  ),
                ),
              ],
            ),
          ),

          Text(
            trailingText,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: burgundy,
            ),
          ),

          const SizedBox(width: 4),

          const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 13,
            color: softBrown,
          ),
        ],
      ),
    );
  }
}

// MENU ROW
class _MenuRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuRow({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color cream = Color(0xFFF8F3EC);
    const Color burgundy = Color(0xFF6D2536);
    const Color darkBrown = Color(0xFF49372E);
    const Color softBrown = Color(0xFF796A61);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 13,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: cream,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: burgundy,
                size: 21,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: darkBrown,
                ),
              ),
            ),

            const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 13,
              color: softBrown,
            ),
          ],
        ),
      ),
    );
  }
}

// DIVIDER
class _DividerLine extends StatelessWidget {
  const _DividerLine();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Divider(
        height: 1,
        thickness: 1,
        color: Color(0xFFF2ECE8),
      ),
    );
  }
}