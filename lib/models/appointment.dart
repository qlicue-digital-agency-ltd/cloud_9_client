import 'package:cloud_9_client/models/appointmentable.dart';
import 'package:flutter/material.dart';

class Appointment {
  final int id;
  final String date;
  final int userId;
  final String appointmentableType;
  final int appointmentableId;
  final String agentUuid;
  final Appointmentable appointmentable;

  Appointment({
    @required this.id,
    @required this.date,
    @required this.userId,
    @required this.appointmentableType,
    @required this.appointmentableId,
    @required this.agentUuid,
    @required this.appointmentable,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'date': date,
      'user_id': userId,
      'appointmentable_type': appointmentableType,
      'appointmentable_id': appointmentableId,
      'agent_uuid': agentUuid,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Appointment.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['user_id'] != null),
        id = map['id'],
        date = map['date'],
        userId = int.parse(map['user_id'].toString()),
        appointmentableType = map['appointmentable_type'],
        appointmentableId = int.parse(map['appointmentable_id'].toString()),
        agentUuid = map['agent_uuid'],
        appointmentable = Appointmentable.fromMap(map['appointmentable']);
}
