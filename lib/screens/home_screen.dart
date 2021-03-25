import 'package:cloud_9_client/components/card/icon_card.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:cloud_9_client/screens/appointment_screen.dart';
import 'package:cloud_9_client/screens/background.dart';
import 'package:cloud_9_client/screens/education_screen.dart';
import 'package:cloud_9_client/screens/procedure_sreen.dart';
import 'package:cloud_9_client/screens/product_screen.dart';

import 'package:cloud_9_client/screens/transactions_screen.dart';
import 'diary_screen.dart';
import 'weight_care_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:cloud_9_client/provider/weight_care_provider.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_core/firebase_core.dart';

import 'consultation_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp();
    assert(app != null);
    print('Initialized default app $app');
  }

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }

  void initDynamicLinks() async {
    await initializeDefault();
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        // print(deepLink.data.parameters.toString());
        if (deepLink.queryParameters['page'] == 'appointments') {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AppointmentScreen(),
              ));
        }
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      // print(deepLink.data.parameters.toString());
      if (deepLink.queryParameters['page'] == 'appointments') {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppointmentScreen(),
            ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    final _weightCareProvider = Provider.of<WeightCareProvider>(context);
    bool _loadDiary = false;
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
                            image: NetworkImage(
                                _authProvider.authenticatedUser.profile.avatar),
                            onError: (object, stackTrace) => Icon(Icons.person,
                                color: Colors.white, size: 20))),
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
                //  SizedBox(height: 20),
                //  NotificationCard(),
                SizedBox(height: 20),
                Text(
                  'What do you need?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Container(
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
                              icon: 'assets/icons/procedure.png',
                              title: 'Procedures',
                              textColor: Colors.blue[700],
                              backgroundColor: Colors.white,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProcedureScreen(),
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
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
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
                          child: StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) =>
                                    Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconCard(
                                iconColor: Colors.blue,
                                icon: 'assets/icons/weight.png',
                                title: 'Weight Care',
                                textColor: Colors.white,
                                backgroundColor: Colors.deepOrange,
                                loader: _loadDiary
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.white,
                                          strokeWidth: 1,
                                        ),
                                      )
                                    : null,
                                onTap: () {
                                  if (_weightCareProvider.activeDiary != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WeightCareScreen()));
                                  } else {
                                    setState(() {
                                      _loadDiary = true;
                                    });
                                    _weightCareProvider
                                        .fetchDiaries(
                                            _authProvider.authenticatedUser.id)
                                        .then((response) {
                                      setState(() {
                                        _loadDiary = false;
                                      });
                                      if (response['status']) {
                                        if (_weightCareProvider
                                            .diaries.isEmpty) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DiaryScreen()));
                                        } else
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WeightCareScreen()));
                                      } else {
                                        showInSnackBar(response['message'],
                                            context: context);
                                      }
                                    });
                                  }
                                },
                              ),
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
                              title: 'Education',
                              textColor: Colors.white,
                              backgroundColor: Colors.deepOrange,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EducationScreen(),
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
                                      builder: (context) => TransactionScreen(),
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

  void showInSnackBar(String value,
      {Color color, @required BuildContext context}) {
    final scaffold = Scaffold.of(context);
    FocusScope.of(context).requestFocus(new FocusNode());
    scaffold.removeCurrentSnackBar();
    scaffold.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: color ?? Colors.red,
      duration: Duration(seconds: 3),
    ));
  }
}
