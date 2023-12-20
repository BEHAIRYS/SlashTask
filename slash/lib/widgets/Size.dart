import 'package:flutter/material.dart';
import 'package:slash/datastructures/ProductVariation.dart';

class SizeWidget extends StatefulWidget {
  SizeWidget({super.key, required this.values});

  List<String> values = [];
  @override
  State<StatefulWidget> createState() {
    return _SizeWidgetState();
  }
}

class _SizeWidgetState extends State<SizeWidget> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Text('Select Size'),
            Text('Size Chart'),
          ],
        )
      ],
    );
  }
}
