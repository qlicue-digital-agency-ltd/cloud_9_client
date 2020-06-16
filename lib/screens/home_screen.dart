import 'package:cloud_9_client/components/card/icon_card.dart';
import 'package:cloud_9_client/components/card/notification_card.dart';
import 'package:cloud_9_client/screens/appointment_screen.dart';
import 'package:cloud_9_client/screens/background.dart';
import 'package:cloud_9_client/screens/product_screen.dart';
import 'package:cloud_9_client/screens/service_screen.dart';
import 'package:cloud_9_client/screens/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'consultation_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
        screen: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                            image: AssetImage('assets/images/lisa.jpeg'))),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: 30,
                    ),
                    onPressed: () {},
                  )
                ]),
                SizedBox(height: 100),
                Text(
                  'Hello,',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Jessica,',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Icon(FontAwesomeIcons.female, size: 30, color: Colors.blue)
                  ],
                ),
                SizedBox(height: 20),
                Material(
                  color: Colors.white,
                  elevation: 2,
                  borderRadius: BorderRadius.circular(20),
                  child: ListTile(
                    leading: Icon(Icons.search),
                    title: Text('Search.....'),
                  ),
                ),
                SizedBox(height: 20),
                NotificationCard(),
                SizedBox(height: 20),
                Text(
                  'What do you need?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconCard(
                          iconColor: Colors.white,
                          icon: Icons.calendar_today,
                          title: 'Appointment',
                          textColor: Colors.white,
                          backgroundColor: Colors.deepOrange,
                          onTap: () {
                            print('object');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AppointmentScreen(),
                                ));
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconCard(
                          iconColor: Colors.blue,
                          icon: Icons.room_service,
                          title: 'Services',
                          textColor: Colors.black,
                          backgroundColor: Colors.white,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ServiceScreen(),
                                ));
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconCard(
                          iconColor: Colors.white,
                          icon: Icons.fastfood,
                          title: 'Products',
                          textColor: Colors.white,
                          backgroundColor: Colors.deepOrange,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductScreen(),
                                ));
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconCard(
                          iconColor: Colors.blue,
                          icon: Icons.call,
                          title: 'Consultation',
                          textColor: Colors.black,
                          backgroundColor: Colors.white,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConsultationScreen(),
                                ));
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconCard(
                          iconColor: Colors.white,
                          icon: Icons.airline_seat_recline_normal,
                          title: 'Agents',
                          textColor: Colors.white,
                          backgroundColor: Colors.deepOrange,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductScreen(),
                                ));
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconCard(
                          iconColor: Colors.blue,
                          icon: Icons.receipt,
                          title: 'Transaction',
                          textColor: Colors.black,
                          backgroundColor: Colors.white,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TransactionScreen(),
                                ));
                          },
                        ),
                      ),
                    )
                  ],
                )
              ]),
        ),
      ),
    ));
  }
}
