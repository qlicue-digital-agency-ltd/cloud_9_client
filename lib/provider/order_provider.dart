import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/models/order.dart';
import 'package:cloud_9_client/models/user.dart';
import 'package:cloud_9_client/shared/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderProvider with ChangeNotifier {
  SharedPref _sharedPref = SharedPref();
  User authenticatedUser;
  //constructor
  OrderProvider() {
    _sharedPref.read('user').then((value) {
      authenticatedUser = User.fromMap(value);
      fetchOrders(clientId: authenticatedUser.id);
    });
  }

  bool _isFetchingOrderData = false;

  List<Order> _availableOrders = [];

  bool get isFetchingOrderData => _isFetchingOrderData;

  List<Order> get availableOrders => _availableOrders;

//fetch orders
  Future<bool> fetchOrders({@required int clientId}) async {
    bool hasError = true;
    _isFetchingOrderData = true;
    notifyListeners();

    final List<Order> _fetchedOrders = [];
    try {
      final http.Response response = await http.get(api + "orders");

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        data['orders'].forEach((orderData) {
          final order = Order.fromMap(orderData);
          _fetchedOrders.add(order);
        });
        hasError = false;
      }
    } catch (error) {
      print(error);
      hasError = true;
    }

    _availableOrders = _fetchedOrders;
    _isFetchingOrderData = false;

    print(_availableOrders.length);
    notifyListeners();

    return hasError;
  }
}
