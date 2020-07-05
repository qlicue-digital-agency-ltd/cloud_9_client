import 'package:cloud_9_client/models/product.dart';
import 'package:cloud_9_client/models/transaction_service.dart';
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
  final Product product;
  final TransactionService transactionService;
  final String date;

  Transaction({
    @required this.id,
    @required this.uuid,
    @required this.type,
    @required this.amount,
    @required this.userId,
    @required this.transactionableType,
    @required this.transactionableId,
    @required this.agentUuid,
    @required this.product,
    @required this.transactionService,
    @required this.date,
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
        userId = int.parse(map['user_id'].toString()),
        transactionableType = map['transactionable_type'],
        transactionableId = int.parse(map['transactionable_id'].toString()),
        agentUuid = map['agent_uuid'],
        date = map['created_at'],
        product = map['transactionable_type'] == "App\\Product"
            ? Product.fromMap(map['transactionable'])
            : null,
        transactionService = map['transactionable_type'] != "App\\Product"
            ? TransactionService.fromMap(map['transactionable'])
            : null;
}
