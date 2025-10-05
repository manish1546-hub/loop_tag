import 'package:connectivity_plus/connectivity_plus.dart';

// const String baseURI = "http://10.0.2.2:8055/api";
const String baseURI = "https://loop-tag.onrender.com/api";

Future<bool> isConnected() async {
  return (await Connectivity().checkConnectivity()).first !=
      ConnectivityResult.none;
}