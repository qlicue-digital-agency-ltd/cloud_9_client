import 'package:cloud_9_client/components/card/icon_only_card.dart';
import 'package:cloud_9_client/components/card/product_list_card.dart';
import 'package:cloud_9_client/pages/cart_page.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(),
                        ));
                  },
                )
              ]),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Top Products',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
                  ),
                  Icon(Icons.star, color: Colors.yellow, size: 40)
                ],
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
                  ),
                  Text(
                    'see all',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.w100),
                  )
                ],
              ),
              SizedBox(height: 10),
            ])),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: IconOnlyCard(
                          iconColor: Colors.blue,
                          icon: Icons.favorite,
                          backgroundColor: Colors.white,
                          onTap: () {}),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ProductListCard(
                    productListCardOnTap: () {
                      print('----------ppppppp-----');
                    },
                    productOrderOnTap: () {
                      print('---object-------');
                    },
                  ),
                );
              }, childCount: 10),
            )
          ],
        ),
      ),
    );
  }
}
