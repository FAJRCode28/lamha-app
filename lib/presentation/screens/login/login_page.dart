import 'dart:ui';
import 'package:flutter/material.dart';
import '../home/home_page.dart';
import '../signup/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    if (formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
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

          // =========================
          // Main Content
          // =========================
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
                        26,
                        24,
                        22,
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
                              width: 48,
                              height: 56,
                              fit: BoxFit.contain,
                              color: darkBrown,
                            ),

                            const SizedBox(height: 6),

                            const Text(
                              'لمحة',
                              style: TextStyle(
                                fontFamily: 'Rakkas',
                                fontSize: 48,
                                fontWeight: FontWeight.w400,
                                color: darkBrown,
                              ),
                            ),

                            const SizedBox(height: 2),

                            const Text(
                              'أهلًا بك',
                              style: TextStyle(
                                fontFamily: 'Amiri',
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: darkBrown,
                              ),
                            ),

                            const SizedBox(height: 2),

                            const Text(
                              'سجّل دخولك واكتشف وجهتك القادمة',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Amiri',
                                fontSize: 16,
                                color: Color(0xFF66564D),
                              ),
                            ),

                            const SizedBox(height: 24),

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

                              decoration: InputDecoration(
                                hintText: 'البريد الإلكتروني',
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
                                  Icons.email_outlined,
                                  color: darkBrown,
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

                            const SizedBox(height: 14),

                            // =========================
                            // Password
                            // =========================
                            TextFormField(
                              controller: passwordController,
                              obscureText: hidePassword,

                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty) {
                                  return 'كلمة المرور مطلوبة';
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

                            const SizedBox(height: 22),

                            // =========================
                            // Login Button
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
                                  onTap: login,
                                  borderRadius:
                                      BorderRadius.circular(17),
                                  child: const Center(
                                    child: Text(
                                      'سجّل دخولك',
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

                            const SizedBox(height: 16),

                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                mainAxisSize:
                                    MainAxisSize.min,
                                children: [
                                  const Text(
                                    'ما عندك حساب؟',
                                    style: TextStyle(
                                      fontFamily: 'Amiri',
                                      fontSize: 15,
                                      color: darkBrown,
                                    ),
                                  ),

                                  const SizedBox(width: 4),

                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupPage(),
                                        ),
                                      );
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
                                      'إنشاء حساب',
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
}