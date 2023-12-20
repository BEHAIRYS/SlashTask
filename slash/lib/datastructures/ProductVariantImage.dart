class ProductVariantImage {
  final int id;
  final String imagePath;

  ProductVariantImage({
    required this.id,
    required this.imagePath,
  });

  factory ProductVariantImage.fromJson(Map<String, dynamic> json) {
    return ProductVariantImage(
      id: json['id'] ?? 0,
      imagePath: json['image_path'] ?? '',
    );
  }
}
