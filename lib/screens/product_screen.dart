import 'package:cloud_9_client/components/card/product_list_card.dart';
import 'package:cloud_9_client/components/tiles/no_item_tile.dart';
import 'package:cloud_9_client/provider/product_provider.dart';
import 'package:cloud_9_client/screens/background.dart';
import 'package:cloud_9_client/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _productProvider = Provider.of<ProductProvider>(context);

    Future<void> _getData() async {
      _productProvider.fetchProducts();
    }

    return Background(
        screen: SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
            SliverAppBar(
              elevation: 0,
              expandedHeight: 120.0,
              backgroundColor: Colors.transparent,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
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
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartScreen()));
                  },
                )
              ],
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                title: Text(
                  'Products',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Top Products',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
                  ),
                  Icon(Icons.star, color: Colors.deepOrange, size: 40)
                ],
              ),
            ])),
          ],
          body: _productProvider.isFetchingProductData
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
                          itemCount: _productProvider.availableProducts.length,
                          itemBuilder: (context, index) {
                            return ProductListCard(
                              productListCardOnTap: () {},
                              productOrderOnTap: () {},
                              product:
                                  _productProvider.availableProducts[index],
                            );
                          }),
                      onRefresh: _getData),
        ),
      ),
    ));
  }
}
