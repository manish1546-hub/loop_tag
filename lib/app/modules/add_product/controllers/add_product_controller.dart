import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProductController extends GetxController {
  // Text Editing Controllers for form fields
  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  final discountedPriceController = TextEditingController();
  final descriptionController = TextEditingController();

  // Observable list to store picked image files
  final RxList<XFile> selectedImages = <XFile>[].obs;
  final ImagePicker _picker = ImagePicker();

  // Observable for the selected category
  final RxString selectedCategory = 'Groceries'.obs;
  final List<String> categories = [
    'Groceries',
    'Electronics',
    'Clothing',
    'Home Goods',
  ];

  // Method to handle image selection from the gallery
  Future<void> pickImages() async {
    if (selectedImages.length >= 5) {
      Get.snackbar('Limit Reached', 'You can only upload up to 5 images.');
      return;
    }
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      int availableSlots = 5 - selectedImages.length;
      if (images.length > availableSlots) {
        selectedImages.addAll(images.take(availableSlots));
        Get.snackbar(
          'Limit Exceeded',
          'Only ${availableSlots} more images were added.',
        );
      } else {
        selectedImages.addAll(images);
      }
    }
  }

  // Method to remove a selected image
  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    }
  }

  // Method to change category
  void onCategoryChanged(String? newValue) {
    if (newValue != null) {
      selectedCategory.value = newValue;
    }
  }

  // Method to handle product submission
  void addProduct() {
    // Basic validation
    if (productNameController.text.isEmpty ||
        priceController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        selectedImages.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all required fields and upload at least one image.',
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    // You can process and submit your data here
    print('Product Name: ${productNameController.text}');
    print('Price: ${priceController.text}');
    print('Discounted Price: ${discountedPriceController.text}');
    print('Description: ${descriptionController.text}');
    print('Category: ${selectedCategory.value}');
    print('Images: ${selectedImages.map((e) => e.path).toList()}');

    Get.snackbar(
      'Success',
      'Product added successfully!',
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
    );
  }

  // Dispose controllers when the screen is closed
  @override
  void onClose() {
    productNameController.dispose();
    priceController.dispose();
    discountedPriceController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
