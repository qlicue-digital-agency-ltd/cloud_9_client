import 'package:flutter/material.dart';

typedef ProductListCardOnTap = Function();
typedef ProductOrderOnTap = Function();

class ProductListCard extends StatelessWidget {
  final ProductListCardOnTap productListCardOnTap;
  final ProductOrderOnTap productOrderOnTap;

  const ProductListCard(
      {Key key,
      @required this.productListCardOnTap,
      @required this.productOrderOnTap})
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
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              'assets/images/4.jpg',
                            ))),
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
                          'Name of Product',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text('Product description'),
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
