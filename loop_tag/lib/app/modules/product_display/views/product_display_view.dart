import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loop_tag/app/data/product_model.dart';

import '../controllers/product_display_controller.dart';

class ProductDisplayView extends GetView<ProductDisplayController> {
  const ProductDisplayView({super.key});

  @override
  Widget build(BuildContext context) {
    final product = controller.product;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          product.productName,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Image Carousel ---
              _buildImageCarousel(controller),
              const SizedBox(height: 24),
              // --- Product Info ---
              Text(
                product.category.toUpperCase(),
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.productName,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildPriceDisplay(product),
              const SizedBox(height: 24),
              const Text(
                'Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                product.description,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const Spacer(), // Pushes content to the top
            ],
          ),
        ),
      ),
    );
  }

  // Widget for the image carousel with page indicators
  Widget _buildImageCarousel(ProductDisplayController controller) {
    return Column(
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: PageView.builder(
            onPageChanged: controller.onPageChanged,
            itemCount: controller.product.imageUrls.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(
                  controller.product.imageUrls[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              controller.product.imageUrls.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: controller.activeImageIndex.value == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color:
                      controller.activeImageIndex.value == index
                          ? Colors.green
                          : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Widget to display the price, showing the original price struck-through if a discount exists
  Widget _buildPriceDisplay(Product product) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '₹${(product.tax ?? product.price).toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        if (product.tax != null) ...[
          const SizedBox(width: 10),
          Text(
            '₹${product.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade500,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ],
    );
  }
}
