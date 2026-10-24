import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordHidden = true.obs; // show/hide password
  final isLoading = false.obs; // button spinner
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    //validate email and password

    if (email.isEmpty || password.isEmpty) {
      return _showMessage('Error', 'Please enter email and password');
    }
    if (!GetUtils.isEmail(email)) {
      return _showMessage('Error', 'Please enter a valid email');
    }

    try {
      isLoading.value = true;
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _showMessage('Success', 'Login successful');
    } on FirebaseAuthException catch (e) {
      _showMessage('Login Failed', _errorText(e.code));
    } catch (e) {
      _showMessage('LoginFailed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  String _errorText(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Invalid email address';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'too-many-requests':
        return 'Too many attempts. Try again later';
      case 'network-request-failed':
        return 'No internet connection';
      default:
        return 'Something went wrong ($code)';
    }
  }

  void _showMessage(String title, String message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
