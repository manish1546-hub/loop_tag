// The image_picker import is no longer needed in the model file.

class Product {
  final String productName;
  final double price;
  final double? tax;
  final String description;
  final String category;
  final String? id;
  // Changed to List<String> to hold image URLs, which is JSON-friendly.
  final List<String> imageUrls;

  Product({
    required this.productName,
    required this.price,
    this.tax,
    this.id,
    required this.description,
    required this.category,
    required this.imageUrls, // Updated constructor
  });

  // toJson method is updated to use the new `imageUrls` property.
  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'price': price,
      'tax': tax,
      'description': description,
      'category': category,
      'imageUrls': imageUrls,
      '_id': id
    };
  }

  // --- NEW ---
  // fromJson factory method to create a Product instance from a map.
  factory Product.fromJson(Map<String, dynamic> json) {
    // Safely parse the price, handling both int and double from JSON.
    final price = (json['price'] as num?)?.toDouble() ?? 0.0;

    // Safely parse the discounted price.
    final tax = (json['discountedPrice'] as num?)?.toDouble();

    // Safely parse the list of image URLs, ensuring it's a list of strings.
    final imageUrls =
        (json['imageUrls'] as List<dynamic>?)
            ?.map((item) => item.toString())
            .toList() ??
        [];

    return Product(
      productName: json['productName'] as String? ?? '',
      price: price,
      tax: tax,
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      imageUrls: imageUrls,
      id: json["_id"]
    );
  }
}
