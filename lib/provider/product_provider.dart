import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  //variable declaration
  bool _isFetchingProductData = false;
  List<Product> _availableProducts = [];

  ProductProvider() {
    fetchProducts();
  }

//getters
  bool get isFetchingProductData => _isFetchingProductData;
  List<Product> get availableProducts => _availableProducts;

  Future<bool> fetchProducts() async {
    bool hasError = true;
    _isFetchingProductData = true;
    notifyListeners();

    final List<Product> _fetchedProducts = [];
    try {
      final http.Response response = await http.get(api + "products");

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        data['products'].forEach((productData) {
          final product = Product.fromMap(productData);
          _fetchedProducts.add(product);
        });
        hasError = false;
      }
    } catch (error) {
      print(error);
      hasError = true;
    }

    _availableProducts = _fetchedProducts;
    _isFetchingProductData = false;
    print(_availableProducts.length);
    notifyListeners();

    return hasError;
  }
}
