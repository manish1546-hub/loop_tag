import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../data/product_model.dart';
import '../../data/product_upload_model.dart';
import '../../routes/app_pages.dart';
import '../../utils/core/constants.dart';

class ProductApiService {
  final _storage = const FlutterSecureStorage();

  /// A helper function to get authorization headers.
  /// If the token is not found, it redirects to the login page.
  Future<Map<String, String>?> _getAuthHeaders() async {
    final accessToken = await _storage.read(key: 'accessToken');

    if (accessToken == null || accessToken.isEmpty) {
      // Redirect to login and clear navigation stack
      Get.offAllNamed(Routes.LOGIN);
      return null;
    }

    return {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
  }

  /// Fetches a list of all products from the backend.
  Future<List<Product>> getAllProducts() async {
    if (!await isConnected()) {
      Get.snackbar(
        "Connection Error",
        "No internet connection.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return [];
    }

    final headers = await _getAuthHeaders();
    if (headers == null) return []; // Redirect has occurred

    try {
      final response = await http.get(
        Uri.parse('$baseURI/products'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Product.fromJson(json)).toList();
      } else {
        Get.snackbar(
          "API Error",
          "Failed to load products: ${response.statusCode}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return [];
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "An error occurred while fetching products: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return [];
    }
  }

  /// Fetches a single product by its ID.
  Future<Product?> getProduct(String productId) async {
    if (!await isConnected()) {
      Get.snackbar(
        "Connection Error",
        "No internet connection.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return null;
    }

    final headers = await _getAuthHeaders();
    if (headers == null) return null; // Redirect has occurred

    try {
      final response = await http.get(
        Uri.parse('$baseURI/products/$productId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return Product.fromJson(json.decode(response.body));
      } else {
        Get.snackbar(
          "API Error",
          "Failed to load product: ${response.statusCode}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return null;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "An error occurred while fetching the product: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    }
  }

  /// Posts a new product with images to the backend.
  Future<Product?> postProduct(ProductUploadData productData) async {
    if (!await isConnected()) {
      Get.snackbar(
        "Connection Error",
        "No internet connection.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return null;
    }

    final token = await _storage.read(key: 'accessToken');
    if (token == null || token.isEmpty) {
      Get.offAllNamed(Routes.LOGIN);
      return null;
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseURI/products'));

      // Add authorization header for multipart request
      request.headers['Authorization'] = 'Bearer $token';

      // Add text fields
      request.fields['productName'] = productData.productName;
      request.fields['price'] = productData.price.toString();
      request.fields['description'] = productData.description;
      request.fields['category'] = productData.category;
      if (productData.discountedPrice != null) {
        request.fields['discountedPrice'] = productData.discountedPrice.toString();
      }

      // Add image files
      for (var imageFile in productData.images) {
        request.files.add(
          await http.MultipartFile.fromPath('photos', imageFile.path),
        );
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        Get.snackbar(
          "Success",
          "Product uploaded successfully!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return Product.fromJson(json.decode(response.body));
      } else {
        Get.snackbar(
          "Upload Failed",
          "Error ${response.statusCode}: ${response.body}",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return null;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "An error occurred while uploading the product: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    }
  }
}

