import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordHidden = true.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please enter both email and password");
      return;
    }

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2)); // simulate API

    isLoading.value = false;

    // Example success
    Get.snackbar("Success", "Logged in as $email");
  }

  void forgotPassword() {
    Get.snackbar("Forgot Password", "Redirecting to reset page...");
  }

  void signInWithGoogle() {
    Get.snackbar("Google", "Google login tapped");
  }

  void signInWithApple() {
    Get.snackbar("Apple", "Apple login tapped");
  }

  void signInWithFacebook() {
    Get.snackbar("Facebook", "Facebook login tapped");
  }
}
