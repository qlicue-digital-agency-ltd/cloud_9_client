import 'dart:convert';

import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/models/appointment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppointmentService {

  //  get client appointments...........
  getClientAppointments({@required int clientId}) async {
    List<Appointment> _fetchedAppointments = <Appointment>[];
    final http.Response response = await http.get(
      api + "appointment/client/" + clientId.toString(),
      headers: {'Content-Type': 'application/json'},
    );
    final Map<String, dynamic> data = json.decode(response.body);
    if (response.statusCode == 200) {
      data['appointments'].forEach((appointmentData) {
        final appointment = Appointment.fromMap(appointmentData);
        _fetchedAppointments.add(appointment);
      });
    }
    return _fetchedAppointments;
  }

  //post client appointments
}
