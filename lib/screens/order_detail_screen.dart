import 'package:cloud_9_client/components/buttons/mno_dropdown.dart';
import 'package:cloud_9_client/components/text-fields/rowed_text_field.dart';
import 'package:cloud_9_client/provider/order_provider.dart';
import 'package:cloud_9_client/utils/currency_convertor.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrderDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
        appBar: AppBar(title: Text('Order details')),
        body: _orderProvider.getSelectedOrder.paymentStatus == "null"
            ? CustomScrollView(slivers: [
                SliverList(
                    delegate: SliverChildListDelegate([
                  SizedBox(height: 10),
                  Card(
                    margin: EdgeInsets.only(
                      left: 10,
                      top: 10,
                      right: 10,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            'Use Pay Number',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Center(
                          child: Text(
                            '8	1	8	1	5	1	3	6',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            'USSD Payment Instructions',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MNODropdown(
                            items: _orderProvider.mnoList,
                            onChange: (val) {
                              _orderProvider.setSelectedMNO = val;
                            },
                            title: 'Select MNO',
                            value: _orderProvider.selectedMNO,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ])),
                SliverList(
                    delegate: SliverChildBuilderDelegate((_, int index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 10.0, right: 10.0, top: (index == 0 ? 20 : 0)),
                    child: Material(
                      elevation: 2,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _orderProvider.selectedMNO.instructions[index],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  );
                }, childCount: _orderProvider.selectedMNO.instructions.length)),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Card(
                    margin: EdgeInsets.only(
                      left: 10,
                      top: 10,
                      right: 10,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            'or Pay by Mastercard QR',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Scan QR and Pay',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: QrImage(
                            data: _orderProvider.getSelectedOrder.qr,
                            version: QrVersions.auto,
                            size: 200.0,
                          ),
                        ),
                        SizedBox(height: 40),
                        Divider(
                          indent: 5,
                          endIndent: 5,
                          color: Theme.of(context).primaryColor,
                        ),
                        Center(
                          child: Text(
                            'Order Details',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RowedTextField(
                                  title: 'Reference',
                                  subtitle:
                                      _orderProvider.getSelectedOrder.reference,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RowedTextField(
                                  title: 'Product',
                                  subtitle: _orderProvider.getSelectedOrder.product.name,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RowedTextField(
                                  title: 'Number of Items',
                                  subtitle:
                                      _orderProvider.getSelectedOrder.noOfItems,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RowedTextField(
                                  title: 'Phone',
                                  subtitle: '+' +
                                      _orderProvider
                                          .getSelectedOrder.buyerPhone,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RowedTextField(
                                  title: 'Amount',
                                  subtitle: currencyCovertor.currencyCovertor(
                                    amount: double.parse(
                                        _orderProvider.getSelectedOrder.amount),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RowedTextField(
                                  title: 'Status',
                                  subtitle: _orderProvider
                                              .getSelectedOrder.paymentStatus ==
                                          "null"
                                      ? "Not Paid"
                                      : _orderProvider
                                          .getSelectedOrder.paymentStatus,
                                ),
                              ),
                              Image.asset(
                                'assets/icons/cloud9_transparent_logo.png',
                                width: 80,
                                height: 80,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ])),
              ])
            : SingleChildScrollView(
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Container(
                          padding: EdgeInsets.all(20),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RowedTextField(
                                title: 'Reference',
                                subtitle:
                                    _orderProvider.getSelectedOrder.reference,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RowedTextField(
                                title: 'Product',
                                subtitle: _orderProvider
                                    .getSelectedOrder.product.name,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RowedTextField(
                                title: 'Number of Items',
                                subtitle:
                                    _orderProvider.getSelectedOrder.noOfItems,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RowedTextField(
                                title: 'Phone',
                                subtitle: '+' +
                                    _orderProvider.getSelectedOrder.buyerPhone,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RowedTextField(
                                title: 'Amount',
                                subtitle: currencyCovertor.currencyCovertor(
                                  amount: double.parse(
                                      _orderProvider.getSelectedOrder.amount),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RowedTextField(
                                title: 'Status',
                                subtitle: _orderProvider
                                            .getSelectedOrder.paymentStatus ==
                                        "null"
                                    ? "Not Paid"
                                    : _orderProvider
                                        .getSelectedOrder.paymentStatus,
                              ),
                            ),
                            Image.asset(
                              'assets/icons/cloud9_transparent_logo.png',
                              width: 80,
                              height: 80,
                            )
                          ]))
                    ],
                  ),
                ),
              )));
  }
}
