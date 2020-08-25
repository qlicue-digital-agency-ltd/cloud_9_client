import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/components/card/icon_card.dart';
import 'package:cloud_9_client/components/card/notification_card.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:cloud_9_client/screens/appointment_screen.dart';
import 'package:cloud_9_client/screens/background.dart';
import 'package:cloud_9_client/screens/education_screen.dart';
import 'package:cloud_9_client/screens/procedure_sreen.dart';
import 'package:cloud_9_client/screens/product_screen.dart';

import 'package:cloud_9_client/screens/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'consultation_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Background(
        screen: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(_authProvider
                                .authenticatedUser.profile.avatar))),
                  ),
                ),
                SizedBox(height: 100),
                Text(
                  'Hello,',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w100,
                      color: Colors.white),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      _authProvider.authenticatedUser.profile.fullname + ',',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Icon(
                        _authProvider.authenticatedUser.profile.gender ==
                                "female"
                            ? FontAwesomeIcons.female
                            : FontAwesomeIcons.male,
                        size: 30,
                        color: Colors.blue)
                  ],
                ),
                SizedBox(height: 20),
                Material(
                  color: Colors.white,
                  elevation: 2,
                  borderRadius: BorderRadius.circular(20),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductScreen(),
                          ));
                    },
                    leading: Icon(
                      Icons.search,
                      color: Colors.blue[700],
                    ),
                    title: Text(
                      'Search products.....',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(height: 20),
//                NotificationCard(),
                SizedBox(height: 20),
                Text(
                  'What do you need?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                MediaQuery.of(context).size.width > 330
                    ? Container(
                        child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconCard(
                                    iconColor: Colors.white,
                                    icon: 'assets/icons/calendar.png',
                                    title: 'Appointment',
                                    textColor: Colors.white,
                                    backgroundColor: Colors.deepOrange,
                                    onTap: () {
                                      print('object');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AppointmentScreen(),
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
                                    icon: 'assets/icons/procedure.png',
                                    title: 'Procedures',
                                    textColor: Colors.blue[700],
                                    backgroundColor: Colors.white,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProcedureScreen(),
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
                                    icon: 'assets/icons/product.png',
                                    title: 'Products',
                                    textColor: Colors.white,
                                    backgroundColor: Colors.deepOrange,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductScreen(),
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
                                    icon: 'assets/icons/consultation.png',
                                    title: 'Consultation',
                                    textColor: Colors.blue[700],
                                    backgroundColor: Colors.white,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ConsultationScreen(),
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
                                    icon: 'assets/icons/agent.png',
                                    title: 'Eduction',
                                    textColor: Colors.white,
                                    backgroundColor: Colors.deepOrange,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EducationScreen(),
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
                                    icon: 'assets/icons/transaction.png',
                                    title: 'Transaction',
                                    textColor: Colors.blue[700],
                                    backgroundColor: Colors.white,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TransactionScreen(),
                                          ));
                                    },
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ))
                    : Container(
                        child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconCard(
                                    iconColor: Colors.white,
                                    icon: 'assets/icons/calendar.png',
                                    title: 'Appointment',
                                    textColor: Colors.white,
                                    backgroundColor: Colors.deepOrange,
                                    onTap: () {
                                      print('object');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AppointmentScreen(),
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
                                    icon: 'assets/icons/procedure.png',
                                    title: 'Procedures',
                                    textColor: Colors.blue[700],
                                    backgroundColor: Colors.white,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProcedureScreen(),
                                          ));
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconCard(
                                    iconColor: Colors.white,
                                    icon: 'assets/icons/product.png',
                                    title: 'Products',
                                    textColor: Colors.white,
                                    backgroundColor: Colors.deepOrange,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductScreen(),
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
                                    icon: 'assets/icons/consultation.png',
                                    title: 'Consultation',
                                    textColor: Colors.blue[700],
                                    backgroundColor: Colors.white,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ConsultationScreen(),
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
                                    iconColor: Colors.white,
                                    icon: 'assets/icons/agent.png',
                                    title: 'Eduction',
                                    textColor: Colors.white,
                                    backgroundColor: Colors.deepOrange,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EducationScreen(),
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
                                    icon: 'assets/icons/transaction.png',
                                    title: 'Transaction',
                                    textColor: Colors.black,
                                    backgroundColor: Colors.white,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TransactionScreen(),
                                          ));
                                    },
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ))
              ]),
        ),
      ),
    ));
  }
}
