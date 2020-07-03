import 'package:cloud_9_client/models/transaction.dart';
import 'package:cloud_9_client/screens/background.dart';
import 'package:flutter/material.dart';

class ReceiptScreen extends StatelessWidget {
  final Transaction transaction;

  const ReceiptScreen({Key key, @required this.transaction}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Background(
        screen: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text('Receipt'),
                actions: <Widget>[
                  IconButton(icon: Icon(Icons.share), onPressed: () {})
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/icons/cloud9_logo.jpg',
                      ),
                      radius: 50,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    transaction.product == null
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, bottom: 30),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Service:'),
                                  Text(transaction.transactionService.serviceId
                                      .toString())
                                ]),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, bottom: 30),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Product:'),
                                  Text(transaction.product.name)
                                ]),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 30),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Receipt No:'),
                            Text("CL9000" + transaction.id.toString())
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 30),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Date:'), Text(transaction.date)]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 30),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Amount:'),
                            Text(
                                'TZS ' + transaction.amount.toString() + ' /-,')
                          ]),
                    ),
                    Divider(
                      indent: 10,
                      endIndent: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 30),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('TOTAL:'),
                            Text(
                                'TZS ' + transaction.amount.toString() + ' /-,')
                          ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(
                              '--------------------------------------------',
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            ))
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 30),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(
                              'Thank you for you purchase',
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            ))
                          ]),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, bottom: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('Contacts')]),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, bottom: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Phone'),
                            SizedBox(
                              width: 10,
                            ),
                            Text('+255-765-045-856')
                          ]),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, bottom: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Email'),
                            SizedBox(
                              width: 10,
                            ),
                            Text('info@cloud9.co.tz')
                          ]),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
