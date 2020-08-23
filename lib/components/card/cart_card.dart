import 'package:cloud_9_client/models/product.dart';
import 'package:cloud_9_client/provider/product_provider.dart';
import 'package:cloud_9_client/utils/currency_convertor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CartCard extends StatelessWidget {
  final Product product;
  final int quantity;

  CartCard({Key key, @required this.product, @required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _productProvider = Provider.of<ProductProvider>(context);
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20, left: 20),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                height: 180,
                child: Row(children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 60, top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            product.name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            product.description,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: CircleAvatar(
              child: IconButton(
                icon: Icon(Icons.close),
                color: Colors.white,
                onPressed: () {
                  print('object');
                },
              ),
              backgroundColor: Colors.blue,
            ),
          ),
          Positioned(
            top: 65,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Center(
                child: product.image == null
                    ? Image.asset('assets/icons/product.png')
                    : Image.network(product.image),
              ),
            ),
          ),
          Positioned(
              top: 30,
              left: 30,
              child: Text(
                'Product',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
          Positioned(
              bottom: 10,
              right: 10,
              child: Text(
                currencyCovertor.currencyCovertor(amount: product.price),
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          Positioned(
              bottom: 10,
              left: 30,
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      if (product.id > 0)
                        _productProvider.removeItemFromCart(
                            currentProduct: product);
                    },
                    child: Material(
                        elevation: 2,
                        child: Icon(
                          FontAwesomeIcons.minus,
                          color: Colors.deepOrange,
                        )),
                  ),
                  SizedBox(width: 5),
                  Material(
                      elevation: 2,
                      child: Container(
                          height: 25,
                          width: 25,
                          child: Center(
                              child: Text(
                            quantity.toString(),
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )))),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      if (product.id > 0)
                        _productProvider.addProductToCart(
                            currentProduct: product);
                    },
                    child: Material(
                        elevation: 2,
                        child: Icon(
                          FontAwesomeIcons.plus,
                          color: Colors.blue,
                        )),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
