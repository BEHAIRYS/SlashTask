import 'package:flutter/material.dart';
import 'package:slash/datastructures/Product.dart';

class ProductsListScreen extends StatelessWidget {
  ProductsListScreen({super.key, required this.products});
  List<Product> products;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('data'),
    );
  }
}
