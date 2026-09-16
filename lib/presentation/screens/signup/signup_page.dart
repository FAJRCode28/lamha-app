import 'dart:ui';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  String passwordStrength = '';
  Color strengthColor = Colors.transparent;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void checkPasswordStrength(String password) {
    setState(() {
      if (password.isEmpty) {
        passwordStrength = '';
        strengthColor = Colors.transparent;
      } else if (password.length < 6) {
        passwordStrength = 'ضعيفة';
        strengthColor = Colors.red;
      } else if (password.length < 9) {
        passwordStrength = 'متوسطة';
        strengthColor = Colors.orange;
      } else {
        passwordStrength = 'قوية';
        strengthColor = const Color(0xFF3E4F3D);
      }
    });
  }

  void createAccount() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إنشاء الحساب بنجاح'),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color cream = Color(0xFFFFF4E6);
    const Color burgundy = Color(0xFF6D2536);
    const Color darkBrown = Color(0xFF49372E);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // =========================
          // Background
          // =========================
          Image.asset(
            'assets/images/login_background.png',
            fit: BoxFit.cover,
          ),

          Container(
            color: Colors.black.withOpacity(0.06),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.04),
                  Colors.black.withOpacity(0.15),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 24,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 20,
                      sigmaY: 20,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(
                        24,
                        24,
                        24,
                        20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.30),
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.60),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 30,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),

                      // =========================
                      // Form
                      // =========================
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/palm_logo.png',
                              width: 42,
                              height: 48,
                              fit: BoxFit.contain,
                              color: darkBrown,
                            ),

                            const SizedBox(height: 4),

                            const Text(
                              'لمحة',
                              style: TextStyle(
                                fontFamily: 'Rakkas',
                                fontSize: 42,
                                fontWeight: FontWeight.w400,
                                color: darkBrown,
                              ),
                            ),

                            const SizedBox(height: 2),

                            const Text(
                              'أنشئ حسابك',
                              style: TextStyle(
                                fontFamily: 'Amiri',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: darkBrown,
                              ),
                            ),

                            const SizedBox(height: 2),

                            const Text(
                              'ابدأ رحلتك مع لمحة',
                              style: TextStyle(
                                fontFamily: 'Amiri',
                                fontSize: 16,
                                color: Color(0xFF66564D),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // =========================
                            // Name
                            // =========================
                            TextFormField(
                              controller: nameController,
                              textDirection: TextDirection.rtl,

                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty) {
                                  return 'الاسم مطلوب';
                                }

                                return null;
                              },

                              style: const TextStyle(
                                color: darkBrown,
                                fontSize: 16,
                              ),

                              decoration: buildDecoration(
                                hint: 'الاسم',
                                icon: Icons.person_outline,
                                burgundy: burgundy,
                                darkBrown: darkBrown,
                              ),
                            ),

                            const SizedBox(height: 12),

                            // =========================
                            // Email
                            // =========================
                            TextFormField(
                              controller: emailController,
                              keyboardType:
                                  TextInputType.emailAddress,
                              textDirection: TextDirection.ltr,

                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty) {
                                  return 'البريد الإلكتروني مطلوب';
                                }

                                if (!value.contains('@')) {
                                  return 'أدخل بريدًا إلكترونيًا صحيحًا';
                                }

                                return null;
                              },

                              style: const TextStyle(
                                color: darkBrown,
                                fontSize: 16,
                              ),

                              decoration: buildDecoration(
                                hint: 'البريد الإلكتروني',
                                icon: Icons.email_outlined,
                                burgundy: burgundy,
                                darkBrown: darkBrown,
                              ),
                            ),

                            const SizedBox(height: 12),

                            // =========================
                            // Password
                            // =========================
                            TextFormField(
                              controller: passwordController,
                              obscureText: hidePassword,
                              onChanged: checkPasswordStrength,

                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty) {
                                  return 'كلمة المرور مطلوبة';
                                }

                                if (value.length < 6) {
                                  return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                                }

                                return null;
                              },

                              style: const TextStyle(
                                color: darkBrown,
                                fontSize: 16,
                              ),

                              decoration: InputDecoration(
                                hintText: 'كلمة المرور',
                                hintTextDirection:
                                    TextDirection.rtl,

                                hintStyle: const TextStyle(
                                  fontFamily: 'Amiri',
                                  color: Color(0xFF796A61),
                                ),

                                errorStyle: const TextStyle(
                                  fontFamily: 'Amiri',
                                  fontSize: 13,
                                  color: Colors.red,
                                ),

                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: darkBrown,
                                ),

                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePassword =
                                          !hidePassword;
                                    });
                                  },
                                  icon: Icon(
                                    hidePassword
                                        ? Icons
                                            .visibility_off_outlined
                                        : Icons
                                            .visibility_outlined,
                                    color: darkBrown,
                                  ),
                                ),

                                filled: true,
                                fillColor:
                                    Colors.white.withOpacity(0.34),

                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(17),
                                  borderSide: BorderSide(
                                    color: Colors.white
                                        .withOpacity(0.65),
                                  ),
                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(17),
                                  borderSide: const BorderSide(
                                    color: burgundy,
                                    width: 1.3,
                                  ),
                                ),

                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(17),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.3,
                                  ),
                                ),

                                focusedErrorBorder:
                                    OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(17),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),

                            if (passwordStrength.isNotEmpty) ...[
                              const SizedBox(height: 7),

                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Row(
                                  children: [
                                    const Text(
                                      'قوة كلمة المرور: ',
                                      style: TextStyle(
                                        fontFamily: 'Amiri',
                                        fontSize: 14,
                                        color: darkBrown,
                                      ),
                                    ),
                                    Text(
                                      passwordStrength,
                                      style: TextStyle(
                                        fontFamily: 'Amiri',
                                        fontSize: 14,
                                        fontWeight:
                                            FontWeight.bold,
                                        color: strengthColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],

                            const SizedBox(height: 12),

                            // =========================
                            // Confirm Password
                            // =========================
                            TextFormField(
                              controller:
                                  confirmPasswordController,
                              obscureText:
                                  hideConfirmPassword,

                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty) {
                                  return 'تأكيد كلمة المرور مطلوب';
                                }

                                if (value !=
                                    passwordController.text) {
                                  return 'كلمتا المرور غير متطابقتين';
                                }

                                return null;
                              },

                              style: const TextStyle(
                                color: darkBrown,
                                fontSize: 16,
                              ),

                              decoration: InputDecoration(
                                hintText: 'تأكيد كلمة المرور',
                                hintTextDirection:
                                    TextDirection.rtl,

                                hintStyle: const TextStyle(
                                  fontFamily: 'Amiri',
                                  color: Color(0xFF796A61),
                                ),

                                errorStyle: const TextStyle(
                                  fontFamily: 'Amiri',
                                  fontSize: 13,
                                  color: Colors.red,
                                ),

                                prefixIcon: const Icon(
                                  Icons.lock_reset_outlined,
                                  color: darkBrown,
                                ),

                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hideConfirmPassword =
                                          !hideConfirmPassword;
                                    });
                                  },
                                  icon: Icon(
                                    hideConfirmPassword
                                        ? Icons
                                            .visibility_off_outlined
                                        : Icons
                                            .visibility_outlined,
                                    color: darkBrown,
                                  ),
                                ),

                                filled: true,
                                fillColor:
                                    Colors.white.withOpacity(0.34),

                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(17),
                                  borderSide: BorderSide(
                                    color: Colors.white
                                        .withOpacity(0.65),
                                  ),
                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(17),
                                  borderSide: const BorderSide(
                                    color: burgundy,
                                    width: 1.3,
                                  ),
                                ),

                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(17),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.3,
                                  ),
                                ),

                                focusedErrorBorder:
                                    OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(17),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // =========================
                            // Create Account
                            // =========================
                            Container(
                              width: double.infinity,
                              height: 52,
                              decoration: BoxDecoration(
                                color: burgundy,
                                borderRadius:
                                    BorderRadius.circular(17),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        burgundy.withOpacity(0.16),
                                    blurRadius: 9,
                                    offset:
                                        const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: createAccount,
                                  borderRadius:
                                      BorderRadius.circular(17),
                                  child: const Center(
                                    child: Text(
                                      'أنشئ حسابك',
                                      style: TextStyle(
                                        fontFamily: 'Amiri',
                                        fontSize: 18,
                                        fontWeight:
                                            FontWeight.bold,
                                        color: cream,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 15),

                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                mainAxisSize:
                                    MainAxisSize.min,
                                children: [
                                  const Text(
                                    'عندك حساب؟',
                                    style: TextStyle(
                                      fontFamily: 'Amiri',
                                      fontSize: 15,
                                      color: darkBrown,
                                    ),
                                  ),

                                  const SizedBox(width: 4),

                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style:
                                        TextButton.styleFrom(
                                      padding:
                                          const EdgeInsets
                                              .symmetric(
                                        horizontal: 4,
                                      ),
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize
                                              .shrinkWrap,
                                    ),
                                    child: const Text(
                                      'سجّل دخولك',
                                      style: TextStyle(
                                        fontFamily: 'Amiri',
                                        fontSize: 15,
                                        fontWeight:
                                            FontWeight.bold,
                                        color: burgundy,
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // Shared Field Design
  // =========================
  InputDecoration buildDecoration({
    required String hint,
    required IconData icon,
    required Color burgundy,
    required Color darkBrown,
  }) {
    return InputDecoration(
      hintText: hint,
      hintTextDirection: TextDirection.rtl,

      hintStyle: const TextStyle(
        fontFamily: 'Amiri',
        color: Color(0xFF796A61),
      ),

      errorStyle: const TextStyle(
        fontFamily: 'Amiri',
        fontSize: 13,
        color: Colors.red,
      ),

      prefixIcon: Icon(
        icon,
        color: darkBrown,
      ),

      filled: true,
      fillColor: Colors.white.withOpacity(0.34),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.65),
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: BorderSide(
          color: burgundy,
          width: 1.3,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.3,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
    );
  }
}