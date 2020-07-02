import 'package:flutter/material.dart';

class Transaction {
  final int id;
  final String type;
  final double amount;
  final String uuid;
  final int userId;
  final String transactionableType;
  final int transactionableId;
  final String agentUuid;

  Transaction({
    @required this.id,
    @required this.uuid,
    @required this.type,
    @required this.amount,
    @required this.userId,
    @required this.transactionableType,
    @required this.transactionableId,
    @required this.agentUuid,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'uuid': uuid,
      'type': type,
      'amount': amount,
      'user_id': userId,
      'transactionable_type': transactionableType,
      'transactionable_id': transactionableId,
      'agent_uuid': agentUuid
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Transaction.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        id = map['id'],
        uuid = map['uuid'],
        type = map['type'],
        amount = double.parse(map['amount'].toString()),
        userId = map['user_id'],
        transactionableType = map['transactionable_type'],
        transactionableId = map['transactionable_id'],
        agentUuid = map['agent_uuid'];
}
