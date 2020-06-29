import 'dart:convert';

import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  //auto authenticate
  Future<User> autoAuthenticate() async {
    User _authenticatedUser;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    if (token != null) {
      final String userEmail = prefs.getString('email');
      final int userId = prefs.getInt('id');

      _authenticatedUser = User(
        id: userId,
        email: userEmail,
        token: token,
      );
    }
    return _authenticatedUser;
  }

  //logout
  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove('token');
    prefs.remove('email');
  }

  //sign
  //Sign in User function..
  Future<bool> signInUser(
      {@required String email, @required String password}) async {
    User _authenticatedUser;
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

    if (responseData.containsKey('token')) {
      hasError = false;

      _authenticatedUser = User(
        id: responseData['id'],
        token: responseData['token'],
        email: responseData['email'],
      );

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setInt('id', responseData['id']);
      prefs.setString('token', responseData['token']);
      prefs.setString('name', responseData['username']);
      prefs.setString('email', responseData['email']);
    } else {
      hasError = true;
    }
    return hasError;
  }
}
