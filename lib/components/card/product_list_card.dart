import 'package:badges/badges.dart';
import 'package:cloud_9_client/models/product.dart';
import 'package:cloud_9_client/provider/product_provider.dart';
import 'package:cloud_9_client/utils/currency_convertor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef ProductListCardOnTap = Function();
typedef ProductOrderOnTap = Function();

class ProductListCard extends StatelessWidget {
  final ProductListCardOnTap productListCardOnTap;
  final ProductOrderOnTap productOrderOnTap;
  final ProductOrderOnTap removeproductOrderOnTap;
  final Product product;

  const ProductListCard(
      {Key key,
      @required this.productListCardOnTap,
      @required this.productOrderOnTap,
      @required this.product,
      @required this.removeproductOrderOnTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _productProvider = Provider.of<ProductProvider>(context);
    return InkWell(
      onTap: productListCardOnTap,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <
              Widget>[
            //_productProvider.posBatchList[index].id
            _productProvider.productsInCart[product.id] != null
                ? IconButton(
                    onPressed: () {
                      print(_productProvider.productsInCart);
                      //  _showBottomSheet(context, model.posBatchList[index]);
                    },
                    icon: Badge(
                      showBadge:
                          _productProvider.productsInCart[product.id] != null
                              ? true
                              : false,
                      badgeContent: Text(
                        _productProvider.productsInCart[product.id].toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      child: Icon(
                        Icons.shopping_cart,
                        color: Theme.of(context).buttonColor,
                      ),
                      badgeColor: Colors.red,
                    ),
                  )
                : Padding(
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
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            product.name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            currencyCovertor.currencyCovertor(
                              amount: product.price,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            _productProvider.productsInCart[product.id] != null
                ? InkWell(
                    onTap: removeproductOrderOnTap,
                    child: Container(
                      width: 60,
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Icon(
                            Icons.remove_shopping_cart,
                            color: Colors.red,
                          ),
                          SizedBox(height: 3),
                          Text('Remove'),
                        ],
                      ),
                    ),
                  )
                : Container(),
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
                    Icon(
                      Icons.add_shopping_cart,
                      color: product.quantity > 0 ? Colors.blue : Colors.red,
                    ),
                    SizedBox(height: 3),
                    Text(_productProvider.productsInCart[product.id] != null
                        ? 'Add'
                        : 'Order'),
                  ],
                ),
              ),
            ),
          ])),
    );
  }
}
