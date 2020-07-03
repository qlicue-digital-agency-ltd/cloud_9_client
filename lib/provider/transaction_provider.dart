import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TransactionProvider with ChangeNotifier {
  //variable declaration
  bool _isFetchingTransactionData = false;
  bool _isdeletingTransactionData = false;
  List<Transaction> _availableTransactions = [];

  TransactionProvider() {
    fetchTransactions(clientId: 2);
  }

//getters
  bool get isFetchingTransactionData => _isFetchingTransactionData;
  bool get isdeletingTransactionData => _isdeletingTransactionData;
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

  Future<bool> deleteTransactions({@required Transaction transaction}) async {
    bool hasError = true;
    _isFetchingTransactionData = true;
    notifyListeners();

    try {
      final http.Response response =
          await http.delete(api + "transaction/" + transaction.id.toString());
      if (response.statusCode == 201) {
        hasError = false;
      }
    } catch (error) {
      hasError = true;
    }

    int _index = _availableTransactions
        .indexWhere((element) => element.id == transaction.id);
    _availableTransactions.removeAt(_index);
    _isFetchingTransactionData = false;
    print(_availableTransactions.length);
    notifyListeners();

    return hasError;
  }
}
