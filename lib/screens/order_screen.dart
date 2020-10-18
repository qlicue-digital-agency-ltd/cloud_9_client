import 'package:cloud_9_client/components/card/order_card.dart';
import 'package:cloud_9_client/components/tiles/no_item_tile.dart';
import 'package:cloud_9_client/constants/constants.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:cloud_9_client/provider/order_provider.dart';
import 'package:cloud_9_client/screens/background.dart';

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

    return Background(
        screen: SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
            SliverAppBar(
              elevation: 0,
              expandedHeight: 120.0,
              backgroundColor: Colors.transparent,
              actions: <Widget>[Container()],
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                title: Text(
                  'My Orders',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(height: 10),
            ])),
          ],
          body: _orderProvider.isFetchingOrderData
              ? Center(child: CircularProgressIndicator())
              : _orderProvider.availableOrders.isEmpty
                  ? Center(
                      child: NoItemTile(
                          icon: 'assets/icons/calendar.png',
                          title: 'No orders',
                          subtitle:
                              'Please there are no available consultation'),
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
        ),
      ),
    ));
  }
}
