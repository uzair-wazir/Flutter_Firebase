import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/dayOne/loginPage/login_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginAutentication extends StatefulWidget {
  const LoginAutentication({super.key});

  @override
  State<LoginAutentication> createState() => _LoginAutenticationState();
}

class _LoginAutenticationState extends State<LoginAutentication> {
  final controller = Get.put(LoginController());

  InputDecoration _decoration(String hintText) => InputDecoration(
    border: InputBorder.none,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    hintText: hintText,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hello Again', style: GoogleFonts.bebasNeue(fontSize: 52)),
                const SizedBox(height: 10),
                const Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 50),
                _InputBox(
                  child: TextField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _decoration('Enter your email'),
                  ),
                ),
                const SizedBox(height: 15),
                _InputBox(
                  child: Obx(
                    () => TextField(
                      controller: controller.passwordController,
                      obscureText: controller.isPasswordHidden.value,
                      decoration: _decoration('Enter your password').copyWith(
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordHidden.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Obx(
                    () => GestureDetector(
                      onTap: controller.isLoading.value
                          ? null
                          : controller.login,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: controller.isLoading.value
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not a Member?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the registration page
                      },
                      child: const Text(
                        ' Register Now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputBox extends StatelessWidget {
  final Widget child;

  const _InputBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: child,
      ),
    );
  }
}
