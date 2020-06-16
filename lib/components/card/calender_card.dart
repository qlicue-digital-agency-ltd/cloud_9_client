import 'package:cloud_9_client/models/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef CalenderOnTap = Function();

class CalenderCard extends StatelessWidget {
  final CalenderOnTap onTapConfirm;
  final User user;

  const CalenderCard({
    Key key,
    @required this.onTapConfirm,
    @required this.user,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Column(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: Colors.blue,
          ),
          height: 100,
          child: Column(children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 10),
                Icon(
                  FontAwesomeIcons.clock,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'TIME',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'for your appointment',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                  ),
                )
              ],
            ),
          ]),
        ),
        SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('16th/06/2020',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(width: 20),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('From',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('To',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ]),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
            Widget>[
          Chip(
              label: Text('10:30 am',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          Chip(
              label: Text('12:30 pm',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
        ]),
        SizedBox(
          height: 20,
        ),
        Divider(),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {},
                child: Text(
                  '\t\t\t\tConfirm\t\t\t\t',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ])
      ]),
    );
  }
}
