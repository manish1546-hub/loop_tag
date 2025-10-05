import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loop_tag/app/services/nfc_service.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NfcWriterController extends GetxController {
  final NfcService _nfcService = NfcService();
  final String productIdToWrite = Get.arguments; // Receive product ID from navigation

  final RxBool isNfcAvailable = true.obs;
  final RxString statusMessage = 'Hold your phone near an NFC tag to write.'.obs;

  @override
  void onInit() {
    super.onInit();
    _startNfcWritingSession();
  }

  @override
  void onClose() {
    _nfcService.stopSession();
    super.onClose();
  }

  Future<void> _startNfcWritingSession() async {
    isNfcAvailable.value = await _nfcService.isAvailable();
    if (!isNfcAvailable.value) {
      statusMessage.value = 'NFC is not available on this device.';
      return;
    }

    try {
      // Create a text record with the product ID
      final record = NdefRecord.createText(productIdToWrite);
      final success = await _nfcService.writeNdef([record]);

      if (success) {
        statusMessage.value = 'Product ID written successfully!';
        Get.snackbar(
          'Success',
          'NFC tag updated.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Navigate back after a short delay
        Future.delayed(const Duration(seconds: 2), () => Get.back());
      }
    } catch (e) {
      statusMessage.value = 'Error: ${e.toString()}';
       Get.snackbar(
          'Error Writing Tag',
          e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      _nfcService.stopSession(errorMessage: e.toString());
    }
  }
}
