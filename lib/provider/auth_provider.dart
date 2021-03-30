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
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider() {
    autoAuthenticate();
  }

  File file;
  Country _selectedCountry = Country.TZ;

  User _authenticatedUser;
  final List<String> _genderList = [
    'male',
    'female',
  ];

  bool _hasUserProfile = false;
  bool _isAuthenticated = false;
  bool _isSignInUser = false;
  bool _isSubmitingProfileData = false;
  File _pickedImage;
  String _selectedGender = "male";
  SharedPref _sharedPref = SharedPref();

  void chooseAmImage() async {
    // ignore: deprecated_member_use
    file = await ImagePicker.pickImage(source: ImageSource.gallery);

    _pickedImage = file;
// file = await ImagePicker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  //get the choosen Image.
  Country get selectedCountry => _selectedCountry;

  File get pickedImage => _pickedImage;

  bool get isSignInUser => _isSignInUser;

  bool get isSubmitingProfileData => _isSubmitingProfileData;

  bool get isAuthenticated => _isAuthenticated;

  bool get hasUserProfile => _hasUserProfile;

  String get selectedGender => _selectedGender;

  List<String> get genderList => _genderList;

  set setSelectedGender(String gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  set setSelectedCountry(Country country) {
    _selectedCountry = country;
    notifyListeners();
  }

  Future<bool> autoAuthenticate() async {
    await _sharedPref.readSingleString('token').then((token) {
      if (token != null) {
        _sharedPref.read('user').then((value) {
          _authenticatedUser = User.fromMap(value);
          if (_authenticatedUser.profile.fullname != null) {
            _hasUserProfile = true;
          }
          _isAuthenticated = true;
        });
      }
    });

    notifyListeners();

    return true;
  }

  Future<void> logout() async {
    // _sharedPref.remove('id');
    // _sharedPref.remove('token');
    // _sharedPref.remove('email');
    // _sharedPref.remove('profile');

    SharedPreferences.getInstance()
        .then((sharedPreference) => sharedPreference.clear());

    notifyListeners();
  }

  User get authenticatedUser {
    return _authenticatedUser;
  }

  //Sign in User function..
  Future<Map<String, dynamic>> signInUser(
      {@required String email, @required String password}) async {
    _isSignInUser = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    bool hasError = true;
    http.Response response;

    try {
      response = await http.post(
        api + "login",
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );

      log(response.statusCode.toString(), name: 'INN');
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData.containsKey('access_token')) {
        hasError = false;

        _authenticatedUser = User.fromMap(responseData['user']);

        _sharedPref.save('user', responseData['user']);
        _sharedPref.saveSingleString('token', responseData['access_token']);
      } else {
        print('XXXXXXXXXXXXXXXXXXXXXXXXXX');
        hasError = true;
      }
      _isSignInUser = false;
      notifyListeners();

      return {
        'status': responseData['status'],
        'message': responseData['message']
      };
    } on SocketException {
      return {'status': false, 'message': 'Network, please try again'};
    } on FormatException catch (e) {
      return {
        'status': false,
        'message':
            'Unable to process the request, please try again:${e.message}'
      };
    } catch (e) {
      return {
        'status': false,
        'message': 'Something went wrong, please try again'
      };
    }

    // log('QQQQQQQQQQQQQQQQQQQQQ');
  }

  //Register in User function..
  Future<Map<String, dynamic>> registerUser(
      {@required String email, @required String password}) async {
    _isSignInUser = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      "role": "client"
    };

    final http.Response response = await http.post(
      api + "signup",
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;

    print(responseData);

    if (responseData.containsKey('access_token')) {
      hasError = false;

      _authenticatedUser = User.fromMap(responseData['user']);
      _sharedPref.save('user', responseData['user']);
      _sharedPref.saveSingleString('token', responseData['access_token']);
    } else {
      hasError = true;
    }
    _isSignInUser = false;
    notifyListeners();
    return {
      'status': responseData['status'],
      'message': responseData['message']
    };
  }

  Future<Map<String,dynamic>> updateFCMToken({@required String fcmToken,@required  int userId}) async {
    final Map<String, dynamic> data = {
      'fcm_token': fcmToken,
      'user_id': userId,
    };

    bool hasError = true;
    http.Response response;

    try {
      response = await http.post(
        api + "fcmToken",
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'},
      );


      final Map<String, dynamic> responseData = json.decode(response.body);


      _authenticatedUser = User.fromMap(responseData['user']);


      _sharedPref.save('user', responseData['user']);
    } on SocketException {
      return {'status': false, 'message': 'Network, please try again'};
    } on FormatException catch (e) {
      return {
        'status': false,
        'message':
            'Unable to process the request, please try again:${e.message}'
      };
    } catch (e) {
      return {
        'status': false,
        'message': 'Something went wrong, please try again'
      };
    }
    return {

    };
  }

//update profile
  Future<bool> updateProfile(
      {@required String fullname,
      @required String phone,
      @required String location}) async {
    print('tooooooo');
    print(_authenticatedUser.id);
    print('tooooooo');
    _isSubmitingProfileData = true;
    bool hasError = false;
    notifyListeners();

    Dio dio = new Dio();
    FormData formData = new FormData.fromMap({
      "registration_number": "CL900000",
      "fullname": fullname,
      "phone": phone,
      "location": location,
      "position": "client",
      "gender": _selectedGender,
      "file": await MultipartFile.fromFile(_pickedImage.path,
          filename: "upload.png"),
    });
    // print(_authenticatedUser.profile.id.toString());
    await dio
        .post(api + "editProfile/" + _authenticatedUser.id.toString(),
            data: formData,
            options: Options(
                method: 'POST',
                responseType: ResponseType.json // or ResponseType.JSON
                ))
        .then((response) {
      final Map<String, dynamic> data = response.data;

      print(data);
      if (response.statusCode == 201) {
        hasError = false;

        _authenticatedUser = User.fromMap(data['user']);

        _sharedPref.save('user', data['user']);
        _sharedPref.saveSingleString('profile', 'profile');
      } else {
        hasError = true;
      }
    }).catchError((error) {
      print(error);
      hasError = true;
    });

    _isSubmitingProfileData = false;
    resetImage();
    notifyListeners();
    return hasError;
  }

  void resetImage() {
    _pickedImage = null;
    notifyListeners();
  }
}
