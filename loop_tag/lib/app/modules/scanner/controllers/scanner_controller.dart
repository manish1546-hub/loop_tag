import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loop_tag/app/data/product_model.dart';
import 'package:loop_tag/app/routes/app_pages.dart';
import 'package:loop_tag/app/services/nfc_service.dart';

class ScannerController extends GetxController {
  Future<void> initialize() async {
    print("ahh");
    final isAvailable = await NfcService().isAvailable();
    if (!isAvailable) {
      Get.snackbar(
        'Error',
        "NFC not available on this device",
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      Get.toNamed(
        Routes.PRODUCT_DISPLAY,
        arguments: Product(
          productName: "Yellow Shoes",
          price: 23.00,
          description: "Best in the world, AHH!! Shoes",
          category: "Home Goods",
          imageUrls: [
            "https://static.vecteezy.com/system/resources/thumbnails/032/933/592/small/a-yellow-sports-shoe-with-elegant-design-free-photo.jpg",
            "https://www.shutterstock.com/image-photo/pair-stylish-yellow-sneakers-isolated-260nw-2560826733.jpg",
            "https://img4.dhresource.com/webp/m/300x300/f3/albu/jc/g/20/ad0a89cd-2536-481e-a5c2-45d9d5ba06b1.jpg",
            "https://img.kwcdn.com/product/fancy/808d2209-05f8-456c-be6d-f266c5cd3131.jpg"
          ],
        ),
      );
      return;
    } else {
      Get.snackbar('Started', "Loop tag scanning started");
    }
  }
}
