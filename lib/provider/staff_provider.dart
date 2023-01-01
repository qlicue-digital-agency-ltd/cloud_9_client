import 'dart:io';

import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/models/doctor.dart';
import 'package:cloud_9_client/models/nurse.dart';
import 'package:cloud_9_client/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'auth_provider.dart';

class StaffProvider with ChangeNotifier {

  //variable declaration
  bool _isFetchingDoctorData = false;
  bool _isFetchingNurseData = false;
  
  List<Doctor> _availabledoctors = [];
  List<Nurse> _availablenurses = [];

  StaffProvider() {
    fetchdoctors();
    fetchnurses();
  }

//getters
  bool get isFetchingDoctorData => _isFetchingDoctorData;
  bool get isFetchingNurseData => _isFetchingNurseData;
  List<Doctor> get availabledoctors => _availabledoctors;
  List<Nurse> get availablenurses => _availablenurses;

//http requests
  Future<bool> fetchdoctors() async {
    bool hasError = true;
    _isFetchingDoctorData = true;
    notifyListeners();

    final List<Doctor> _fetcheddoctors = [];
    try {
      final http.Response response = await http.get(api + "doctors", headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader: 'Bearer ${TokenService().token}'});

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        print(data['doctors']);
        data['doctors'].forEach((doctorData) {
          final doctor = Doctor.fromMap(doctorData);
          _fetcheddoctors.add(doctor);
        });
        hasError = false;
      }
    } catch (error) {
      print(error);
      hasError = true;
    }

    _availabledoctors = _fetcheddoctors;
    _isFetchingDoctorData = false;
    print(_availabledoctors);
    notifyListeners();

    return hasError;
  }

  //http requests
  Future<bool> fetchnurses() async {
    bool hasError = true;
    _isFetchingNurseData = true;
    notifyListeners();

    final List<Nurse> _fetchedNurses = [];
    try {
      final http.Response response = await http.get(api + "nurses",headers: {HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader: 'Bearer ${TokenService().token}'});

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        print(data['nurses']);
        data['nurses'].forEach((nurseData) {
          final nurse = Nurse.fromMap(nurseData);
          _fetchedNurses.add(nurse);
        });
        hasError = false;
      }
    } catch (error) {
      print(error);
      hasError = true;
    }

    _availablenurses = _fetchedNurses;
    _isFetchingNurseData = false;
    print(_availablenurses);
    notifyListeners();

    return hasError;
  }
}
