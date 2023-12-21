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
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8), child: child),
                  );
                },
                child: Image.network(
                  widget.imagePath[index],
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.center,
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.imagePath.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.imagePath[index],
                    fit: BoxFit.contain,
                    height: 50,
                    width: 50,
                  ),
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
