import 'package:get/get.dart';

import '../controllers/nfc_writer_controller.dart';

class NfcWriterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NfcWriterController>(
      () => NfcWriterController(),
    );
  }
}
