import 'package:flutter/material.dart';
import 'package:slash/datastructures/Product.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class ProductsListScreen extends StatelessWidget {
  ProductsListScreen({super.key, required this.products});
  List<Product> products;

  Future<void> fetchAllProducts() async {
    var url = Uri.https('slash-backend.onrender.com', '/product');
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      // Check if 'data' key exists and is a list
      if (jsonResponse.containsKey('data') && jsonResponse['data'] is List) {
        List<dynamic> data = jsonResponse['data'];

        // Convert each element to a Product object
        products = data.map((item) => Product.fromJson(item)).toList();
        print('Number of books about http: ${products.length.toString()}.');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ElevatedButton(
        onPressed: fetchAllProducts,
        child: Text('data'),
      ),
    );
  }
}
