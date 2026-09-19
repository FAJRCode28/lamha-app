import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../services/auth_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final auth = AuthService();
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  String gender = 'female';
  String passwordStrength = '';

  static const burgundy = Color(0xFF6D2536);
  static const darkBrown = Color(0xFF49372E);
  static const softBrown = Color(0xFF796A61);
  static const cream = Color(0xFFF8F3EC);

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  void checkPassword(String value) {
    setState(() {
      if (value.isEmpty) {
        passwordStrength = '';
      } else if (value.length < 6) {
        passwordStrength = 'ضعيفة';
      } else if (value.length < 9) {
        passwordStrength = 'متوسطة';
      } else {
        passwordStrength = 'قوية';
      }
    });
  }

  Color get strengthColor {
    if (passwordStrength == 'ضعيفة') {
      return Colors.red;
    }

    if (passwordStrength == 'متوسطة') {
      return Colors.orange;
    }

    return const Color(0xFF3E4F3D);
  }

  Future<void> createAccount() async {
    if (!formKey.currentState!.validate()) return;

    try {
      await auth.signup(
        emailController.text.trim(),
        passwordController.text,
        nameController.text.trim(),
        gender,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'تم إنشاء الحساب بنجاح',
            textAlign: TextAlign.center,
          ),
        ),
      );

      Navigator.pop(context);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'تعذر إنشاء الحساب: $error',
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
                    _buildAccountIcon(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // BACKGROUND
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

  // FLOATING ACCOUNT ICON
  Widget _buildAccountIcon() {
    return Positioned(
      top: -42,
      child: Container(
        width: 84,
        height: 84,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: cream.withOpacity(0.95),
          border: Border.all(
            color: Colors.white.withOpacity(0.9),
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(
              Icons.person_outline_rounded,
              size: 38,
              color: burgundy,
            ),

            Positioned(
              right: 15,
              bottom: 15,
              child: Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: burgundy,
                ),
                child: const Icon(
                  Icons.add_rounded,
                  size: 17,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      )
          .animate()
          .fadeIn(
            duration: 450.ms,
          )
          .scale(
            begin: const Offset(0.7, 0.7),
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

  // GLASS CARD
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
            55,
            24,
            22,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.30),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: Colors.white.withOpacity(0.60),
            ),
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _buildHeader(),

                const SizedBox(height: 20),

                _animated(
                  _buildField(
                    controller: nameController,
                    hint: 'الاسم',
                    icon: Icons.person_outline,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'الاسم مطلوب';
                      }

                      return null;
                    },
                  ),
                  200,
                ),

                const SizedBox(height: 12),

                _animated(
                  _buildGenderField(),
                  260,
                ),

                const SizedBox(height: 12),

                _animated(
                  _buildField(
                    controller: emailController,
                    hint: 'البريد الإلكتروني',
                    icon: Icons.email_outlined,
                    keyboardType:
                        TextInputType.emailAddress,
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
                  ),
                  320,
                ),

                const SizedBox(height: 12),

                _animated(
                  _buildPasswordField(
                    controller: passwordController,
                    hint: 'كلمة المرور',
                    hidden: hidePassword,
                    onVisibility: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    onChanged: checkPassword,
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
                  ),
                  380,
                ),

                _buildStrength(),

                const SizedBox(height: 12),

                _animated(
                  _buildPasswordField(
                    controller: confirmController,
                    hint: 'تأكيد كلمة المرور',
                    hidden: hideConfirmPassword,
                    onVisibility: () {
                      setState(() {
                        hideConfirmPassword =
                            !hideConfirmPassword;
                      });
                    },
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
                  ),
                  440,
                ),

                const SizedBox(height: 20),

                _animated(
                  _buildSignupButton(),
                  500,
                ),

                const SizedBox(height: 12),

                _buildLoginLink(),
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

  // HEADER
  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          'لمحة',
          style: TextStyle(
            fontFamily: 'Rakkas',
            fontSize: 39,
            color: darkBrown,
          ),
        ),

        const SizedBox(height: 2),

        const Text(
          'أنشئ حسابك',
          style: TextStyle(
            fontFamily: 'Amiri',
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: darkBrown,
          ),
        ),

        const Text(
          'خلّ لمحتك الأولى تبدأ من هنا',
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
        );
  }

  // NORMAL FIELD
  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textDirection:
          keyboardType == TextInputType.emailAddress
              ? TextDirection.ltr
              : TextDirection.rtl,
      validator: validator,
      style: const TextStyle(
        color: darkBrown,
        fontSize: 16,
      ),
      decoration: _inputDecoration(
        hint: hint,
        icon: icon,
      ),
    );
  }

  // PASSWORD FIELD
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool hidden,
    required VoidCallback onVisibility,
    required String? Function(String?) validator,
    ValueChanged<String>? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: hidden,
      onChanged: onChanged,
      validator: validator,
      style: const TextStyle(
        color: darkBrown,
        fontSize: 16,
      ),
      decoration: _inputDecoration(
        hint: hint,
        icon: Icons.lock_outline,
      ).copyWith(
        suffixIcon: IconButton(
          onPressed: onVisibility,
          icon: Icon(
            hidden
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: darkBrown,
          ),
        ),
      ),
    );
  }

  // GENDER
  Widget _buildGenderField() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      decoration: _fieldBox(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            const Icon(
              Icons.wc_outlined,
              color: darkBrown,
            ),

            const SizedBox(width: 12),

            const Text(
              'الجنس',
              style: TextStyle(
                fontFamily: 'Amiri',
                fontSize: 16,
                color: softBrown,
              ),
            ),

            const Spacer(),

            PopupMenuButton<String>(
              tooltip: '',
              initialValue: gender,
              color: const Color(0xFFF0EFED),
              elevation: 7,
              offset: const Offset(0, 42),
              constraints: const BoxConstraints(
                minWidth: 135,
                maxWidth: 145,
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(15),
              ),
              onSelected: (value) {
                setState(() {
                  gender = value;
                });
              },
              itemBuilder: (_) => [
                _genderItem(
                  'female',
                  'أنثى',
                ),
                _genderItem(
                  'male',
                  'ذكر',
                ),
              ],
              child: Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE9E6E4),
                  borderRadius:
                      BorderRadius.circular(11),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      gender == 'female'
                          ? 'أنثى'
                          : 'ذكر',
                      style: const TextStyle(
                        fontFamily: 'Amiri',
                        fontWeight: FontWeight.bold,
                        color: darkBrown,
                      ),
                    ),

                    const SizedBox(width: 3),

                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18,
                      color: darkBrown,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _genderItem(
    String value,
    String text,
  ) {
    final selected = gender == value;

    return PopupMenuItem<String>(
      value: value,
      height: 40,
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Amiri',
              fontWeight: selected
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: darkBrown,
            ),
          ),

          const Spacer(),

          Container(
            width: 15,
            height: 15,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected
                    ? burgundy
                    : const Color(0xFFBDB8B4),
              ),
            ),
            child: selected
                ? const DecoratedBox(
                    decoration: BoxDecoration(
                      color: burgundy,
                      shape: BoxShape.circle,
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }

  // PASSWORD STRENGTH
  Widget _buildStrength() {
    if (passwordStrength.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(
        top: 7,
      ),
      child: Directionality(
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

            AnimatedSwitcher(
              duration:
                  const Duration(milliseconds: 200),
              child: Text(
                passwordStrength,
                key: ValueKey(passwordStrength),
                style: TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: strengthColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SIGNUP BUTTON
  Widget _buildSignupButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: createAccount,
        icon: const Icon(
          Icons.person_add_alt_1_rounded,
          size: 19,
        ),
        label: const Text(
          'أنشئ حسابك',
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
          shadowColor:
              burgundy.withOpacity(0.25),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(17),
          ),
        ),
      ),
    );
  }

  // LOGIN LINK
  Widget _buildLoginLink() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          const Text(
            'عندك حساب؟',
            style: TextStyle(
              fontFamily: 'Amiri',
              fontSize: 15,
              color: darkBrown,
            ),
          ),

          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.login_rounded,
              size: 16,
            ),
            label: const Text(
              'سجّل دخولك',
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

  // ANIMATION
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

  // FIELD STYLE
  BoxDecoration _fieldBox() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.34),
      borderRadius: BorderRadius.circular(17),
      border: Border.all(
        color: Colors.white.withOpacity(0.65),
      ),
    );
  }

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