import 'package:cloud_9_client/components/card/item_card.dart';
import 'package:cloud_9_client/components/card/order_card.dart';
import 'package:cloud_9_client/components/card/transaction_list_card.dart';
import 'package:cloud_9_client/components/tiles/no_item_tile.dart';
import 'package:cloud_9_client/constants/constants.dart';
import 'package:cloud_9_client/models/order.dart';
import 'package:cloud_9_client/models/transaction.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:cloud_9_client/provider/order_provider.dart';
import 'package:cloud_9_client/provider/product_provider.dart';
import 'package:cloud_9_client/provider/service_provider.dart';
import 'package:cloud_9_client/screens/product_details_screen.dart';

import 'package:cloud_9_client/screens/receipt_screen.dart';
import 'package:cloud_9_client/screens/set_appointment_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  bool _showProducts;
  bool isBottomSheetVisible = false;
  bool _showFloatingButtonText = true;
  ScrollController _scrollController = ScrollController();


  @override
  void dispose() {
    _scrollController.removeListener(() {});
    super.dispose();
  }

  scrollController(){
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _showFloatingButtonText = false;
        });
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _showFloatingButtonText = true;
        });
      }
    });
  }

  PersistentBottomSheetController _controller;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _showProducts = false;
    scrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _serviceProvider = Provider.of<ServiceProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context);
    final _orderProvider = Provider.of<OrderProvider>(context);
    final _productProvider = Provider.of<ProductProvider>(context);

    // _showDialog(context, Transaction transaction) {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       // return object of type Dialog
    //       return AlertDialog(
    //         title: Text("Delete Transaction?"),
    //         content: Text("Transaction " +
    //             transaction.uuid +
    //             " will be deleted permanently"),
    //         actions: <Widget>[
    //           FlatButton(
    //             child: Text("Cancel"),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //           FlatButton(
    //             child: Text(
    //               "Delete",
    //               style: TextStyle(
    //                 color: Colors.red,
    //               ),
    //             ),
    //             onPressed: () {
    //               // Navigator.of(context).pop();
    //               // _transactionProvider.deleteTransactions(
    //               //     transaction: transaction);
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }

    // Future<void> _getData() async {
    //   _transactionProvider.fetchTransactions(clientId: 2);
    // }

    Future<void> _getData() async {
      _orderProvider.fetchOrders(clientId: _authProvider.authenticatedUser.id);
    }

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Transactions'),
        ),
        body: _orderProvider.isFetchingOrderData
            ? Center(child: CircularProgressIndicator())
            : _orderProvider.availableOrders.isEmpty
                ? RefreshIndicator(
                    onRefresh: _getData,
                    child: ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                        ),
                        Center(
                          child: NoItemTile(
                              icon: 'assets/icons/calendar.png',
                              title: 'No orders',
                              subtitle: 'Please there are no available orders'),
                        )
                      ],
                    ),
                  )
                : RefreshIndicator(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        controller: _scrollController,
                          itemCount: _orderProvider.availableOrders.length,
                          itemBuilder: (context, index) {
                            return OrderCard(
                                order: _orderProvider.availableOrders[index],
                                orderListCardOnTap: () {
                                  _orderProvider.selectOrder =
                                      _orderProvider.availableOrders[index];
                                  Navigator.pushNamed(
                                      context, orderDetailScreen);
                                },
                                orderMoreOnTap: () {
                                  _settingModalBottomSheet(
                                      context: context,
                                      order:
                                          _orderProvider.availableOrders[index],
                                      orderProvider: _orderProvider);
                                });
                          }),
                    ),
                    onRefresh: _getData),
        floatingActionButton: isBottomSheetVisible
            ? null
            : ( _showFloatingButtonText ? RaisedButton(
          shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.blue)
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add,color: Colors.white,),
              _showFloatingButtonText ? Text('Create Order',style: TextStyle(fontSize: 14,color: Colors.white),) : Container(),
            ],
          ),
          color: Colors.blue,// Icon(Icons.add),
          onPressed: () {
            setState(() {
              isBottomSheetVisible = true;
            });
            _newTransactionModalBottomSheet(
                context: context,
                serviceProvider: _serviceProvider,
                productProvider: _productProvider);
          },) : FloatingActionButton(
          tooltip: 'Create Order',
                mini: true,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isBottomSheetVisible = true;
                  });
                  _newTransactionModalBottomSheet(
                      context: context,
                      serviceProvider: _serviceProvider,
                      productProvider: _productProvider);
                })));

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(
    //       'Transactions',
    //       style: TextStyle(color: Colors.white),
    //     ),
    //   ),
    //   body: _transactionProvider.isFetchingTransactionData
    //       ? Center(child: CircularProgressIndicator())
    //       : _transactionProvider.availableTransactions.isEmpty
    //           ? Center(
    //               child: NoItemTile(
    //                   icon: 'assets/icons/transaction.png',
    //                   title: 'No Transactions',
    //                   subtitle: 'Please by out products and book for services'),
    //             )
    //           : RefreshIndicator(
    //               child: ListView.builder(
    //                   itemCount:
    //                       _transactionProvider.availableTransactions.length,
    //                   itemBuilder: (context, index) {
    //                     return Padding(
    //                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //                       child: TransactionListCard(
    //                         onDeleteTap: () {
    //                           _showDialog(
    //                               context,
    //                               _transactionProvider
    //                                   .availableTransactions[index]);
    //                         },
    //                         onViewTap: () {
    //                           Navigator.push(
    //                               context,
    //                               MaterialPageRoute(
    //                                 builder: (context) => ReceiptScreen(
    //                                   transaction: _transactionProvider
    //                                       .availableTransactions[index],
    //                                 ),
    //                               ));
    //                         },
    //                         transaction: _transactionProvider
    //                             .availableTransactions[index],
    //                       ),
    //                     );
    //                   }),
    //               onRefresh: _getData),
    // );
  }

  void _settingModalBottomSheet(
      {@required context,
      @required Order order,
      @required OrderProvider orderProvider}) {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(
                      Icons.assignment,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: new Text('View'),
                    onTap: () {
                      Navigator.pop(context);
                      orderProvider.selectOrder = order;
                      Navigator.pushNamed(context, orderDetailScreen);
                    }),
                new ListTile(
                  leading: new Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  title: new Text('Delete'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  void _newTransactionModalBottomSheet(
      {@required context,
      @required ServiceProvider serviceProvider,
      @required ProductProvider productProvider}) async {
    _controller = await _scaffoldKey.currentState.showBottomSheet((context) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      child: Text('Set Appointment',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SetAppointmentScreen(
                                    service:
                                        serviceProvider.availableServices[0])));
                      },
                      color: Colors.green,
                    ),
                    RaisedButton(
                      child: Text(
                          _showProducts ? 'Hide Products' : 'Show Product',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onPressed: () {
                        _controller.setState(() {
                          _showProducts = !_showProducts;
                        });
                      },
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
            _showProducts
                ? Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: SingleChildScrollView(
                        child: Wrap(
                          children: productProvider.availableProducts
                              .map((product) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RaisedButton(
                                        color: Colors.lightBlueAccent,
                                        child: ListTile(
                                          leading: Image.network(
                                            product.image,
                                            height: 50,
                                          ),
                                          title: Text(product.name),
                                          subtitle: Text("${product.price}"),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsScreen(
                                                        product: product,
                                                      )));
                                        }),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      );
    });
    _controller.closed.then((value) {
      showFloatingActionButton(false);
    });
  }

  void showFloatingActionButton(bool value) {
    setState(() {
      isBottomSheetVisible = value;
    });
  }
}
