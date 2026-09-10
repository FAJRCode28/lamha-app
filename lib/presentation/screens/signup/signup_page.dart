import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? nameError;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  void createAccount() {
    setState(() {
      nameError = null;
      emailError = null;
      passwordError = null;
      confirmPasswordError = null;

      // التحقق من الاسم
      if (nameController.text.isEmpty) {
        nameError = 'يرجى إدخال الاسم';
      }

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

      // التحقق من تأكيد كلمة المرور
      if (confirmPasswordController.text.isEmpty) {
        confirmPasswordError = 'يرجى تأكيد كلمة المرور';
      } else if (confirmPasswordController.text !=
          passwordController.text) {
        confirmPasswordError = 'كلمتا المرور غير متطابقتين';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,

      child: Scaffold(
        backgroundColor: const Color(0xffF8F3EC),

        appBar: AppBar(
          backgroundColor: const Color(0xffF8F3EC),
          elevation: 0,

          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },

            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xff6D2536),
            ),
          ),
        ),

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(22, 5, 22, 30),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // اللوقو
                Center(
                  child: Image.asset(
                    'assets/images/lamha_logo.png',
                    width: 100,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'إنشاء حساب',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff6D2536),
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'أنشئ حسابك وابدأ تجربتك مع لمحة',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff9A7A76),
                  ),
                ),

                const SizedBox(height: 25),

                // كرت إنشاء الحساب
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
                      // الاسم
                      const Text(
                        'الاسم',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff6D2536),
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        controller: nameController,
                        textAlign: TextAlign.right,

                        decoration: InputDecoration(
                          hintText: 'أدخل الاسم',
                          errorText: nameError,

                          prefixIcon: const Icon(
                            Icons.person_outline,
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
                              color: nameError != null
                                  ? Colors.red
                                  : const Color(0xffE5D5CC),
                            ),
                          ),

                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),

                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

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

                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),

                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

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
                          hintText: '6 أحرف على الأقل',
                          errorText: passwordError,

                          prefixIcon: const Icon(
                            Icons.lock_outline,
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
                              color: passwordError != null
                                  ? Colors.red
                                  : const Color(0xffE5D5CC),
                            ),
                          ),

                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),

                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // تأكيد كلمة المرور
                      const Text(
                        'تأكيد كلمة المرور',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff6D2536),
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        controller: confirmPasswordController,
                        textAlign: TextAlign.right,
                        obscureText: true,

                        decoration: InputDecoration(
                          hintText: 'أعد إدخال كلمة المرور',
                          errorText: confirmPasswordError,

                          prefixIcon: const Icon(
                            Icons.lock_outline,
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
                              color: confirmPasswordError != null
                                  ? Colors.red
                                  : const Color(0xffE5D5CC),
                            ),
                          ),

                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),

                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // زر إنشاء الحساب
                      SizedBox(
                        height: 55,

                        child: ElevatedButton(
                          onPressed: createAccount,

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
                            'إنشاء الحساب',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'لديك حساب؟',
                            style: TextStyle(
                              color: Color(0xff85736F),
                            ),
                          ),

                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },

                            child: const Text(
                              'تسجيل الدخول',
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

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}