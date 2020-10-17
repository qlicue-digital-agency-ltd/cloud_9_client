import 'package:cloud_9_client/components/text-fields/mobile_number.dart';
import 'package:cloud_9_client/constants/constants.dart';
import 'package:cloud_9_client/models/product.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';

import 'package:cloud_9_client/provider/payment_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    final _paymentProvider = Provider.of<PaymentProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context);
    Future<void> _showDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Meeting  Personnel'),
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
                            _paymentProvider.setSelectedCountry = country;
                          },
                          selectedCountry: _paymentProvider.selectedCountry,
                          keyboardType: TextInputType.number),
                    )
                  ],
                ),
              );
            }),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    final _phone =
                        _paymentProvider.selectedCountry.dialingCode +
                            _mobileTextEditingController.text
                                .replaceAll('(', '')
                                .replaceAll(')', '')
                                .replaceAll('-', '')
                                .replaceAll(' ', '');
                    _paymentProvider
                        .createOrder(
                            userId: _authProvider.authenticatedUser.id,
                            paymentPhone: _phone,
                            amount: widget.product.price)
                        .then((value) {
                      if (value) {
                        print('errors');
                      } else {
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, orderDetailScreen);
                      }
                    });
                  }
                },
              ),
            ],
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
                onPressed: () {},
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
