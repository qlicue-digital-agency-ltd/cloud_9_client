import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  //constructor
  ProductProvider() {
    fetchProducts();
  }

  //variable declaration
  bool _isFetchingProductData = false;
  List<Product> _availableProducts = [];

  /** Shopping cart */
  /// The IDs and quantities of products currently in the cart.
  final Map<int, int> _productsInCart = <int, int>{};
  //default constants
  double _salesTaxRate = 0.18;
  double _shippingCostPerItem = 0.0;
  bool _vat = false;

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

  // Removes everything from the cart.
  void _clearCart() {
    _productsInCart.clear();

    notifyListeners();
  }

  //cart
  Map<int, int> get productsInCart => Map<int, int>.from(_productsInCart);

  /// Total number of items in the cart.
  int get totalCartQuantity =>
      _productsInCart.values.fold(0, (int v, int e) => v + e);

  /// Totaled prices of the items in the cart.
  double get subtotalCost {
    return _productsInCart.keys.map((int id) {
      int index =
          _availableProducts.indexWhere(([product]) => product.id == id);
      return _availableProducts[index].price * _productsInCart[id];
    }).fold(0.0, (double sum, double e) => sum + e);
  }

  /// Total shipping cost for the items in the cart.
  double get shippingCost {
    return _shippingCostPerItem *
        _productsInCart.values.fold(0.0, (num sum, int e) => sum + e);
  }

  /// Sales tax for the items in the cart
  double get tax => subtotalCost * (_vat ? _salesTaxRate : 0.0);

  /// Total cost to order everything in the cart.
  double get totalCost => subtotalCost + shippingCost + tax;

  /// Adds a product to the cart.
  void addProductToCart({@required Product currentProduct}) {
    int index = _availableProducts
        .indexWhere((product) => product.id == currentProduct.id);

    if (_availableProducts[index].quantity > 0) {
      if (!_productsInCart.containsKey(currentProduct.id)) {
        _productsInCart[currentProduct.id] = 1;
      } else {
        _productsInCart[currentProduct.id]++;
      }
      _availableProducts[index].quantity--;
      notifyListeners();
    }
  }

  /// Removes an item from the cart.
  void removeItemFromCart({@required Product currentProduct}) {
    if (_productsInCart.containsKey(currentProduct.id)) {
      if (_productsInCart[currentProduct.id] == 1) {
        _productsInCart.remove(currentProduct.id);
      } else {
        _productsInCart[currentProduct.id]--;
      }
    }
    int index = _availableProducts
        .indexWhere((product) => product.id == currentProduct.id);

    _availableProducts[index].quantity++;
    notifyListeners();
  }

  void revertCart() {
    _productsInCart.forEach((id, num) {
      int index = _availableProducts.indexWhere((product) => product.id == id);
      _availableProducts[index].quantity += num;
    });
    _clearCart();
  }

  void removeItemsFromCart({@required int id, @required int number}) {
    int index = _availableProducts.indexWhere((product) => product.id == id);
    _availableProducts[index].quantity += number;
    _productsInCart.remove(id);
    notifyListeners();
  }

  ///POS batches
  List<Product> get posProductList {
    return _availableProducts.isEmpty
        ? []
        : List<Product>.from(_availableProducts);
  }

  // Returns the product instance matching the provided id.
  Product getProductById(int id) {
    Product _product;
    try {
      _product =
          _availableProducts.firstWhere((Product product) => product.id == id);
    } catch (e) {
      _product = null;
    }
    return _product;
  }
}
