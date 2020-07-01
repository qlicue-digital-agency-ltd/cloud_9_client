import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/models/category.dart';
import 'package:cloud_9_client/models/service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryProvider with ChangeNotifier {
  //variable declaration
  bool _isFetchingCategoryData = false;
  List<Category> _availableCategories = [];
  List<Service> _availableServices = [];

  CategoryProvider() {
    fetchCategories();
  }

//getters
  bool get isFetchingCategoryData => _isFetchingCategoryData;
  List<Category> get availableCategories => _availableCategories;
  List<Service> get availableServices => _availableServices;

  //setters
  set setSelectedServiceList(List<Service> serviceList) {
    _availableServices = serviceList;
    notifyListeners();
  }

  set setSelectedCategory(int id) {
    for (Category category in _availableCategories)
      if (category.isSelected) {
        category.isSelected = !category.isSelected;
        print(category.isSelected);
      }
    _availableCategories
        .firstWhere((category) => category.id == id)
        .isSelected = true;
    notifyListeners();
  }

//http requests
  Future<bool> fetchCategories() async {
    bool hasError = true;
    _isFetchingCategoryData = true;
    notifyListeners();

    final List<Category> _fetchedCategories = [];
    try {
      final http.Response response = await http.get(api + "categories");

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        data['categories'].forEach((categoryData) {
          final category = Category.fromMap(categoryData);
          _fetchedCategories.add(category);
        });
        hasError = false;
      }
    } catch (error) {
      print(error);
      hasError = true;
    }

    _availableCategories = _fetchedCategories;
    _availableServices = _fetchedCategories[0].services;
    _isFetchingCategoryData = false;
    print(_availableCategories);
    notifyListeners();

    return hasError;
  }
}
