import 'package:cloud_9_client/models/order.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef OrderCardOnTap = Function();
typedef OrderMoreOnTap = Function();

class OrderCard extends StatelessWidget {
  final OrderCardOnTap orderListCardOnTap;
  final OrderMoreOnTap orderMoreOnTap;
  final Order order;

  const OrderCard(
      {Key key,
      @required this.orderListCardOnTap,
      @required this.orderMoreOnTap,
      @required this.order})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
   

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(15),
          child: ListTile(
            leading: Icon(
              FontAwesomeIcons.clipboard,
              color: order.paymentStatus == "null" ? Colors.red : Colors.blue,
            ),
            onTap: orderListCardOnTap,
            title: Text(
              order.product.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('No of Items:\t' + order.noOfItems),
                Text(
                  order.paymentStatus == "null"
                      ? "Not Paid"
                      : order.paymentStatus,
                ),
              ],
            ),
            trailing: IconButton(
                icon: Icon(Icons.more_vert), onPressed: orderMoreOnTap),
          )),
    );
  }
}
