import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/scanner_controller.dart';

class ScannerView extends GetView<ScannerController> {
  const ScannerView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.initialize();
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Lottie.asset(
              "assets/images/scanning-anim.json",
              width: double.infinity,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2000),
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.only(top: 40, bottom: 20),
                  child: SvgPicture.asset("assets/icons/logo.svg", width: 80),
                ),
                Text("Tap on a Loop Tag to scan"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
