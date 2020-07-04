import 'package:cloud_9_client/models/product.dart';
import 'package:flutter/material.dart';

typedef ProductListCardOnTap = Function();
typedef ProductOrderOnTap = Function();

class ProductListCard extends StatelessWidget {
  final ProductListCardOnTap productListCardOnTap;
  final ProductOrderOnTap productOrderOnTap;
  final Product product;

  const ProductListCard(
      {Key key,
      @required this.productListCardOnTap,
      @required this.productOrderOnTap,
      @required this.product})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: productListCardOnTap,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/icons/product.png'))),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          product.name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text("TZ " + product.price.toString() + " /-"),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: productOrderOnTap,
                  child: Container(
                    width: 60,
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Icon(Icons.add_shopping_cart),
                        SizedBox(height: 3),
                        Text('Order'),
                      ],
                    ),
                  ),
                ),
              ])),
    );
  }
}
