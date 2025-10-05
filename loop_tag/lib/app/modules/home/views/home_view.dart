import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loop_tag/app/routes/app_pages.dart';
import 'package:loop_tag/app/utils/ui/product_card.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Products",
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Icon(Icons.logout_outlined),
          ),
        ],
        elevation: 0,
      ),
      body: Obx(
        () => AnimatedCrossFade(
          duration: Durations.medium3,
          crossFadeState:
              controller.allProducts.isEmpty
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
          secondChild: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.redAccent, size: 42),
                  SizedBox(height: 12),
                  Text(
                    "There is no products listed\ncurrently",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          firstChild: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 cards per row
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75, // Adjust for card height
              ),
              itemCount: controller.allProducts.length,
              itemBuilder: (context, index) {
                final product = controller.allProducts[index];
                return ProductCard(
                  product: product,
                  onTap: () {
                    // Navigate to the product display screen
                    Get.to(Routes.PRODUCT_DISPLAY, arguments: product);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
