import 'package:cloud_9_client/components/card/cart_card.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate([
              Row(children: <Widget>[
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    height: 50,
                    width: 50,
                    child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 30,
                  ),
                  onPressed: () {},
                )
              ]),
            ])),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CartCard(),
                );
              }, childCount: 10),
            )
          ],
        ),
      ),
    );
  }
}
