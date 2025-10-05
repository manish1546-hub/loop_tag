import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loop_tag/app/utils/core/login_api.dart';

import '../controllers/loading_page_controller.dart';

class LoadingPageView extends GetView<LoadingPageController> {
  const LoadingPageView({super.key});
  @override
  Widget build(BuildContext context) {
    AuthApiService().checkAuthStatus();
    return Scaffold(
      body: const Center(
        child: CircularProgressIndicator(color: Colors.blueAccent),
      ),
    );
  }
}
