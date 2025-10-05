import 'package:http/http.dart' as http;
import 'package:loop_tag/app/utils/core/constants.dart';

Future<void> login(String email, String password) async {
  if (!await isConnected()) {
    return;
  }

  // login and store accesstoken, refreshtoken (isAdmin if applicable) in secure storage
}

Future<void> checkCurrentUser(String email, String password) async {
  if (!await isConnected()) {
    return;
  }

  // get accesstoken and isAdmin if present from the secure storage
  // fetch the appropriate end point in the backend 
  // if not valid then redirect to Login page with Get.toNamed(Routes.LOGIN)
}