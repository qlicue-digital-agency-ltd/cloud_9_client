
import 'package:cloud_9_client/pages/auth/login_page.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// const api = "http://192.168.1.10:8000/api/";
// const api = "http://212.111.42.24/cloud9/api/";

const api = "http://cloud9.qlicue.co.tz/server/api/";
const apiCreateOder = api + "selcom/order/create";
const apiUssdPush = api + "selcom/order/pay";

class TokenService {
  String token;
  AuthProvider authProvider;




  TokenService._privateConstructor();

  static final TokenService _instance = TokenService._privateConstructor();

  factory TokenService() {
    return _instance;
  }

   logoutUser() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
        sharedPreference.clear();
        authProvider.setIsAuthenticated = false;
        authProvider.logout();

  }

}
