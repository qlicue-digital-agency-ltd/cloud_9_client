import 'package:cloud_9_client/components/card/cart_card.dart';
import 'package:cloud_9_client/provider/product_provider.dart';
import 'package:cloud_9_client/screens/background.dart';
import 'package:cloud_9_client/utils/currency_convertor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _productProvider = Provider.of<ProductProvider>(context);
    List<Widget> _createShoppingCartRows() {
      return _productProvider.productsInCart.keys
          .map(
            (int id) => CartCard(
              product: _productProvider.getProductById(id),
              quantity: _productProvider.productsInCart[id],
            ),
          )
          .toList();
    }

    Widget _buildTotals() {
      return ClipPath(
        clipper: OvalTopBorderClipper(),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 5.0,
                  color: Colors.grey.shade700,
                  spreadRadius: 80.0),
            ],
            color: Colors.white,
          ),
          padding:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Subtotal"),
                  Text(currencyCovertor.currencyCovertor(
                      amount: _productProvider.subtotalCost)),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Tax fee"),
                  Text(currencyCovertor.currencyCovertor(
                      amount: _productProvider.tax)),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0)),
                  Text(
                      currencyCovertor.currencyCovertor(
                          amount: _productProvider.totalCost),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0)),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              MaterialButton(
                height: 50,
                color: Colors.blue,
                onPressed: () {
               
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("CHECK OUT",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
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
            icon: Icon(
              Icons.clear_all,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {},
          )
        ],
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          centerTitle: true,
          title: Text(
            'Shopping Cart',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: _createShoppingCartRows(),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            _buildTotals()
          ],
        ),
      ),
    );
  }
}
