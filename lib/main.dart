import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loop_tag/app/services/nfc_service.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NfcService().init();

  runApp(
    GetMaterialApp(
      title: "Loop Tag",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
