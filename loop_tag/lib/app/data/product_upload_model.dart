import 'package:image_picker/image_picker.dart';

/// A dedicated model for handling product creation and uploads.
/// This separates the concerns of handling local files (for uploading)
/// from handling remote image URLs (for displaying).
class ProductUploadData {
  final String productName;
  final double price;
  final double? discountedPrice;
  final String description;
  final String category;
  final List<XFile> images; // Uses XFile for local images

  ProductUploadData({
    required this.productName,
    required this.price,
    this.discountedPrice,
    required this.description,
    required this.category,
    required this.images,
  });
}
