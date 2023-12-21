import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slash/datastructures/Product.dart';
import 'package:slash/screens/productsList.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.black, brightness: Brightness.dark);
  List<Product> products = [];
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  Future<void> fetchAllProducts() async {
    var url = Uri.https('slash-backend.onrender.com', '/product');
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      // Check if 'data' key exists and is a list
      if (jsonResponse.containsKey('data') && jsonResponse['data'] is List) {
        List<dynamic> data = jsonResponse['data'];

        // Convert each element to a Product object
        setState(() {
          products = data.map((item) => Product.fromJson(item)).toList();
        });
        print('Number of books about http: ${products.length.toString()}.');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: colorScheme,
          useMaterial3: true,
          textTheme: GoogleFonts.nunitoTextTheme(Typography.whiteCupertino)),
      home: Scaffold(
        appBar: AppBar(),
        body: ProductsListScreen(products: products),
      ),
    );
  }
}
