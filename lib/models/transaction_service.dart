import 'package:flutter/material.dart';

class TransactionService {
  final int id;
  final String startTime;
  final String endTime;
  final String date;
  final int serviceId;
  final String practionerUuid;

  TransactionService(
      {@required this.id,
      @required this.date,
      @required this.startTime,
      @required this.endTime,
      @required this.serviceId,
      @required this.practionerUuid});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'service_id': serviceId,
      'practioner_uuid': practionerUuid,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  TransactionService.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['practioner_uuid'] != null),
        id = map['id'],
        date = map['date'],
        startTime = map['start_time'],
        endTime = map['end_time'],
        serviceId = int.parse(map['service_id'].toString()),
        practionerUuid = map['practioner_uuid'];
}
