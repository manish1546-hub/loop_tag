import 'package:get/get.dart';

import '../modules/NfcWriter/bindings/nfc_writer_binding.dart';
import '../modules/NfcWriter/views/nfc_writer_view.dart';
import '../modules/add_product/bindings/add_product_binding.dart';
import '../modules/add_product/views/add_product_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/loading_page/bindings/loading_page_binding.dart';
import '../modules/loading_page/views/loading_page_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/product_display/bindings/product_display_binding.dart';
import '../modules/product_display/views/product_display_view.dart';
import '../modules/scanner/bindings/scanner_binding.dart';
import '../modules/scanner/views/scanner_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOADING_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PRODUCT,
      page: () => const AddProductView(),
      binding: AddProductBinding(),
    ),
    GetPage(
      name: _Paths.SCANNER,
      page: () => const ScannerView(),
      binding: ScannerBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DISPLAY,
      page: () => const ProductDisplayView(),
      binding: ProductDisplayBinding(),
    ),
    GetPage(
      name: _Paths.LOADING_PAGE,
      page: () => const LoadingPageView(),
      binding: LoadingPageBinding(),
    ),
    GetPage(
      name: _Paths.NFC_WRITER,
      page: () => const NfcWriterView(),
      binding: NfcWriterBinding(),
    ),
  ];
}
