import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loop_tag/app/modules/NfcWriter/controllers/nfc_writer_controller.dart';
import 'package:lottie/lottie.dart';

class NfcWriterView extends GetView<NfcWriterController> {
  const NfcWriterView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    Get.put(NfcWriterController());

    return Scaffold(
      appBar: AppBar(title: const Text('Write to NFC Tag'), centerTitle: true),
      body: Center(
        child: Obx(
          () => Stack(
            alignment: Alignment.center,
            children: [
              if (controller.isNfcAvailable.value)
                Lottie.asset(
                  "assets/images/scanning-anim.json", // Reusing the scanning animation
                  width: Get.width,
                ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2000),
                      color:
                          !controller.isNfcAvailable.value
                              ? null
                              : Colors.white,
                    ),
                    margin: const EdgeInsets.only(top: 40, bottom: 20),
                    child: SvgPicture.asset(
                      !controller.isNfcAvailable.value
                          ? "assets/icons/disconnect.svg"
                          : "assets/icons/logo.svg",
                      width: 80,
                    ),
                  ),
                  Text(controller.statusMessage.value),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
