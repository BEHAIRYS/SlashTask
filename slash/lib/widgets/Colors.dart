import 'package:flutter/material.dart';

class ColorsWidget extends StatefulWidget {
  ColorsWidget(
      {super.key, required this.colors, required this.changeVariation});
  void Function(String value) changeVariation;
  List<String> colors;
  @override
  State<StatefulWidget> createState() {
    return _ColorsWidgetState();
  }
}

class _ColorsWidgetState extends State<ColorsWidget> {
  Color hexToColor(String hexColor) {
    // Remove the # character if present
    hexColor = hexColor.replaceAll("#", "");

    // Parse the hexadecimal color code
    int colorValue = int.parse(hexColor, radix: 16);

    // Create a Color object
    return Color(colorValue | 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var color in widget.colors)
          GestureDetector(
            onTap: () {
              widget.changeVariation(color);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: hexToColor(color),
                borderRadius: BorderRadius.circular(15),
              ),
              width: 30,
              height: 30,
            ),
          ),
      ],
    );
  }
}
