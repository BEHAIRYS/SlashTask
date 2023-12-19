import 'package:slash/datastructures/PropertyValues.dart';

class ProductVariation {
  final int id;
  final int productId;
  final num price;
  final int quantity;
  final bool inStock; //to enable/disable addToCart button
  final List<String> productVarientImages;
  final List<ProductPropertyAndValue> productPropertiesValues;

  ProductVariation(
      {required this.id,
      required this.productId,
      required this.price,
      required this.quantity,
      required this.inStock,
      required this.productVarientImages,
      required this.productPropertiesValues});
  factory ProductVariation.fromJson(Map<String, dynamic> json) {
    return ProductVariation(
      id: json['id'] ?? 0,
      productId: json['productId'] ?? 0,
      price: (json['price'] ?? 0.0).toDouble(),
      quantity: json['quantity'] ?? 0,
      inStock: json['inStock'] ?? false,
      productVarientImages: (json['productVarientImages'] as List<dynamic>?)
              ?.map((image) => image.toString())
              .toList() ??
          [],
      productPropertiesValues: (json['productPropertiesValues']
                  as List<dynamic>?)
              ?.map((property) => ProductPropertyAndValue.fromJson(property))
              .toList() ??
          [],
    );
  }
}
