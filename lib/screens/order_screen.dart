import 'package:cloud_9_client/components/card/order_card.dart';
import 'package:cloud_9_client/components/tiles/no_item_tile.dart';
import 'package:cloud_9_client/constants/constants.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:cloud_9_client/provider/order_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _orderProvider = Provider.of<OrderProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context);

    Future<void> _getData() async {
      _orderProvider.fetchOrders(clientId: _authProvider.authenticatedUser.id);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: _orderProvider.isFetchingOrderData
          ? Center(child: CircularProgressIndicator())
          : _orderProvider.availableOrders.isEmpty
              ? Center(
                  child: NoItemTile(
                      icon: 'assets/icons/calendar.png',
                      title: 'No orders',
                      subtitle: 'Please there are no available consultation'),
                )
              : RefreshIndicator(
                  child: ListView.builder(
                      itemCount: _orderProvider.availableOrders.length,
                      itemBuilder: (context, index) {
                        return OrderCard(
                          order: _orderProvider.availableOrders[index],
                          orderListCardOnTap: () {
                            _orderProvider.selectOrder =
                                _orderProvider.availableOrders[index];
                            Navigator.pushNamed(context, orderDetailScreen);
                          },
                          orderMoreOnTap: () {},
                        );
                      }),
                  onRefresh: _getData),
    );
  }
}
