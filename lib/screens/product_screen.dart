import 'package:badges/badges.dart';
import 'package:cloud_9_client/components/card/item_card.dart';
import 'package:cloud_9_client/components/tiles/no_item_tile.dart';
import 'package:cloud_9_client/constants/constants.dart';
import 'package:cloud_9_client/provider/product_provider.dart';
import 'package:cloud_9_client/screens/background.dart';

import 'package:cloud_9_client/screens/cart_screen.dart';
import 'package:cloud_9_client/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final FocusNode _searchFocusNode = FocusNode();

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _productProvider = Provider.of<ProductProvider>(context);

    Future<void> _getData() async {
      _productProvider.fetchProducts();
    }

    return Background(
        screen: SafeArea(
      child: Container(
          child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxScrolled) => [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            title: Center(
              child: Text(
                'Products',
                style: TextStyle(color: Colors.white),
              ),
            ),
            elevation: 0,
            actions: <Widget>[
              IconButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => CartScreen())),
                icon: Badge(
                  showBadge:
                      _productProvider.totalCartQuantity > 0 ? true : false,
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
            bottom: PreferredSize(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                      child: TextField(
                    onTap: () {
                      print('object');

                      _searchController.text = 'object';
                      _productProvider.setOriginalProducts =
                          _productProvider.availableProducts;
                    },
                    onChanged: (value) {
                      _productProvider.filteredProducts(searching: value);
                    },
                    focusNode: _searchFocusNode,
                    controller: _searchController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                      FontAwesomeIcons.search,
                      size: 22.0,
                      color: Colors.blue,
                    )),
                  )),
                ),
                preferredSize: Size(MediaQuery.of(context).size.width, 100)),
          ),
        ],
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kDefaultPaddin),
                            child: GridView.builder(
                                itemCount:
                                    _productProvider.availableProducts.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: kDefaultPaddin,
                                  crossAxisSpacing: kDefaultPaddin,
                                  childAspectRatio: 0.75,
                                ),
                                itemBuilder: (context, index) => ItemCard(
                                      product: _productProvider
                                          .availableProducts[index],
                                      press: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailsScreen(
                                              product: _productProvider
                                                  .availableProducts[index],
                                            ),
                                          )),
                                    )),
                          ),
                          onRefresh: _getData)),
        ),
      )),
    ));
  }

  // void _showInSnackBar(String value, BuildContext context) {
  //   FocusScope.of(context).requestFocus(new FocusNode());
  //   _scaffoldKey.currentState?.removeCurrentSnackBar();
  //   _scaffoldKey.currentState.showSnackBar(new SnackBar(
  //     content: new Text(
  //       value,
  //       textAlign: TextAlign.center,
  //       style: TextStyle(
  //           color: Colors.white,
  //           fontSize: 16.0,
  //           fontFamily: "WorkSansSemiBold"),
  //     ),
  //     backgroundColor: Colors.blue,
  //     duration: Duration(seconds: 3),
  //   ));
  // }

}
