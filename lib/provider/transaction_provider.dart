import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TransactionProvider with ChangeNotifier {
  //variable declaration
  bool _isFetchingTransactionData = false;
  List<Transaction> _availableTransactions = [];

  TransactionProvider() {
    fetchTransactions(clientId: 2);
  }

//getters
  bool get isFetchingTransactionData => _isFetchingTransactionData;
  List<Transaction> get availableTransactions => _availableTransactions;

  Future<bool> fetchTransactions({@required int clientId}) async {
    bool hasError = true;
    _isFetchingTransactionData = true;
    notifyListeners();

    final List<Transaction> _fetchedTransactions = [];
    try {
      final http.Response response =
          await http.get(api + "transactions/client/" + clientId.toString());

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        data['transactions'].forEach((transactionData) {
          final transaction = Transaction.fromMap(transactionData);
          _fetchedTransactions.add(transaction);
        });
        hasError = false;
      }
    } catch (error) {
      print(error);
      hasError = true;
    }

    _availableTransactions = _fetchedTransactions;
    _isFetchingTransactionData = false;
    print(_availableTransactions.length);
    notifyListeners();

    return hasError;
  }
}
