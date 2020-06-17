import 'package:cloud_9_client/screens/terms_and_condition.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(color: Colors.blue),
      child: Container(
          child: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/lisa.jpeg')),
                  accountName: Text('Hawa Ally'),
                  accountEmail: Text('kalrobbynson@gmail.com')),
              Material(
                child: ListTile(
                  onTap: () {
                    print('object');
                  },
                  leading: Icon(Icons.account_box),
                  title: Text('Account'),
                ),
              ),
              SizedBox(height: 2),
              Material(
                child: ListTile(
                  onTap: () {
                    print('object');
                  },
                  leading: Icon(Icons.notifications),
                  title: Text('Notifications'),
                ),
              ),
              SizedBox(height: 2),
              Material(
                child: ListTile(
                  onTap: () {
                    print('object');
                  },
                  leading: Icon(Icons.help),
                  title: Text('Help'),
                ),
              ),
              SizedBox(height: 2),
              Material(
                child: ListTile(
                  onTap: () {
                    print('object');
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TermsAndConditionsScreen(),
                        ));
                  },
                  leading: Icon(Icons.book),
                  title: Text('Terms & Conditions'),
                ),
              ),
              SizedBox(height: 2),
              Spacer(),
              Material(
                child: ListTile(
                  onTap: () {
                    print('object');
                  },
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Log Out'),
                ),
              ),
              SizedBox(height: 50)
            ],
          ),
        ),
      )),
    );
  }
}
