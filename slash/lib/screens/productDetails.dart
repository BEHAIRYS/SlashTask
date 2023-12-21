import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:slash/datastructures/AvailableProperties.dart';
import 'package:slash/datastructures/Product.dart';
import 'package:slash/datastructures/ProductVariation.dart';
import 'package:slash/datastructures/PropertyValues.dart';
import 'package:slash/widgets/Colors.dart';
import 'package:slash/widgets/Images.dart';
import 'package:slash/widgets/Materials.dart';
import 'package:slash/widgets/Size.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductDetailsScreen({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<StatefulWidget> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductVariation? variation;
  bool isDataInitialized = false;
  List<ProductVariation> currentVariations = [];

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    await fetchProductVariations();
    setState(() {
      isDataInitialized = true;
      currentVariations = List.from(widget.product.variations);
      variation = widget.product.variations.isNotEmpty
          ? widget.product.variations[0]
          : null;
    });
  }

  Future<void> fetchProductVariations() async {
    try {
      var url = Uri.https(
          'slash-backend.onrender.com', '/product/${widget.product.id}');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.containsKey('data')) {
          List<dynamic> data = jsonResponse['data']['variations'];
          List<dynamic> availableProperties =
              jsonResponse['data']['avaiableProperties'];

          setState(() {
            widget.product.variations =
                data.map((item) => ProductVariation.fromJson(item)).toList();
            widget.product.availableProperties = availableProperties
                .map((property) => AvailableProperties.fromJson(property))
                .toList();
          });
        } else {
          print('Response does not contain data key.');
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      print('Error fetching product variations: $error');
    }
  }

  void _changeVariation(String value) {
    List<ProductVariation> newVariations = widget.product.variations
        .where((element) => element.productPropertiesValues
            .any((property) => property.value == value))
        .toList();

    setState(() {
      variation = newVariations.isNotEmpty ? newVariations[0] : null;
      currentVariations.clear();
      currentVariations.addAll(newVariations);
    });
  }

  Widget _buildColorsWidget() {
    if (!widget.product.availableProperties
        .any((property) => property.property == 'Color')) {
      return Container();
    }

    List<String> colorValues = widget.product.availableProperties
        .firstWhere((element) => element.property == 'Color')
        .values;

    return ColorsWidget(
      colors: colorValues,
      changeVariation: _changeVariation,
    );
  }

  Widget _buildSizeWidget() {
    if (variation == null ||
        !variation!.productPropertiesValues
            .any((property) => property.property == 'Size')) {
      return Container();
    }

    String selectedColor = variation!.productPropertiesValues
        .firstWhere(
          (property) => property.property == 'Color',
          orElse: () => ProductPropertyAndValue(property: 'Color', value: ''),
        )
        .value;

    List<String> sizesForSelectedColor = [];

    widget.product.variations.forEach((element) {
      if ((element.productPropertiesValues.any((property) =>
                  property.property == 'Color' &&
                  property.value == selectedColor) ||
              !element.productPropertiesValues
                  .any((property) => property.property == 'Color')) &&
          element.productPropertiesValues
              .any((property) => property.property == 'Size')) {
        element.productPropertiesValues
            .where((property) => property.property == 'Size')
            .forEach((property) {
          sizesForSelectedColor.add(property.value);
        });
      }
    });

    return SizeWidget(
      values: sizesForSelectedColor,
      changeVariation: _changeVariation,
    );
  }

  Widget _buildMaterialWidget() {
    if (variation == null ||
        !variation!.productPropertiesValues
            .any((property) => property.property == 'Materials')) {
      return Container();
    }

    String selectedColor = variation!.productPropertiesValues
        .firstWhere(
          (property) => property.property == 'Color',
          orElse: () => ProductPropertyAndValue(property: 'Color', value: ''),
        )
        .value;

    List<String> materialsForSelectedColor = [];

    widget.product.variations.forEach((element) {
      if ((element.productPropertiesValues.any((property) =>
                  property.property == 'Color' &&
                  property.value == selectedColor) ||
              !element.productPropertiesValues
                  .any((property) => property.property == 'Color')) &&
          element.productPropertiesValues
              .any((property) => property.property == 'Materials')) {
        element.productPropertiesValues
            .where((property) => property.property == 'Materials')
            .forEach((property) {
          materialsForSelectedColor.add(property.value);
        });
      }
    });

    return MaterialWidget(
      materials: materialsForSelectedColor,
      changeVariation: _changeVariation,
    );
  }

  Widget _buildVariations() {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            _buildColorsWidget(),
            const SizedBox(
              height: 12,
            ),
            _buildSizeWidget(),
            const SizedBox(
              height: 12,
            ),
            _buildMaterialWidget(),
          ],
        ),
      ],
    );
  }

  List<String> getImagePaths() {
    List<String> imagePaths = [];
    if (variation == null) {
      return [];
    }
    if (variation!.productVarientImages.isNotEmpty) {
      for (var image in variation!.productVarientImages) {
        imagePaths.add(image.imagePath);
      }
      return imagePaths;
    }
    return [];
  }

  Widget _buildImagePage() {
    List<String> imagePaths = getImagePaths();

    return Container(
      height: 400,
      width: double.infinity,
      child: ImagePage(imagePath: imagePaths),
    );
  }

  Widget _buildBrandInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.product.name),
        ClipOval(
          child: Image(
            image: NetworkImage(widget.product.brandLogoUrl ?? ''),
            height: 50,
            width: 50,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceAndBrandName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          variation?.price.toString() ?? 'loading..',
        ),
        Text(widget.product.brandName ?? 'loading..'),
      ],
    );
  }

  Widget _buildDescription() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        title: const Text('Description'),
        children: [Text(widget.product.description)],
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.white12),
        ),
        onPressed: () {},
        icon: const Icon(Icons.shopping_cart_checkout_rounded),
        label: const Text('Add to Cart'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _buildImagePage(),
              _buildBrandInfo(),
              _buildPriceAndBrandName(),
              if (isDataInitialized) _buildVariations(),
              _buildDescription(),
              _buildAddToCartButton(),
            ],
          ),
        ),
      ),
    );
  }
}
