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
          clipBehavior: Clip.antiAlias,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/lisa.jpeg',
                    height: 80,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Name of Product', style: TextStyle(fontSize:18,fontWeight: FontWeight.bold ),),
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
