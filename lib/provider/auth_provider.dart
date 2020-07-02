import 'dart:convert';

import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/models/user.dart';
import 'package:cloud_9_client/shared/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  SharedPref _sharedPref = SharedPref();
  User _authenticatedUser;
  bool _isSignInUser = false;

  PublishSubject<bool> _userSubject = PublishSubject();

  //getters

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  bool get isSignInUser => _isSignInUser;

  Future<void> autoAuthenticate() async {
    _sharedPref.readSingleString('token').then((token) {
      if (token != null) {
        //   _authenticatedUser = User.fromMap(_sharedPref.read('user'));
      }
    });

    notifyListeners();
  }

  Future<void> logout() async {
    _sharedPref.remove('id');
    _sharedPref.remove('token');
    _sharedPref.remove('email');

    notifyListeners();
  }

  User get authenticatedUser {
    return _authenticatedUser;
  }

  //Sign in User function..
  Future<bool> signInUser(
      {@required String email, @required String password}) async {
    _isSignInUser = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final http.Response response = await http.post(
      api + "login",
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;

    if (responseData.containsKey('access_token')) {
      hasError = false;

      _authenticatedUser = User.fromMap(responseData['user']);
      print('loveeeeee---------eeeeeeeee');
      print(_authenticatedUser);
      print('=======loveeeeeeeeeeeeeee');
      _sharedPref.save('user', responseData['user']);
      _sharedPref.saveSingleString('token', responseData['access_token']);
    } else {
      hasError = true;
    }
    _isSignInUser = false;
    notifyListeners();
    return hasError;
  }
}
