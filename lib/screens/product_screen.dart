import 'package:badges/badges.dart';
import 'package:cloud_9_client/components/card/product_list_card.dart';
import 'package:cloud_9_client/components/tiles/no_item_tile.dart';
import 'package:cloud_9_client/provider/product_provider.dart';

import 'package:cloud_9_client/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final _productProvider = Provider.of<ProductProvider>(context);

    Future<void> _getData() async {
      _productProvider.fetchProducts();
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Products',
            style: TextStyle(color: Colors.white),
          ),
        ),
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: _productProvider.totalCartQuantity > 0
                ? () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => CartScreen()))
                : null,
            icon: Badge(
              showBadge: _productProvider.totalCartQuantity > 0 ? true : false,
              badgeContent: Text(
                _productProvider.totalCartQuantity.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: Icon(
                Icons.shopping_cart,
                size: 30,
                color: Colors.white,
              ),
              badgeColor: Colors.red,
            ),
          ),
          SizedBox(width: 10)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
            child: _productProvider.isFetchingProductData
                ? Center(child: CircularProgressIndicator())
                : _productProvider.availableProducts.isEmpty
                    ? Center(
                        child: NoItemTile(
                            icon: 'assets/icons/product.png',
                            title: 'No Products',
                            subtitle: 'We are out of stock'),
                      )
                    : RefreshIndicator(
                        child: ListView.builder(
                            itemCount:
                                _productProvider.availableProducts.length,
                            itemBuilder: (context, index) {
                              return ProductListCard(
                                productListCardOnTap: () {},
                                productOrderOnTap: () {
                                  _productProvider.addProductToCart(
                                      currentProduct: _productProvider
                                          .availableProducts[index]);
                                  if (_productProvider
                                          .availableProducts[index].quantity <=
                                      0)
                                    _showInSnackBar(
                                        'Product out of stock', context);
                                },
                                product:
                                    _productProvider.availableProducts[index],
                                removeproductOrderOnTap: () {
                                  _productProvider.removeItemFromCart(
                                      currentProduct: _productProvider
                                          .availableProducts[index]);
                                },
                              );
                            }),
                        onRefresh: _getData)),
      ),
    );
  }

  void _showInSnackBar(String value, BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }
}
