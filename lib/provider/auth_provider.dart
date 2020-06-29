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
    final String token = _sharedPref.read('token');
    if (token != null) {
      final String userEmail = _sharedPref.read('email');
      final int userId = _sharedPref.read('id');

      _authenticatedUser = User(
        id: userId,
        email: userEmail,
        token: token,
      );

      _userSubject.add(true);
    }

    notifyListeners();
  }

  Future<void> logout() async {
    userSubject.add(false);
    notifyListeners();

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
      api + "register",
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
    );

    print(response.body);

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;

    if (responseData.containsKey('token')) {
      hasError = false;

      _authenticatedUser = User(
        id: responseData['id'],
        token: responseData['token'],
        email: responseData['email'],
      );
      _userSubject.add(true);

      _sharedPref.save('id', responseData['id']);
      _sharedPref.save('token', responseData['token']);
      _sharedPref.save('email', responseData['email']);
      
    } else {
      hasError = true;
    }
    _isSignInUser = false;
    notifyListeners();
    return hasError;
  }
}
