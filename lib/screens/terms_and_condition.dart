
import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms & Conditions',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate([
              Text(
                'Terms',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                  'Jelly brownie dessert jelly beans apple pie soufflé jelly beans. Cake gummies soufflé chupa chups sweet danish carrot cake pastry danish. Bear claw cake lollipop. Lemon drops sweet liquorice. Donut dragée gummi bears candy cheesecake. Lollipop jelly beans marshmallow macaroon. Biscuit sweet roll chocolate. Cheesecake topping macaroon. Candy canes donut sweet toffee icing bonbon. Sweet roll marzipan sesame snaps sweet. Sesame snaps biscuit cheesecake marzipan danish jujubes apple pie sweet brownie. Tart donut dragée cupcake gummies lollipop soufflé. Ice cream jujubes sesame snaps marshmallow wafer Jelly brownie dessert jelly beans apple pie soufflé jelly beans. Cake gummies soufflé chupa chups sweet danish carrot cake pastry danish. Bear claw cake lollipop. Lemon drops sweet liquorice. Donut dragée gummi bears candy cheesecake. Lollipop jelly beans marshmallow macaroon. Biscuit sweet roll chocolate. Cheesecake topping macaroon. Candy canes donut sweet toffee icing bonbon. Sweet roll marzipan sesame snaps sweet. Sesame snaps biscuit cheesecake marzipan danish jujubes apple pie sweet brownie. Tart donut dragée cupcake gummies lollipop soufflé. Ice cream jujubes sesame snaps marshmallow wafer'),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                'Conditions',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                  'Jelly brownie dessert jelly beans apple pie soufflé jelly beans. Cake gummies soufflé chupa chups sweet danish carrot cake pastry danish. Bear claw cake lollipop. Lemon drops sweet liquorice. Donut dragée gummi bears candy cheesecake. Lollipop jelly beans marshmallow macaroon. Biscuit sweet roll chocolate. Cheesecake topping macaroon. Candy canes donut sweet toffee icing bonbon. Sweet roll marzipan sesame snaps sweet. Sesame snaps biscuit cheesecake marzipan danish jujubes apple pie sweet brownie. Tart donut dragée cupcake gummies lollipop soufflé. Ice cream jujubes sesame snaps marshmallow wafer Jelly brownie dessert jelly beans apple pie soufflé jelly beans. Cake gummies soufflé chupa chups sweet danish carrot cake pastry danish. Bear claw cake lollipop. Lemon drops sweet liquorice. Donut dragée gummi bears candy cheesecake. Lollipop jelly beans marshmallow macaroon. Biscuit sweet roll chocolate. Cheesecake topping macaroon. Candy canes donut sweet toffee icing bonbon. Sweet roll marzipan sesame snaps sweet. Sesame snaps biscuit cheesecake marzipan danish jujubes apple pie sweet brownie. Tart donut dragée cupcake gummies lollipop soufflé. Ice cream jujubes sesame snaps marshmallow wafer'),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                'Copy Rights',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                  'Jelly brownie dessert jelly beans apple pie soufflé jelly beans. Cake gummies soufflé chupa chups sweet danish carrot cake pastry danish. Bear claw cake lollipop. Lemon drops sweet liquorice. Donut dragée gummi bears candy cheesecake. Lollipop jelly beans marshmallow macaroon. Biscuit sweet roll chocolate. Cheesecake topping macaroon. Candy canes donut sweet toffee icing bonbon. Sweet roll marzipan sesame snaps sweet. Sesame snaps biscuit cheesecake marzipan danish jujubes apple pie sweet brownie. Tart donut dragée cupcake gummies lollipop soufflé. Ice cream jujubes sesame snaps marshmallow wafer Jelly brownie dessert jelly beans apple pie soufflé jelly beans. Cake gummies soufflé chupa chups sweet danish carrot cake pastry danish. Bear claw cake lollipop. Lemon drops sweet liquorice. Donut dragée gummi bears candy cheesecake. Lollipop jelly beans marshmallow macaroon. Biscuit sweet roll chocolate. Cheesecake topping macaroon. Candy canes donut sweet toffee icing bonbon. Sweet roll marzipan sesame snaps sweet. Sesame snaps biscuit cheesecake marzipan danish jujubes apple pie sweet brownie. Tart donut dragée cupcake gummies lollipop soufflé. Ice cream jujubes sesame snaps marshmallow wafer')
            ])),
          ],
        ),
      ),
    );
  }
}
