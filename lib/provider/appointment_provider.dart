import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/models/appointment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppointmentProvider with ChangeNotifier {
  //variable declaration
  bool _isFetchingAppointmentData = false;
  List<Appointment> _availableAppointments = [];

  AppointmentProvider() {
    fetchAppointments(clientId: 2);
  }

//getters
  bool get isFetchingAppointmentData => _isFetchingAppointmentData;
  List<Appointment> get availableAppointments => _availableAppointments;

  Future<bool> fetchAppointments({@required int clientId}) async {
    bool hasError = true;
    _isFetchingAppointmentData = true;
    notifyListeners();

    final List<Appointment> _fetchedAppointments = [];
    try {
      final http.Response response =
          await http.get(api + "appointment/client/" + clientId.toString());

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        data['appointments'].forEach((appointmentData) {
          final appointment = Appointment.fromMap(appointmentData);
          _fetchedAppointments.add(appointment);
        });
        hasError = false;
      }
    } catch (error) {
      print(error);
      hasError = true;
    }

    _availableAppointments = _fetchedAppointments;
    _isFetchingAppointmentData = false;
    print(_availableAppointments.length);
    notifyListeners();

    return hasError;
  }
}
