import 'package:cloud_9_client/screens/background.dart';
import 'package:cloud_9_client/screens/calender_screen.dart';
import 'package:flutter/material.dart';

class ServiceDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
        screen: SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        child: CustomScrollView(
          slivers: <Widget>[
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
                    Icons.calendar_today,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CalenderScreen()));
                  },
                )
              ],
              pinned: true,
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Text(
                'Title of Service',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage('assets/images/lisa.jpeg'),
                                fit: BoxFit.cover)),
                        height: 150,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 1,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/lisa.jpeg'),
                                    fit: BoxFit.cover)),
                            height: 150,
                          ),
                          Positioned(
                            top: 55,
                            left: 40,
                            child: Text(
                              '+2',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ))
                ],
              ),
              SizedBox(height: 10),
            ])),
            SliverList(
                delegate: SliverChildListDelegate([
              Text(
                'Apple pie croissant bear claw tootsie roll carrot cake cotton candy toffee candy sweet. Brownie sugar plum gummies pastry brownie lollipop pastry marshmallow tiramisu. Wafer chocolate bar lemon drops cotton candy jelly-o cupcake gummi bears jujubes. Jujubes donut liquorice jelly beans. Oat cake powder powder jelly. Lemon drops jelly-o oat cake dragée cookie bear claw carrot cake. Apple pie gummies macaroon bear claw halvah tootsie roll halvah danish sweet roll. Cake ice cream pudding. Candy canes marshmallow cupcake dragée jujubes. Chocolate topping croissant chocolate gingerbread wafer danish gummi bears jelly beans. Danish pie cheesecake cheesecake sweet roll candy bonbon liquorice oat cake.',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )
            ]))
          ],
        ),
      ),
    ));
  }
}
