import 'package:get/get.dart';
import 'package:loop_tag/app/data/product_model.dart';
import 'package:loop_tag/app/utils/core/product_api.dart';

class HomeController extends GetxController {
  // Observable list to hold products. The UI will automatically update when this changes.
  final allProducts = <Product>[].obs;

  // Observable boolean to track the loading state.
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch products for the first time when the controller is initialized.
    fetchProducts();
  }

  /// Fetches all products from the API service and updates the state.
  /// This function will be called on initial load and on pull-to-refresh.
  Future<void> fetchProducts() async {
    // Set loading to true only on the initial fetch.
    if (allProducts.isEmpty) {
      isLoading.value = true;
    }

    try {
      final products = await ProductApiService().getAllProducts();
      allProducts.value = products;
    } finally {
      // Always set loading to false after the API call completes.
      isLoading.value = false;
    }
  }
}
