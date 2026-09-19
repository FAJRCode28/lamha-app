import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../home/home_page.dart';
import '../signup/signup_page.dart';
import '../../../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final auth = AuthService();
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;

  static const burgundy = Color(0xFF6D2536);
  static const darkBrown = Color(0xFF49372E);
  static const softBrown = Color(0xFF796A61);
  static const cream = Color(0xFFF8F3EC);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    try {
      await auth.login(
        emailController.text.trim(),
        passwordController.text,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'تعذر تسجيل الدخول: $error',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildBackground(),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  22,
                  65,
                  22,
                  25,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    _buildCard(),
                    _buildLoginIcon(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // Background
  // =========================

  Widget _buildBackground() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/login_background.png',
          fit: BoxFit.cover,
        ),

        Container(
          color: Colors.black.withOpacity(0.07),
        ),

        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.04),
                Colors.black.withOpacity(0.16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // =========================
  // Floating Login Icon
  // =========================

  Widget _buildLoginIcon() {
    return Positioned(
      top: -42,
      child: Container(
        width: 84,
        height: 84,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: cream.withOpacity(0.95),
          border: Border.all(
            color: Colors.white.withOpacity(0.90),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: burgundy.withOpacity(0.25),
              blurRadius: 22,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Icon(
          Icons.login_rounded,
          size: 38,
          color: burgundy,
        ),
      )
          .animate()
          .fadeIn(
            duration: 450.ms,
          )
          .scale(
            begin: const Offset(0.70, 0.70),
            end: const Offset(1, 1),
            duration: 550.ms,
            curve: Curves.easeOutBack,
          )
          .then()
          .moveY(
            begin: 0,
            end: -5,
            duration: 900.ms,
            curve: Curves.easeInOut,
          )
          .then()
          .moveY(
            begin: -5,
            end: 0,
            duration: 900.ms,
            curve: Curves.easeInOut,
          ),
    );
  }

  // =========================
  // Glass Card
  // =========================

  Widget _buildCard() {
    return ClipRRect(
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
            58,
            24,
            24,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.30),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: Colors.white.withOpacity(0.60),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 28,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _buildHeader(),

                const SizedBox(height: 26),

                _animated(
                  _buildEmailField(),
                  220,
                ),

                const SizedBox(height: 14),

                _animated(
                  _buildPasswordField(),
                  300,
                ),

                const SizedBox(height: 24),

                _animated(
                  _buildLoginButton(),
                  380,
                ),

                const SizedBox(height: 16),

                _animated(
                  _buildSignupLink(),
                  450,
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          duration: 500.ms,
        )
        .slideY(
          begin: 0.08,
          end: 0,
          duration: 550.ms,
          curve: Curves.easeOut,
        );
  }

  // =========================
  // Header
  // =========================

  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          'لمحة',
          style: TextStyle(
            fontFamily: 'Rakkas',
            fontSize: 42,
            color: darkBrown,
          ),
        ),

        const SizedBox(height: 3),

        const Text(
          'أهلًا بعودتك',
          style: TextStyle(
            fontFamily: 'Amiri',
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: darkBrown,
          ),
        ),

        const SizedBox(height: 2),

        const Text(
          'سجّل دخولك وكمل لمحتك',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Amiri',
            fontSize: 15,
            color: softBrown,
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(
          delay: 100.ms,
          duration: 450.ms,
        )
        .slideY(
          begin: 0.15,
          end: 0,
          delay: 100.ms,
          duration: 450.ms,
        );
  }

  // =========================
  // Email
  // =========================

  Widget _buildEmailField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      textDirection: TextDirection.ltr,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
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
      decoration: _inputDecoration(
        hint: 'البريد الإلكتروني',
        icon: Icons.email_outlined,
      ),
    );
  }

  // =========================
  // Password
  // =========================

  Widget _buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: hidePassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'كلمة المرور مطلوبة';
        }

        return null;
      },
      style: const TextStyle(
        color: darkBrown,
        fontSize: 16,
      ),
      decoration: _inputDecoration(
        hint: 'كلمة المرور',
        icon: Icons.lock_outline_rounded,
      ).copyWith(
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              hidePassword = !hidePassword;
            });
          },
          icon: Icon(
            hidePassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: darkBrown,
          ),
        ),
      ),
    );
  }

  // =========================
  // Login Button
  // =========================

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: login,
        icon: const Icon(
          Icons.login_rounded,
          size: 19,
        ),
        label: const Text(
          'سجّل دخولك',
          style: TextStyle(
            fontFamily: 'Amiri',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: burgundy,
          foregroundColor: cream,
          elevation: 4,
          shadowColor: burgundy.withOpacity(0.25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
      ),
    );
  }

  // =========================
  // Signup Link
  // =========================

  Widget _buildSignupLink() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'ما عندك حساب؟',
            style: TextStyle(
              fontFamily: 'Amiri',
              fontSize: 15,
              color: darkBrown,
            ),
          ),

          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const SignupPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.person_add_alt_1_rounded,
              size: 16,
            ),
            label: const Text(
              'إنشاء حساب',
              style: TextStyle(
                fontFamily: 'Amiri',
                fontWeight: FontWeight.bold,
              ),
            ),
            style: TextButton.styleFrom(
              foregroundColor: burgundy,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // Animation
  // =========================

  Widget _animated(
    Widget child,
    int delay,
  ) {
    return child
        .animate()
        .fadeIn(
          delay: delay.ms,
          duration: 350.ms,
        )
        .slideY(
          begin: 0.12,
          end: 0,
          delay: delay.ms,
          duration: 350.ms,
          curve: Curves.easeOut,
        );
  }

  // =========================
  // Field Style
  // =========================

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintTextDirection: TextDirection.rtl,

      hintStyle: const TextStyle(
        fontFamily: 'Amiri',
        color: softBrown,
      ),

      errorStyle: const TextStyle(
        fontFamily: 'Amiri',
        fontSize: 13,
      ),

      prefixIcon: Icon(
        icon,
        color: darkBrown,
      ),

      filled: true,
      fillColor: Colors.white.withOpacity(0.34),

      enabledBorder: _border(
        Colors.white.withOpacity(0.65),
      ),

      focusedBorder: _border(
        burgundy,
        width: 1.3,
      ),

      errorBorder: _border(
        Colors.red,
      ),

      focusedErrorBorder: _border(
        Colors.red,
        width: 1.3,
      ),
    );
  }

  OutlineInputBorder _border(
    Color color, {
    double width = 1,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(17),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }
}