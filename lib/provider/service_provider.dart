import 'dart:io';

import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/models/service.dart';
import 'package:cloud_9_client/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'auth_provider.dart';

class ServiceProvider with ChangeNotifier {

  ServiceProvider() {
    fetchServices();
  }
  //variable declaration
  bool _isFetchingServiceData = false;
  List<Service> _availableServices = [];

//getters
  bool get isFetchingServiceData => _isFetchingServiceData;
  List<Service> get availableServices => _availableServices;

  //setters
  set setSelectedServiceList(List<Service> serviceList) {
    _availableServices = serviceList;
    notifyListeners();
  }

  Future<bool> fetchServices() async {
    bool hasError = true;
    _isFetchingServiceData = true;
    notifyListeners();

    final List<Service> _fetchedServices = [];
    try {
      final http.Response response = await http.get(api + "services",headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader: 'Bearer ${TokenService().token}'});

      final Map<String, dynamic> data = json.decode(response.body);


      if (response.statusCode == 200) {
        data['services'].forEach((serviceData) {
          final service = Service.fromMap(serviceData);
          _fetchedServices.add(service);
        });
        hasError = false;
      }
    } catch (error) {
      print(error);
      hasError = true;
    }

    _availableServices = _fetchedServices;
    _isFetchingServiceData = false;
    print(_availableServices.length);
    notifyListeners();

    return hasError;
  }
}
