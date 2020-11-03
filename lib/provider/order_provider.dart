import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/models/mno.dart';
import 'package:cloud_9_client/models/order.dart';
import 'package:cloud_9_client/models/user.dart';
import 'package:cloud_9_client/shared/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/country.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderProvider with ChangeNotifier {
  SharedPref _sharedPref = SharedPref();
  User authenticatedUser;
  Country _selectedCountry = Country.TZ;

  bool _isSubmitingPaymentData = false;
  MNO _selectedMNO = automnoList[0];
  List<MNO> _mnoList;

  getMNOList() {
    _mnoList = automnoList;
    notifyListeners();
  }

  //get the choosen Image.
  Country get selectedCountry => _selectedCountry;

  bool get isSubmitingPaymentData => _isSubmitingPaymentData;
  List<MNO> get mnoList => _mnoList;
  MNO get selectedMNO => _selectedMNO;

  set setSelectedMNO(MNO mno) {
    _selectedMNO = mno;
    notifyListeners();
  }

  set setSelectedCountry(Country country) {
    _selectedCountry = country;
    notifyListeners();
  }

  //constructor
  OrderProvider() {
    getMNOList();
    _sharedPref.read('user').then((value) {
      authenticatedUser = User.fromMap(value);
      fetchOrders(clientId: authenticatedUser.id);
    });
  }

  bool _isFetchingOrderData = false;

  List<Order> _availableOrders = [];

  bool get isFetchingOrderData => _isFetchingOrderData;

  List<Order> get availableOrders => _availableOrders;
  Order _selecetedOrder;

  //setter
  set selectOrder(Order order) {
    _selecetedOrder = order;
    notifyListeners();
  }

  /// getter
  Order get getSelectedOrder => _selecetedOrder;

//fetch orders
  Future<bool> fetchOrders({@required int clientId}) async {
    bool hasError = true;
    _isFetchingOrderData = true;
    notifyListeners();

    final List<Order> _fetchedOrders = [];
    try {
      final http.Response response =
          await http.get(api + "selcom/orders/" + clientId.toString());

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

  //Sign in User function..
  Future<bool> createOrder(
      {@required int userId,
      @required String paymentPhone,
      @required String agentCode,
      @required int productId,
      @required int noOfItems}) async {
    _isSubmitingPaymentData = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'user_id': userId,
      'payment_phone': paymentPhone,
      'product_id': productId,
      'no_of_items': noOfItems,
      'agent_code':agentCode,
    };

    final http.Response response = await http.post(
      apiCreateOder,
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
    );

    print(response.body.toString());
    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;

    if (responseData.containsKey('order')) {
      //add to order list
      hasError = false;
      final _order = Order.fromMap(responseData['order']);
      _availableOrders.add(_order);
      selectOrder = _order;
      switch (paymentPhone.substring(3, 5)) {
        case "71":
        case "67":
        case "65":
        case "78":
        case "68":
        case "69":
          sendUssdPush(orderId: _order.id.toString());
          break;
        default:
      }
    } else {
      hasError = true;
    }
    _isSubmitingPaymentData = false;
    notifyListeners();
    return hasError;
  }

  //Register in User function..
  Future<bool> sendUssdPush({@required String orderId}) async {
    final Map<String, dynamic> _data = {
      'order_id': orderId,
    };

    final http.Response response = await http.post(
      apiUssdPush,
      body: json.encode(_data),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    print('++++++++++++++++++++++++++++++');
    print(responseData);
    print('++++++++++++++++++++++++++++++');
    notifyListeners();
    return hasError;
  }
}
