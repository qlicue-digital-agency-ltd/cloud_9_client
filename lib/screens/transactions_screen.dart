import 'package:cloud_9_client/components/card/transaction_list_card.dart';
import 'package:cloud_9_client/components/tiles/no_item_tile.dart';
import 'package:cloud_9_client/models/transaction.dart';
import 'package:cloud_9_client/provider/transaction_provider.dart';
import 'package:cloud_9_client/screens/background.dart';
import 'package:cloud_9_client/screens/receipt_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _transactionProvider = Provider.of<TransactionProvider>(context);
    _showDialog(context, Transaction transaction) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text("Delete Transaction?"),
            content: Text("Transaction " +
                transaction.uuid +
                " will be deleted permanently"),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  "Delete",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _transactionProvider.deleteTransactions(
                      transaction: transaction);
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> _getData() async {
      _transactionProvider.fetchTransactions(clientId: 2);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transactions',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _transactionProvider.isFetchingTransactionData
          ? Center(child: CircularProgressIndicator())
          : _transactionProvider.availableTransactions.isEmpty
              ? Center(
                  child: NoItemTile(
                      icon: 'assets/icons/transaction.png',
                      title: 'No Transactions',
                      subtitle: 'Please by out products and book for services'),
                )
              : RefreshIndicator(
                  child: ListView.builder(
                      itemCount:
                          _transactionProvider.availableTransactions.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0),
                          child: TransactionListCard(
                            onDeleteTap: () {
                              _showDialog(
                                  context,
                                  _transactionProvider
                                      .availableTransactions[index]);
                            },
                            onViewTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReceiptScreen(
                                      transaction: _transactionProvider
                                          .availableTransactions[index],
                                    ),
                                  ));
                            },
                            transaction:
                                _transactionProvider.availableTransactions[index],
                          ),
                        );
                      }),
                  onRefresh: _getData),
    );
  }
}
