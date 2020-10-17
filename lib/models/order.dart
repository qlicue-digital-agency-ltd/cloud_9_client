import 'package:flutter/material.dart';

class Order {
  final int id;
  final String uuid;

  final int userId;
  final String status;
  final String agentUuid;

  Order({
    @required this.id,
    @required this.uuid,

    @required this.userId,
    @required this.status,
    @required this.agentUuid,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'uuid': uuid,
      
      'user_id': userId,
      'status': status,
      'agent_uuid': agentUuid
    };
    if (id != null) {
      map['id'] = id;
    }
    map['uuid'] = uuid;
    return map;
  }

  Order.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['uuid'] != null),
        id = map['id'],
        uuid = map['uuid'],
        userId = int.parse(map['user_id'].toString()),
        status = map['status'],
        agentUuid = map['agent_uuid'];
}
