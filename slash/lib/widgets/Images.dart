import 'package:flutter/material.dart';

class ImageSwipePage extends StatefulWidget {
  @override
  _ImageSwipePageState createState() => _ImageSwipePageState();
}

class _ImageSwipePageState extends State<ImageSwipePage> {
  final PageController _pageController = PageController(initialPage: 1);
  List<String> imagePaths = [];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: imagePaths.length,
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
            imagePaths[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
