import 'package:flutter/material.dart';
import 'package:slash/datastructures/Product.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:slash/datastructures/ProductVariation.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsScreen({super.key, required this.product});
  Product product;
  @override
  State<StatefulWidget> createState() {
    return _ProductDetailsScreenState();
  }
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
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

        // Convert each element to a Product object
        setState(() {
          widget.product.variations =
              data.map((item) => ProductVariation.fromJson(item)).toList();
        });

        print(
            'Number of books about http: ${widget.product.variations[0].productPropertiesValues[0].property}');
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
          Container(),
          Row(),
          Row(),
        ],
      ),
    );
  }
}
