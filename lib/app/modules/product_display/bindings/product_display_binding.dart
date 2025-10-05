import 'package:get/get.dart';

import '../controllers/product_display_controller.dart';

class ProductDisplayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDisplayController>(
      () => ProductDisplayController(),
    );
  }
}
