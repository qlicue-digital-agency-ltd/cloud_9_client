import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/models/user.dart';
import 'package:cloud_9_client/shared/shared_preference.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_country_picker/country.dart';

class PaymentProvider with ChangeNotifier {
  Country _selectedCountry = Country.TZ;

  bool _isSubmitingPaymentData = false;

  //get the choosen Image.
  Country get selectedCountry => _selectedCountry;

  bool get isSubmitingPaymentData => _isSubmitingPaymentData;

  set setSelectedCountry(Country country) {
    _selectedCountry = country;
    notifyListeners();
  }

  //Sign in User function..
  Future<bool> createOrder(
      {@required int userId,
      @required String paymentPhone,
      @required double amount}) async {
    notifyListeners();
    final Map<String, dynamic> authData = {
      'user_id': userId,
      'payment_phone': paymentPhone,
      'amount': amount,
    };

    final http.Response response = await http.post(
      apiCreateOder,
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
    );

    log('QQQQQQQQQQQQQQQQQQQQQ');
    print(response.body.toString());
    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;

    if (responseData.containsKey('order')) {

      //add to order list
      hasError = false;
      switch (paymentPhone.substring(3, 4)) {
        case "71":
        case "67":
        case "65":
        case "78":
        case "68":
        case "69":
          sendUssdPush(orderId: responseData['order']['id'].toString());
          break;
        default:
      }
    } else {
      hasError = true;
    }

    notifyListeners();
    return hasError;
  }

  //Register in User function..
  Future<bool> sendUssdPush({@required String orderId}) async {
    final Map<String, dynamic> authData = {
      'order_id': orderId,
    };

    final http.Response response = await http.post(
      apiUssdPush,
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    print(responseData);

    notifyListeners();
    return hasError;
  }
}
