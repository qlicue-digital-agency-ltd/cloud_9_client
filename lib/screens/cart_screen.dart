import 'package:cloud_9_client/components/card/cart_card.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:cloud_9_client/provider/product_provider.dart';
import 'package:cloud_9_client/utils/currency_convertor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _codeFocusNode = FocusNode();

  TextEditingController _codeTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _productProvider = Provider.of<ProductProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context);
    void _showAgentDialog(context) {
      // flutter defined function
      showDialog(
        context: context,
        builder: (
          BuildContext context,
        ) {
          // return object of type Dialog
          return AlertDialog(
            title: Text("Book Now!"),
            content: Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Column(children: <Widget>[
                Text("Add Agent Code"),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: Colors.blue,
                            primaryColorDark: Colors.red[50],
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter Agent Code';
                              } else
                                return null;
                            },
                            focusNode: _codeFocusNode,
                            controller: _codeTextController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                                focusColor: Colors.blue,
                                fillColor: Colors.blue,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(color: Colors.blue)),
                                hintText: "Agent Code",
                                labelText: "Agent Code",
                                labelStyle: TextStyle(color: Colors.blue),
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 17.0,
                                    color: Colors.white),
                                prefixIcon: Icon(
                                  FontAwesomeIcons.cog,
                                  size: 22.0,
                                  color: Colors.blue,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 2,
                  endIndent: 2,
                ),
                Row(children: <Widget>[
                  Expanded(
                      child: RaisedButton(
                          color: Colors.blue,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _productProvider
                                  .postOrder(
                                agentUuid: _codeTextController.text,
                                userId: _authProvider.authenticatedUser.id,
                                totalAmount: _productProvider.totalCost,
                              )
                                  .then((value) {
                                if (_productProvider.isCreatingOrderData) {
                                } else {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              });
                            }
                          },
                          child: _productProvider.isCreatingOrderData
                              ? CircularProgressIndicator()
                              : Text(
                                  'CONFIRM',
                                  style: TextStyle(color: Colors.white),
                                ))),
                ])
              ]),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void _showDialog(context, name) {
      // flutter defined function
      showDialog(
        context: context,
        builder: (
          BuildContext context,
        ) {
          // return object of type Dialog
          return AlertDialog(
            title: Text("Book Now!"),
            content: Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Column(children: <Widget>[
                Text("Please confirm your booking for " + name),
                Divider(
                  indent: 2,
                  endIndent: 2,
                ),
                Row(children: <Widget>[
                  Text("Use Agent: "),
                  Expanded(
                      child: RaisedButton(
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.pop(context);
                            _showAgentDialog(context);
                          },
                          child: Text(
                            'Agent CODE',
                            style: TextStyle(color: Colors.white),
                          ))),
                ]),
                Row(children: <Widget>[
                  Text("Direct to Clinic: "),
                  Expanded(
                      child: RaisedButton(
                          color: Colors.blue,
                          onPressed: () {
                            _productProvider
                                .postOrder(
                              agentUuid: null,
                              userId: _authProvider.authenticatedUser.id,
                              totalAmount: _productProvider.totalCost,
                            )
                                .then((value) {
                              if (_productProvider.isCreatingOrderData) {
                              } else {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            });
                          },
                          child: Text(
                            'CONFIRM',
                            style: TextStyle(color: Colors.white),
                          ))),
                ])
              ]),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    List<Widget> _createShoppingCartRows() {
      return _productProvider.productsInCart.keys
          .map(
            (int id) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: CartCard(
                product: _productProvider.getProductById(id),
                quantity: _productProvider.productsInCart[id],
              ),
            ),
          )
          .toList();
    }

    Widget _buildTotals() {
      return ClipPath(
        clipper: OvalTopBorderClipper(),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 5.0,
                  color: Colors.grey.shade700,
                  spreadRadius: 80.0),
            ],
            color: Colors.white,
          ),
          padding:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Subtotal"),
                  Text(currencyCovertor.currencyCovertor(
                      amount: _productProvider.subtotalCost)),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Tax fee"),
                  Text(currencyCovertor.currencyCovertor(
                      amount: _productProvider.tax)),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0)),
                  Text(
                      currencyCovertor.currencyCovertor(
                          amount: _productProvider.totalCost),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0)),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              MaterialButton(
                height: 50,
                color: Colors.blue,
                onPressed: () {
                  _showDialog(context, 'Check Out');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("CHECK OUT",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.clear_all,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              _productProvider.revertCart();
            },
          )
        ],
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          centerTitle: true,
          title: Text(
            'Shopping Cart',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: _createShoppingCartRows(),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            _buildTotals()
          ],
        ),
      ),
    );
  }
}
