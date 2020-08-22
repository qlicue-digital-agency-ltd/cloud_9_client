import 'package:cloud_9_client/screens/background.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
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
             pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                title: Text(
                  'Help',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(
                height: 15,
              ),
              ListTile(
                  leading: const Icon(Icons.call, color: Colors.deepOrange),
                  title: Text('Call Us'),
                  onTap: () {
                    print('Call Us');
                    _launchURL("tel:+255756210703");
                  }),
              Divider(),
              ListTile(
                leading:
                    const Icon(Icons.mail_outline, color: Colors.deepOrange),
                title: Text('Message us'),
                onTap: () {
                  print('Message');
                  _launchURL("sms:+255756210703");
                },
              ),
              Divider(),
              ListTile(
                  leading: const Icon(Icons.email, color: Colors.deepOrange),
                  title: Text(' Email us'),
                  onTap: () {
                    print('Email us');
                    _launchURL(
                        "mailto:artivation18@gmail.com?subject=Hello&body=Sir/Madam");
                  }),
              Divider(),
            ])),
          ],
        ),
      ),
    ));
  }

  void _launchURL(String uri) async {
    String url = uri;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not launch';
    }
  }
}
