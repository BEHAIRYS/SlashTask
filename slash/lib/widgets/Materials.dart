import 'package:flutter/material.dart';

class MaterialWidget extends StatefulWidget {
  MaterialWidget({super.key, required this.materials});
  List<String> materials;
  @override
  State<StatefulWidget> createState() {
    return _MaterialWidgetState();
  }
}

class _MaterialWidgetState extends State<MaterialWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Material'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var material in widget.materials)
              TextButton(onPressed: () {}, child: Text(material)),
          ],
        ),
      ],
    );
  }
}
