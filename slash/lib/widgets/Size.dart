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
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Select Size'),
            Text('Size Chart'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var value in widget.values)
              TextButton(
                onPressed: () {},
                child: Text(value),
              ),
          ],
        )
      ],
    );
  }
}
