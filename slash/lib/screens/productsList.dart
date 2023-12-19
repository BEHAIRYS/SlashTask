import 'package:flutter/material.dart';
import 'package:slash/datastructures/Product.dart';

class ProductsListScreen extends StatelessWidget {
  ProductsListScreen({super.key, required this.products});
  List<Product> products;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Text('Category Image'),
              Column(
                children: [
                  Text('Category Name'),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.filter),
                    label: Text('Filters'),
                  ),
                ],
              )
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return GridTile(
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ${products[index].name}'),

                        // Add more widgets as needed
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
