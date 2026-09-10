import 'package:flutter/material.dart';
import '../signup/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  void login() {
    setState(() {
      emailError = null;
      passwordError = null;

      // التحقق من البريد الإلكتروني
      if (emailController.text.isEmpty) {
        emailError = 'يرجى إدخال البريد الإلكتروني';
      } else if (!emailController.text.contains('@')) {
        emailError = 'البريد الإلكتروني غير صحيح';
      }

      // التحقق من كلمة المرور
      if (passwordController.text.isEmpty) {
        passwordError = 'يرجى إدخال كلمة المرور';
      } else if (passwordController.text.length < 6) {
        passwordError = 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,

      child: Scaffold(
        backgroundColor: const Color(0xffF8F3EC),

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 30,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // اللوقو
                Center(
                  child: Image.asset(
                    'assets/images/lamha_logo.png',
                    width: 120,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'لمحة',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff6D2536),
                  ),
                ),

                const SizedBox(height: 3),

                const Text(
                  'LAMHA',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    letterSpacing: 4,
                    color: Color(0xffA67C7C),
                  ),
                ),

                const SizedBox(height: 25),

                // كرت تسجيل الدخول
                Container(
                  padding: const EdgeInsets.all(22),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),

                    border: Border.all(
                      color: const Color(0xffE8D9D0),
                    ),

                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x246D2536),
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'مرحباً بعودتك',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff6D2536),
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        'سجل دخولك واعرف قبل ما تروح',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff9A7A76),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // البريد الإلكتروني
                      const Text(
                        'البريد الإلكتروني',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff6D2536),
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        controller: emailController,
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.emailAddress,

                        decoration: InputDecoration(
                          hintText: 'example@email.com',
                          errorText: emailError,

                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Color(0xff6D2536),
                          ),

                          filled: true,
                          fillColor: const Color(0xffFFFDFC),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),

                            borderSide: BorderSide(
                              color: emailError != null
                                  ? Colors.red
                                  : const Color(0xffE5D5CC),
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),

                            borderSide: const BorderSide(
                              color: Color(0xff6D2536),
                              width: 1.5,
                            ),
                          ),

                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),

                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),

                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),

                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // كلمة المرور
                      const Text(
                        'كلمة المرور',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff6D2536),
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        controller: passwordController,
                        textAlign: TextAlign.right,
                        obscureText: true,

                        decoration: InputDecoration(
                          hintText: 'أدخل كلمة المرور',
                          errorText: passwordError,

                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Color(0xff6D2536),
                          ),

                          suffixIcon: const Icon(
                            Icons.visibility_off_outlined,
                            color: Color(0xffA78B8B),
                          ),

                          filled: true,
                          fillColor: const Color(0xffFFFDFC),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),

                            borderSide: BorderSide(
                              color: passwordError != null
                                  ? Colors.red
                                  : const Color(0xffE5D5CC),
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),

                            borderSide: const BorderSide(
                              color: Color(0xff6D2536),
                              width: 1.5,
                            ),
                          ),

                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),

                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),

                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),

                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 5),

                      Align(
                        alignment: Alignment.centerRight,

                        child: TextButton(
                          onPressed: () {},

                          child: const Text(
                            'نسيت كلمة المرور؟',
                            style: TextStyle(
                              color: Color(0xff6D2536),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // زر تسجيل الدخول
                      SizedBox(
                        height: 55,

                        child: ElevatedButton(
                          onPressed: login,

                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6D2536),
                            foregroundColor: Colors.white,
                            elevation: 7,
                            shadowColor: const Color(0x806D2536),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),

                          child: const Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 22),

                      const Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Color(0xffE4D6CE),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),

                            child: Text(
                              'أو',
                              style: TextStyle(
                                color: Color(0xffA38A84),
                              ),
                            ),
                          ),

                          Expanded(
                            child: Divider(
                              color: Color(0xffE4D6CE),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // إنشاء حساب
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'ما عندك حساب؟',
                            style: TextStyle(
                              color: Color(0xff85736F),
                            ),
                          ),

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

                            child: const Text(
                              'إنشاء حساب',
                              style: TextStyle(
                                color: Color(0xff6D2536),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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