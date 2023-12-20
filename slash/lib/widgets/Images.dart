import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key, required this.imagePath});
  final List<String> imagePath;
  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  final PageController _pageController = PageController(initialPage: 1);
  List<Image> images = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imagePath.length,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
                  }
                  return Center(
                    child: SizedBox(
                      height: Curves.easeInOut.transform(value) * 200,
                      width: Curves.easeInOut.transform(value) * 200,
                      child: child,
                    ),
                  );
                },
                child: Image.network(
                  widget.imagePath[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.imagePath.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4.0), // Adjust padding as needed
                child: SizedBox(
                  width: 50.0, // Adjust width as needed
                  height: 50.0, // Adjust height as needed
                  child: Image.network(widget.imagePath[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
