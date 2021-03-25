import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/models/appointment.dart';
import 'package:cloud_9_client/models/user.dart';
import 'package:cloud_9_client/shared/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppointmentProvider with ChangeNotifier {
  //variable declaration
  bool _isFetchingAppointmentData = false;
  bool _isCreatingAppointmentData = false;
  List<Appointment> _availableAppointments = [];
  SharedPref _sharedPref = SharedPref();
  User authenticatedUser;

  AppointmentProvider() {
    _sharedPref.read('user').then((value) {
      authenticatedUser = User.fromMap(value);
      fetchAppointments(clientId: authenticatedUser.id);
    });
  }

//getters
  bool get isFetchingAppointmentData => _isFetchingAppointmentData;

  bool get isCreatingAppointmentData => _isCreatingAppointmentData;
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

      print('RRRRRRRRR');
      print(data);

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

  Future<Map<String,dynamic>> postProcedureAppointment({
    @required String agentUuid,
    @required int userId,
    @required String date,
    @required int serviceId,
    @required String phoneNumber,
  }) async {
    bool hasError = true;
    Appointment _appointment ;
    _isCreatingAppointmentData = true;
    notifyListeners();

    final Map<String, dynamic> appointmentData = {
      'date': date,
      'user_id': userId,
      'agent_uuid': agentUuid,
      'status': 'booked',
      'orderable_type': 'App\\Procedure',
      'orderable_id': serviceId,
      'no_of_items': 1,
      'payment_phone': phoneNumber
    };

    print("+++++++++++++++++++++++");
    print(appointmentData);
    print("+++++++++++++++++++++++");
    try {
      final http.Response response = await http.post(
        api + "procedure/appointment/" + serviceId.toString(),
        body: json.encode(appointmentData),
        headers: {'Content-Type': 'application/json'},
      );

      final Map<String, dynamic> data = json.decode(response.body);
      print('RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR');
      print(data);
      if (response.statusCode == 201) {
        // print(data);
         _appointment = Appointment.fromMap(data['appointment']);
        hasError = false;
      }
    } catch (error) {
      print(error);
      hasError = true;
    }
    _isCreatingAppointmentData = false;

    notifyListeners();
    fetchAppointments(clientId: userId);

    return {'success':! hasError, 'appointment':_appointment};
  }

  ///consultation.........
  Future<Map<String,dynamic>> postConsultationAppointment({
    @required String agentUuid,
    @required String date,
    @required int userId,
    @required String phoneNumber,
    @required int consultationId,
  }) async {
    bool hasError = true;
    Appointment _appointment ;
    _isCreatingAppointmentData = true;
    notifyListeners();

    final Map<String, dynamic> appointmentData = {
      'date': date,
      'user_id': userId,
      'agent_uuid': agentUuid,
      'status': 'booked',
      'orderable_type': 'App\\Consultation',
      'orderable_id': consultationId,
      'no_of_items': 1,
      'payment_phone': phoneNumber
    };

    print("+++++++++++++++++++++++");
    print(appointmentData);
    try {
      final http.Response response = await http.post(
        api + "consultation/appointment/" + consultationId.toString(),
        body: json.encode(appointmentData),
        headers: {'Content-Type': 'application/json'},
      );

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 201) {
        _appointment = Appointment.fromMap(data['appointment']);
        hasError = false;
      }
    } catch (error) {
      print(error);
      hasError = true;
    }
    _isCreatingAppointmentData = false;

    notifyListeners();
    fetchAppointments(clientId: userId);

    return {'success': !hasError , 'appointment' : _appointment};
  }
}
