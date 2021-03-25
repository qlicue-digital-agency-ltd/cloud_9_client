import 'package:cloud_9_client/constants/constants.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:cloud_9_client/provider/weight_care_provider.dart';
import 'package:cloud_9_client/screens/account_screen.dart';
import 'package:cloud_9_client/screens/order_screen.dart';
import 'package:cloud_9_client/screens/weight_care_screen.dart';
import 'package:cloud_9_client/screens/diary_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'help_screen.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}



class _DrawerScreenState extends State<DrawerScreen> {
  bool _value2 = false;

  bool _loadDiary = false;

  void _onChanged2(bool value) {
    setState(() => _value2 = value);
    print(_value2);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    final _weightCareProvider = Provider.of<WeightCareProvider>(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(color: Colors.blue),
      child: Container(
          child: SafeArea(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                    currentAccountPicture: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            _authProvider.authenticatedUser.profile.avatar),
                        onBackgroundImageError: (object, stackTrace) => Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    accountName:
                        Text(_authProvider.authenticatedUser.profile.fullname),
                    accountEmail: Text(_authProvider.authenticatedUser.email),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('CODE: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                      // Spacer(),
                      Text(_authProvider.authenticatedUser.profile.uuid,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)
                    ],
                  ),
                ),
                Material(
                  child: ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AccountScreen(),
                          ));
                    },
                    leading: Icon(Icons.account_box),
                    title: Text('Account'),
                  ),
                ),
                SizedBox(height: 2),
                Material(
                  child: ListTile(
                    leading: Icon(Icons.accessibility, color: Colors.grey[600]),
                    title: Text('Weight Care'),
                    trailing: _loadDiary
                        ? CircularProgressIndicator(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            strokeWidth: 0.5,
                          )
                        : null,
                    onTap: () {
                      if (_weightCareProvider.activeDiary != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WeightCareScreen()));
                      } else {
                        if (!mounted) return;
                        setState(() {
                          _loadDiary = true;
                        });
                        _weightCareProvider
                            .fetchDiaries(_authProvider.authenticatedUser.id)
                            .then((response) {
                          print(
                              '*************************  FINISHED ******************');
                          print(response['message']);
                          setState(() {
                            _loadDiary = false;
                          });
                          if (response['status']) {
                            if (_weightCareProvider.diaries.isEmpty) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DiaryScreen()));
                            } else
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          WeightCareScreen()));
                          }
                        });
                      }
                    },
                  ),
                ),
                SizedBox(height: 2),
                Material(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 16,
                      ),
                      Icon(
                        Icons.notifications,
                        color: Colors.grey[600],
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: SwitchListTile(
                          value: _value2,
                          onChanged: _onChanged2,
                          title: new Text('Notification',
                              style:
                                  new TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2),
                Material(
                  child: ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HelpScreen(),
                          ));
                    },
                    leading: Icon(Icons.help),
                    title: Text('Help'),
                  ),
                ),
                SizedBox(height: 2),
                // Material(
                //   child: ListTile(
                //     onTap: () {

                //       Navigator.pop(context);
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => TermsAndConditionsScreen(),
                //           ));
                //     },
                //     leading: Icon(Icons.book),
                //     title: Text('Terms & Conditions'),
                //   ),
                // ),
                // SizedBox(height: 2),
                Material(
                  child: ListTile(
                    onTap: () {
                      print('object');
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderScreen(),
                          ));
                    },
                    leading: Icon(Icons.book),
                    title: Text('My Orders'),
                  ),
                ),
                SizedBox(height: 2),
                Material(
                  child: ListTile(
                    onTap: () {
                      print('object');
                      _authProvider.logout().then((value) {
                        Navigator.of(context).pushReplacementNamed(loginScreen);
                      });
                    },
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Log Out'),
                  ),
                ),
                SizedBox(height: 50)
              ],
            ),
          ),
        ),
      )),
    );
  }
}
