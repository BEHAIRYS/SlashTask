import 'package:flutter/material.dart';

class MaterialWidget extends StatefulWidget {
  MaterialWidget(
      {super.key, required this.materials, required this.changeVariation});
  void Function(String value) changeVariation;

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
              TextButton(
                  onPressed: () {
                    widget.changeVariation(material);
                  },
                  child: Text(material)),
          ],
        ),
      ],
    );
  }
}
