import 'package:flutter/material.dart';

import '../../../services/auth_service.dart';
import '../suggest_place/suggest_place_page.dart';
import '../../widgets/app_colors.dart';
import '../../widgets/gender_choice.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final auth = AuthService();

  bool notificationsEnabled = true;
  bool isLoadingProfile = true;

  String userName = '';
  String userEmail = '';
  String gender = 'female';
  String city = '';
  List<String> interests = [];

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      final profile = await auth.getProfile();

      if (!mounted) return;

      setState(() {
        if (profile != null) {
          userName = profile['name']?.toString() ?? '';
          userEmail =
              profile['email']?.toString() ??
              auth.supa.currentUser?.email ??
              '';
          gender = profile['gender']?.toString() ?? 'female';
          city = profile['city']?.toString() ?? '';
          notificationsEnabled =
              profile['notifications_enabled'] as bool? ?? true;

          final savedInterests =
              profile['interests']?.toString() ?? '';

          interests = savedInterests.isEmpty
              ? []
              : savedInterests
                  .split(',')
                  .where((item) => item.trim().isNotEmpty)
                  .map((item) => item.trim())
                  .toList();
        }

        isLoadingProfile = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        isLoadingProfile = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'تعذر تحميل بيانات الحساب: $error',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  Future<void> editProfile() async {
    final nameController = TextEditingController(
      text: userName,
    );

    String selectedGender = gender;
    bool isSaving = false;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (_, setDialogState) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                backgroundColor: AppColors.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
                titlePadding: const EdgeInsets.fromLTRB(
                  22,
                  22,
                  22,
                  0,
                ),
                contentPadding: const EdgeInsets.fromLTRB(
                  22,
                  20,
                  22,
                  10,
                ),
                actionsPadding: const EdgeInsets.fromLTRB(
                  22,
                  8,
                  22,
                  20,
                ),

                title: const Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.cream,
                      child: Icon(
                        Icons.edit_outlined,
                        color: AppColors.burgundy,
                        size: 20,
                      ),
                    ),

                    SizedBox(width: 10),

                    Text(
                      'تعديل الملف الشخصي',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBrown,
                      ),
                    ),
                  ],
                ),

                content: SizedBox(
                  width: 380,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'الاسم',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkBrown,
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: 'اكتب اسمك',
                          prefixIcon: const Icon(
                            Icons.person_outline_rounded,
                            color: AppColors.burgundy,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: Color(0xFFE7DDD6),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: AppColors.burgundy,
                              width: 1.4,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'الجنس',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkBrown,
                        ),
                      ),

                      const SizedBox(height: 9),

                      Row(
                        children: [
                          GenderChoice(
                            title: 'أنثى',
                            icon: Icons.female_rounded,
                            selected:
                                selectedGender == 'female',
                            onTap: () {
                              if (isSaving) return;

                              setDialogState(() {
                                selectedGender = 'female';
                              });
                            },
                          ),

                          const SizedBox(width: 10),

                          GenderChoice(
                            title: 'ذكر',
                            icon: Icons.male_rounded,
                            selected:
                                selectedGender == 'male',
                            onTap: () {
                              if (isSaving) return;

                              setDialogState(() {
                                selectedGender = 'male';
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                actions: [
                  TextButton(
                    onPressed: isSaving
                        ? null
                        : () {
                            Navigator.pop(dialogContext);
                          },
                    child: const Text(
                      'إلغاء',
                      style: TextStyle(
                        color: AppColors.softBrown,
                      ),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: isSaving
                        ? null
                        : () async {
                            final newName =
                                nameController.text.trim();

                            if (newName.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'اكتب الاسم أول',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );

                              return;
                            }

                            setDialogState(() {
                              isSaving = true;
                            });

                            try {
                              await auth.updateProfile(
                                newName,
                                selectedGender,
                              );

                              if (!mounted || !dialogContext.mounted) {
                                return;
                              }

                              Navigator.pop(dialogContext);

                              await loadProfile();

                              if (!mounted) return;

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'تم تحديث الملف الشخصي بنجاح',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            } catch (error) {
                              setDialogState(() {
                                isSaving = false;
                              });

                              if (!mounted) return;

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'تعذر حفظ التغييرات: $error',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.burgundy,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                    child: isSaving
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'حفظ التغييرات',
                            style: TextStyle(
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
    );

    nameController.dispose();
  }

  Future<void> chooseCity() async {
    final cities = [
      'جدة',
      'مكة المكرمة',
      'المدينة المنورة',
      'الرياض',
      'الطائف',
      'أبها',
      'الدمام',
      'الخبر',
      'تبوك',
      'جازان',
    ];

    final selectedCity = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 45,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD8CCC5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'اختر مدينتك',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'حدد المدينة اللي تناسبك',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.softBrown,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: cities.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                        color: Color(0xFFF0E8E3),
                      ),
                      itemBuilder: (context, index) {
                        final currentCity = cities[index];
                        final selected = currentCity == city;

                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.cream,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.location_on_outlined,
                              color: AppColors.burgundy,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            currentCity,
                            style: const TextStyle(
                              color: AppColors.darkBrown,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: selected
                              ? const Icon(
                                  Icons.check_circle_rounded,
                                  color: AppColors.burgundy,
                                )
                              : null,
                          onTap: () {
                            Navigator.pop(context, currentCity);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (selectedCity == null) return;

    try {
      await auth.updateCity(selectedCity);

      if (!mounted) return;

      setState(() {
        city = selectedCity;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'تم تغيير المدينة إلى $selectedCity',
            textAlign: TextAlign.center,
          ),
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'تعذر تحديث المدينة: $error',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  Future<void> chooseInterests() async {
    final availableInterests = [
      'مطاعم',
      'مقاهي',
      'فعاليات',
      'طبيعة',
      'معالم',
    ];

    final selectedInterests = List<String>.from(interests);
    bool isSaving = false;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (_, setDialogState) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                backgroundColor: AppColors.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
                title: const Text(
                  'اختر اهتماماتك',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBrown,
                  ),
                ),
                content: SizedBox(
                  width: 380,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'تقدر تختار أكثر من اهتمام',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.softBrown,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: availableInterests.map((item) {
                          final selected =
                              selectedInterests.contains(item);

                          return FilterChip(
                            label: Text(item),
                            selected: selected,
                            selectedColor:
                                AppColors.burgundy.withOpacity(0.12),
                            checkmarkColor: AppColors.burgundy,
                            side: BorderSide(
                              color: selected
                                  ? AppColors.burgundy
                                  : const Color(0xFFE7DDD6),
                            ),
                            labelStyle: TextStyle(
                              color: selected
                                  ? AppColors.burgundy
                                  : AppColors.darkBrown,
                              fontWeight: selected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                            ),
                            onSelected: isSaving
                                ? null
                                : (value) {
                                    setDialogState(() {
                                      if (value) {
                                        selectedInterests.add(item);
                                      } else {
                                        selectedInterests.remove(item);
                                      }
                                    });
                                  },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: isSaving
                        ? null
                        : () {
                            Navigator.pop(dialogContext);
                          },
                    child: const Text(
                      'إلغاء',
                      style: TextStyle(
                        color: AppColors.softBrown,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: isSaving
                        ? null
                        : () async {
                            setDialogState(() {
                              isSaving = true;
                            });

                            try {
                              await auth.updateInterests(
                                selectedInterests.join(','),
                              );

                              if (!mounted || !dialogContext.mounted) {
                                return;
                              }

                              setState(() {
                                interests =
                                    List<String>.from(selectedInterests);
                              });

                              Navigator.pop(dialogContext);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'تم حفظ اهتماماتك بنجاح',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            } catch (error) {
                              setDialogState(() {
                                isSaving = false;
                              });

                              if (!mounted) return;

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'تعذر حفظ الاهتمامات: $error',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.burgundy,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                    child: isSaving
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'حفظ',
                            style: TextStyle(
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
    );
  }

  String get profileImage {
    if (gender == 'male') {
      return 'assets/images/boy_profile.png';
    }

    return 'assets/images/girl_profile.png';
  }

  Future<void> logout() async {
    try {
      await auth.logout();

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (route) => false,
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'تعذر تسجيل الخروج: $error',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              20,
              18,
              20,
              30,
            ),
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
                            color: const Color(0xFFEDE5DF),
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.darkBrown,
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
                        color: AppColors.darkBrown,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // PROFILE CARD
                _buildProfileCard(),

                const SizedBox(height: 28),

                // MY INFO
                const Text(
                  'معلوماتي',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBrown,
                  ),
                ),

                const SizedBox(height: 11),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: const Color(0xFFEDE5DF),
                    ),
                  ),
                  child: Column(
                    children: [
                      _AccountRow(
                        icon: Icons.person_outline_rounded,
                        title: 'الاسم',
                        value: isLoadingProfile
                            ? 'جاري التحميل...'
                            : userName,
                      ),

                      const _DividerLine(),

                      _AccountRow(
                        icon: Icons.email_outlined,
                        title: 'البريد الإلكتروني',
                        value: isLoadingProfile
                            ? 'جاري التحميل...'
                            : userEmail,
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
                    color: AppColors.darkBrown,
                  ),
                ),

                const SizedBox(height: 11),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: const Color(0xFFEDE5DF),
                    ),
                  ),
                  child: Column(
                    children: [
                      _SettingsRow(
                        icon: Icons.location_city_outlined,
                        title: 'المدينة',
                        subtitle: 'حدد مدينتك',
                        trailingText: city.isEmpty ? 'اختيار' : city,
                        onTap: chooseCity,
                      ),

                      const _DividerLine(),

                      _SettingsRow(
                        icon: Icons.favorite_border_rounded,
                        title: 'اهتماماتي',
                        subtitle: 'الأماكن اللي تفضلها',
                        trailingText: interests.isEmpty
                            ? 'اختيار'
                            : '${interests.length} مختارة',
                        onTap: chooseInterests,
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
                                color: AppColors.cream,
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.notifications_none_rounded,
                                color: AppColors.burgundy,
                                size: 21,
                              ),
                            ),

                            const SizedBox(width: 12),

                            const Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'الإشعارات',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.darkBrown,
                                    ),
                                  ),

                                  SizedBox(height: 2),

                                  Text(
                                    'تنبيهات الحجوزات والتحديثات',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.softBrown,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Switch(
                              value: notificationsEnabled,
                              activeThumbColor: Colors.white,
                              activeTrackColor:
                                  AppColors.burgundy,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor:
                                  const Color(0xFFD8CCC5),
                              onChanged: (value) async {
                                final oldValue = notificationsEnabled;

                                setState(() {
                                  notificationsEnabled = value;
                                });

                                try {
                                  await auth.updateNotifications(value);

                                  if (!context.mounted) return;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        value
                                            ? 'تم تشغيل الإشعارات'
                                            : 'تم إيقاف الإشعارات',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                } catch (error) {
                                  if (!context.mounted) return;

                                  setState(() {
                                    notificationsEnabled = oldValue;
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'تعذر تحديث الإشعارات: $error',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }
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
                        color: AppColors.darkBrown,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      'LAMHA',
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 1.5,
                        color:
                            AppColors.softBrown.withOpacity(0.75),
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
                      color: const Color(0xFFEDE5DF),
                    ),
                  ),
                  child: Column(
                    children: [
                      _MenuRow(
                        icon:
                            Icons.add_location_alt_outlined,
                        title: 'اقترح مكان',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SuggestPlacePage(),
                            ),
                          );
                        },
                      ),

                      const _DividerLine(),

                      _MenuRow(
                        icon: Icons.info_outline_rounded,
                        title: 'عن لمحة',
                        onTap: () {
                          showAboutLamha();
                        },
                      ),

                      const _DividerLine(),

                      _MenuRow(
                        icon:
                            Icons.chat_bubble_outline_rounded,
                        title: 'تواصل معنا',
                        onTap: () {
                          showContactLamha();
                        },
                      ),

                      const _DividerLine(),

                      _MenuRow(
                        icon: Icons.shield_outlined,
                        title: 'سياسة الخصوصية',
                        onTap: () {
                          showPrivacyPolicy();
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
                            backgroundColor:
                                AppColors.background,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(22),
                            ),
                            title: const Text(
                              'تسجيل الخروج',
                              style: TextStyle(
                                color: AppColors.darkBrown,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: const Text(
                              'متأكد إنك تبي تسجل خروج؟',
                              style: TextStyle(
                                color: AppColors.softBrown,
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
                                    color: AppColors.softBrown,
                                  ),
                                ),
                              ),

                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await logout();
                                },
                                child: const Text(
                                  'تسجيل الخروج',
                                  style: TextStyle(
                                    color: AppColors.burgundy,
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
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout_rounded,
                          color: AppColors.burgundy,
                          size: 20,
                        ),

                        SizedBox(width: 8),

                        Text(
                          'تسجيل الخروج',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.burgundy,
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
                          color: AppColors.burgundy,
                        ),
                      ),

                      SizedBox(height: 2),

                      Text(
                        'اعرف قبل ما تروح',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.softBrown,
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

  // PROFILE CARD
  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.burgundy,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.burgundy.withOpacity(0.15),
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
                width: 82,
                height: 82,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8F3EC),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: isLoadingProfile
                        ? const Icon(
                            Icons.person_outline_rounded,
                            color: AppColors.burgundy,
                            size: 36,
                          )
                        : Image.asset(
                            profileImage,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      isLoadingProfile
                          ? 'جاري التحميل...'
                          : userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      isLoadingProfile ? '' : userEmail,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color:
                            Colors.white.withOpacity(0.75),
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color:
                            Colors.white.withOpacity(0.13),
                        borderRadius:
                            BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              Colors.white.withOpacity(0.15),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                            size: 14,
                          ),

                          SizedBox(width: 4),

                          Text(
                            'السعودية',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 19),

          SizedBox(
            width: double.infinity,
            height: 45,
            child: OutlinedButton.icon(
              onPressed: editProfile,
              style: OutlinedButton.styleFrom(
                backgroundColor:
                    Colors.white.withOpacity(0.08),
                side: BorderSide(
                  color: Colors.white.withOpacity(0.45),
                ),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
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
    );
  }

  // ABOUT LAMHA
  void showAboutLamha() {
    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: AppColors.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            title: const Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.burgundy,
                ),
                SizedBox(width: 8),
                Text(
                  'عن لمحة',
                  style: TextStyle(
                    color: AppColors.darkBrown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: const Text(
              'لمحة تطبيق يساعدك تعرف المكان قبل ما تروح.\n\n'
              'تقدر من خلاله تشوف أهم التفاصيل عن الوجهات والأماكن مثل حالة الزحام، المواقف، أوقات العمل، ملاءمة المكان للعائلات، والفعاليات أو الأنشطة المتوفرة.\n\n'
              'هدف لمحة هو مساعدتك تختار المكان المناسب لك بشكل أسرع وأسهل قبل ما تبدأ مشوارك.\n\n'
              'اعرف قبل ما تروح.',
              style: TextStyle(
                color: AppColors.softBrown,
                fontSize: 13,
                height: 1.7,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'حسنًا',
                  style: TextStyle(
                    color: AppColors.burgundy,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // CONTACT
  void showContactLamha() {
    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: AppColors.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            title: const Row(
              children: [
                Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: AppColors.burgundy,
                ),
                SizedBox(width: 8),
                Text(
                  'تواصل معنا',
                  style: TextStyle(
                    color: AppColors.darkBrown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: const Text(
              'نسعد دائمًا بسماع رأيك واقتراحاتك.\n\n'
              'إذا واجهتك مشكلة أثناء استخدام لمحة، أو عندك اقتراح يساعدنا نحسن تجربتك، تقدر تتواصل معنا.\n\n'
              'كما يمكنك استخدام خيار «اقترح مكان» إذا كنت تعرف وجهة مميزة وتحب إضافتها إلى لمحة.',
              style: TextStyle(
                color: AppColors.softBrown,
                fontSize: 13,
                height: 1.7,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'حسنًا',
                  style: TextStyle(
                    color: AppColors.burgundy,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // PRIVACY
  void showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: AppColors.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            title: const Row(
              children: [
                Icon(
                  Icons.shield_outlined,
                  color: AppColors.burgundy,
                ),
                SizedBox(width: 8),
                Text(
                  'سياسة الخصوصية',
                  style: TextStyle(
                    color: AppColors.darkBrown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: const SingleChildScrollView(
              child: Text(
                'خصوصيتك مهمة لنا في لمحة.\n\n'
                '• بيانات الحساب:\n'
                'يتم استخدام بيانات الحساب مثل الاسم والبريد الإلكتروني والجنس لتوفير تجربة مناسبة داخل التطبيق.\n\n'
                '• استخدام البيانات:\n'
                'تستخدم البيانات لتشغيل خصائص التطبيق وتحسين تجربة المستخدم، ولا يتم عرض معلومات حسابك الشخصية للمستخدمين الآخرين.\n\n'
                '• الخدمات الخارجية:\n'
                'قد يستخدم التطبيق خدمات خارجية ضرورية لبعض الخصائص، مثل خدمات تسجيل الدخول والخرائط.\n\n'
                '• حماية الحساب:\n'
                'ننصح بالمحافظة على سرية كلمة المرور وعدم مشاركتها مع أي شخص.\n\n'
                '• التحكم في بياناتك:\n'
                'يمكنك تعديل بعض بيانات ملفك الشخصي من صفحة حسابي وتسجيل الخروج من حسابك في أي وقت.\n\n'
                'قد يتم تحديث هذه السياسة عند إضافة خصائص جديدة إلى لمحة.',
                style: TextStyle(
                  color: AppColors.softBrown,
                  fontSize: 13,
                  height: 1.7,
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'فهمت',
                  style: TextStyle(
                    color: AppColors.burgundy,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showMessage(
    BuildContext context,
    String message,
  ) {
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
              color: AppColors.cream,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.burgundy,
              size: 21,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.softBrown,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkBrown,
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
  final VoidCallback? onTap;

  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailingText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
                color: AppColors.cream,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: AppColors.burgundy,
                size: 21,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkBrown,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.softBrown,
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
                color: AppColors.burgundy,
              ),
            ),

            const SizedBox(width: 4),

            const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 13,
              color: AppColors.softBrown,
            ),
          ],
        ),
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
                color: AppColors.cream,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: AppColors.burgundy,
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
                  color: AppColors.darkBrown,
                ),
              ),
            ),

            const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 13,
              color: AppColors.softBrown,
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