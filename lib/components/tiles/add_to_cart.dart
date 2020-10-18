import 'package:cloud_9_client/components/text-fields/mobile_number.dart';
import 'package:cloud_9_client/constants/constants.dart';
import 'package:cloud_9_client/models/product.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:cloud_9_client/provider/order_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToCart extends StatefulWidget {
  AddToCart({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  final FocusNode _mobileFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  TextEditingController _mobileTextEditingController = TextEditingController();
  bool _isPaying = false;
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    final _orderProvider = Provider.of<OrderProvider>(context);
    Future<void> _showDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Phone Number to Pay'),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: MobileTextfield(
                          hitText: 'Phone Number',
                          labelText: 'Phone Number',
                          focusNode: _mobileFocusNode,
                          textEditingController: _mobileTextEditingController,
                          maxLines: 1,
                          message: 'Phone number required',
                          onCodeChange: (country) {
                            print(country);
                            _orderProvider.setSelectedCountry = country;
                          },
                          selectedCountry: _orderProvider.selectedCountry,
                          keyboardType: TextInputType.number),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FlatButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: FlatButton(
                            textColor: Colors.white,
                            color: Theme.of(context).primaryColor,
                            child: _isPaying
                                ? CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  )
                                : Text('Pay'.toUpperCase()),
                            onPressed: () {
                              setState(() {
                                _isPaying = true;
                              });
                              if (_formKey.currentState.validate()) {
                                final _phone =
                                    _orderProvider.selectedCountry.dialingCode +
                                        _mobileTextEditingController.text
                                            .replaceAll('(', '')
                                            .replaceAll(')', '')
                                            .replaceAll('-', '')
                                            .replaceAll(' ', '');
                                _orderProvider
                                    .createOrder(
                                        userId:
                                            _authProvider.authenticatedUser.id,
                                        paymentPhone: _phone,
                                        noOfItems: 1,
                                        productId: widget.product.id)
                                    .then((value) {
                                  setState(() {
                                    _isPaying = false;
                                  });
                                  if (value) {
                                    print('errors');
                                  } else {
                                    Navigator.of(context).pop();
                                    Navigator.pushNamed(
                                        context, orderDetailScreen);
                                  }
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 50,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: Colors.blue,
                onPressed: () {
                  _showDialog();
                },
                child: Text(
                  "Buy  Now".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
