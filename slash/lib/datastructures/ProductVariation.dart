import 'package:slash/datastructures/ProductVariantImage.dart';
import 'package:slash/datastructures/PropertyValues.dart';

class ProductVariation {
  final int id;
  final int productId;
  final num price;
  final int quantity;
  final bool inStock; //to enable/disable addToCart button
  final List<ProductVariantImage> productVarientImages;
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
    List<dynamic>? images = json['ProductVarientImages'];
    List<ProductVariantImage> productImages = [];

    if (images != null && images is List) {
      productImages =
          images.map((image) => ProductVariantImage.fromJson(image)).toList();
    }

    return ProductVariation(
      id: json['id'] ?? 0,
      productId: json['product_id'] ?? 0,
      price: (json['price'] ?? 0.0).toDouble(),
      quantity: json['quantity'] ?? 0,
      inStock: json['quantity'] < 1 ? false : true,
      productVarientImages: productImages,
      productPropertiesValues: (json['productPropertiesValues']
                  as List<dynamic>?)
              ?.map((property) => ProductPropertyAndValue.fromJson(property))
              .toList() ??
          [],
    );
  }
}
