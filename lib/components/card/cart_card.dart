import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20, left: 20),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                height: 180,
                child: Row(children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 60, top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'LOSARTAN',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Schedule an e-vist and the',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: CircleAvatar(
              child: IconButton(
                icon: Icon(Icons.close),
                color: Colors.deepOrange,
                onPressed: () {
                  print('object');
                },
              ),
              backgroundColor: Colors.white,
            ),
          ),
          Positioned(
            top: 65,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      image: AssetImage('assets/images/lisa.jpeg'))),
            ),
          ),
          Positioned(
              top: 30,
              left: 30,
              child: Text(
                'Medicine',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
          Positioned(
              bottom: 10,
              right: 10,
              child: Text(
                'TZS 200,000 /-',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
          Positioned(
              bottom: 10,
              left: 30,
              child: Row(
                children: <Widget>[
                  Material(
                      elevation: 2,
                      child: Icon(
                        FontAwesomeIcons.minus,
                        color: Colors.deepOrange,
                      )),
                  SizedBox(width: 5),
                  Material(
                      elevation: 2,
                      child: Container(
                          height: 25,
                          width: 25,
                          child: Center(
                              child: Text(
                            '3',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )))),
                  SizedBox(width: 5),
                  Material(
                      elevation: 2,
                      child: Icon(
                        FontAwesomeIcons.plus,
                        color: Colors.blue,
                      )),
                ],
              ))
        ],
      ),
    );
  }
}
