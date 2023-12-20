import 'package:flutter/material.dart';
import 'package:slash/datastructures/AvailableProperties.dart';
import 'package:slash/datastructures/Product.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:slash/datastructures/ProductVariation.dart';
import 'package:slash/datastructures/PropertyValues.dart';
import 'package:slash/widgets/Colors.dart';
import 'package:slash/widgets/Images.dart';
import 'package:slash/widgets/Materials.dart';
import 'package:slash/widgets/Size.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsScreen({super.key, required this.product});
  Product product;

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailsScreenState();
  }
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductVariation? variation;
  Widget? Variations;
  @override
  initState() {
    super.initState();
    fetchProductVariations();
    variation = widget.product.variations[0];
  }

  void _changeVariation(String value) {
    List<ProductVariation> variations;
    variations = widget.product.variations
        .where((element) => element.productPropertiesValues
            .any((property) => property.value == value))
        .toList();
    setState(() {
      variation = variations[0];
    });
  }

  Widget displayVariations() {
    Widget? size, color, material;
    if (widget.product.availableProperties
        .any((property) => property.property == 'Size')) {
      List<String> values = [];
      widget.product.availableProperties
          .where((element) => element.property == 'Size')
          .forEach((property) {
        values = property.values;
      });
      size = SizeWidget(values: values, changeVariation: _changeVariation);
    }
    if (widget.product.availableProperties
        .any((property) => property.property == 'Color')) {
      List<String> values = [];
      widget.product.availableProperties
          .where((element) => element.property == 'Color')
          .forEach((property) {
        values = property.values;
      });
      color = ColorsWidget(
        colors: values,
        changeVariation: _changeVariation,
      );
    }
    if (widget.product.availableProperties
        .any((property) => property.property == 'Materials')) {
      List<String> values = [];
      widget.product.availableProperties
          .where((element) => element.property == 'Materials')
          .forEach((property) {
        values = property.values;
      });
      material = MaterialWidget(
        materials: values,
        changeVariation: _changeVariation,
      );
    }

    return Column(
      children: [
        size ??
            SizedBox(
              width: 1,
            ),
        color ??
            SizedBox(
              width: 1,
            ),
        material ??
            SizedBox(
              width: 1,
            )
      ],
    );
  }

  List<String> getImagePaths() {
    List<String> imagePaths = [];
    if (variation!.productVarientImages.isNotEmpty) {
      for (var image in variation!.productVarientImages) {
        imagePaths.add(image.imagePath);
      }

      return imagePaths;
    }

    return [];
  }

  Future<void> fetchProductVariations() async {
    var url = Uri.https(
        'slash-backend.onrender.com', '/product/${widget.product.id}');
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      // Check if 'data' key exists and is a list
      if (jsonResponse.containsKey('data')) {
        List<dynamic> data = jsonResponse['data']['variations'];
        List<dynamic> availableProperties =
            jsonResponse['data']['avaiableProperties'];

        // Convert each element to a Product object
        setState(() {
          widget.product.variations =
              data.map((item) => ProductVariation.fromJson(item)).toList();
          widget.product.availableProperties = availableProperties
              .map((property) => AvailableProperties.fromJson(property))
              .toList();
        });
        print('succeeded');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            height: 400,
            child: ImagePage(imagePath: getImagePaths()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.product.name),
              Image(
                image: NetworkImage(widget.product.brandLogoUrl ?? ''),
                height: 50,
                width: 50,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                variation!.price.toString(),
              ),
              Text(widget.product.brandName!),
            ],
          ),
          ElevatedButton(
            onPressed: fetchProductVariations,
            child: const Text('data'),
          ),
          displayVariations(),
        ],
      ),
    );
  }
}
