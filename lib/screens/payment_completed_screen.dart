import 'package:cloud_9_client/components/text-fields/rowed_text_field.dart';
import 'package:cloud_9_client/models/order.dart';
import 'package:cloud_9_client/provider/order_provider.dart';
import 'package:cloud_9_client/utils/currency_convertor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sticky_headers/sticky_headers.dart';

class PaymentCompleted extends StatelessWidget {
  final Order order;

  const PaymentCompleted({Key key, @required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    orderProvider.updateOrderStatus(order);
    return Scaffold(
      appBar: AppBar(
        title: Text('PAYMENT ${order.paymentStatus}'),
      ),
      body: SingleChildScrollView(
        child: StickyHeader(
          header: Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Your payment is ${order.paymentStatus.toLowerCase()} !!",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          )),
          content: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowedTextField(
                  title: 'Reference',
                  subtitle: order.reference,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowedTextField(
                  title: 'Order Type',
                  subtitle: order.orderFor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowedTextField(
                  title: 'Number of Items',
                  subtitle: order.noOfItems,
                ),
              ),
              order.product != null ?
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowedTextField(title: 'Product', subtitle: order.product.name),
              ) : Container(),
              order.service != null ?
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RowedTextField(title: 'Service', subtitle: order.service.title,),
                  ) : Container(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowedTextField(
                  title: 'Phone',
                  subtitle: '+' + order.buyerPhone,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowedTextField(
                  title: 'Amount',
                  subtitle: currencyCovertor.currencyCovertor(
                    amount: double.parse(order.amount),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowedTextField(
                  title: 'Status',
                  subtitle: order.paymentStatus == "null"
                      ? "Not Paid"
                      : order.paymentStatus,
                ),
              ),
              SizedBox(height: 15,),
              Image.asset(
                'assets/icons/cloud9_transparent_logo.png',
                width: 80,
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
