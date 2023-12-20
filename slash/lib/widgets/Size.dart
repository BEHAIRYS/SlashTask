import 'package:flutter/material.dart';
import 'package:slash/datastructures/ProductVariation.dart';

class SizeWidget extends StatefulWidget {
  SizeWidget({super.key, required this.values, required this.changeVariation});
  void Function(String value) changeVariation;

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
                onPressed: () {
                  widget.changeVariation(value);
                },
                child: Text(value),
              ),
          ],
        )
      ],
    );
  }
}
