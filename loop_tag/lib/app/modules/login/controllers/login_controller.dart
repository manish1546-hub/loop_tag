import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loop_tag/app/utils/core/login_api.dart';

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

    await AuthApiService().login(email, password);

    isLoading.value = false;
  }

  void forgotPassword() {
    Get.snackbar("Forgot Password", "Redirecting to reset page...");
  }

  void signInWithGoogle() {
    Get.snackbar("Google", "Google login redirection");
  }

  void signInWithApple() {
    Get.snackbar("Apple", "Apple login redirection");
  }

  void signInWithFacebook() {
    Get.snackbar("Facebook", "Facebook login redirection");
  }
}
