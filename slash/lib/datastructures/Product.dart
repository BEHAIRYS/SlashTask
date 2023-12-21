import 'package:slash/datastructures/AvailableProperties.dart';
import 'package:slash/datastructures/ProductVariation.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final int brandId;
  final String? brandName;
  final String? brandLogoUrl;
  final double rating;
  List<ProductVariation> variations;
  List<AvailableProperties> availableProperties;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.brandId,
      required this.brandName,
      required this.brandLogoUrl,
      required this.rating,
      required this.variations,
      required this.availableProperties}); //What properties are offered //(multiple colors or non, multiple sizes or non, materials)
  factory Product.fromJson(Map<String, dynamic> json) {
    // Extract data from the JSON map and create a Product object
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      brandId: json['brand_id'] ?? 0,
      brandName: json['Brands']['brand_name'] ?? '',
      brandLogoUrl: json['Brands']['brand_logo_image_path'] ?? '',
      rating: (json['product_rating'] ?? 0.0).toDouble(),
      variations: (json['ProductVariations'] as List<dynamic>?)
              ?.map((variation) => ProductVariation.fromJson(variation))
              .toList() ??
          [],
      availableProperties: (json['avaiableProperties'] as List<dynamic>?)
              ?.map((property) => AvailableProperties.fromJson(property))
              .toList() ??
          [],
    );
  }
}
