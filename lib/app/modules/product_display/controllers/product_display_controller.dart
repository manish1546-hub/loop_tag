import 'package:get/get.dart';
import 'package:loop_tag/app/data/product_model.dart';

class ProductDisplayController extends GetxController {
  // The product to display, passed as an argument.
  final Product product = Get.arguments;

  // Observable for the current page in the image carousel.
  final RxInt activeImageIndex = 0.obs;

  // Method to update the active index when the user swipes through images.
  void onPageChanged(int index) {
    activeImageIndex.value = index;
  }
}
