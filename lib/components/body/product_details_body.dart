import 'package:cloud_9_client/components/tiles/add_to_cart.dart';
import 'package:cloud_9_client/components/tiles/color_and_size.dart';
import 'package:cloud_9_client/components/tiles/counter_with_fav_btn.dart';
import 'package:cloud_9_client/components/tiles/description.dart';
import 'package:cloud_9_client/components/tiles/product_title_with_image.dart';
import 'package:cloud_9_client/constants/constants.dart';
import 'package:cloud_9_client/models/product.dart';
import 'package:flutter/material.dart';


class Body extends StatelessWidget {
  final Product product;

  const Body({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.05,
                    left: kDefaultPaddin,
                    right: kDefaultPaddin
                  ),
                  // height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      ColorAndSize(product: product),
                      SizedBox(height: kDefaultPaddin / 2),
                      Description(product: product),
                      SizedBox(height: kDefaultPaddin / 2),
                      CounterWithFavBtn(product: product,),
                      SizedBox(height: kDefaultPaddin / 2),
                      AddToCart(product: product)
                    ],
                  ),
                ),
                ProductTitleWithImage(product: product)
              ],
            ),
          )
        ],
      ),
    );
  }
}
