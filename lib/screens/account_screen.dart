
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _value2 = false;

  void _onChanged2(bool value) {
    setState(() => _value2 = value);
    print(_value2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Account',
        style: TextStyle(color: Colors.white),
      )),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 15,
            ),
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.deepOrange),
              title: Text('Reset Password'),
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: Text('Delete Account'),
              onTap: () {
                _showDialog(context);
              },
            ),
            Divider(),
            SwitchListTile(
              value: _value2,
              onChanged: _onChanged2,
              title: new Text('Deactivate Account',
                  style: new TextStyle(fontWeight: FontWeight.bold)),
            ),
            Divider(),
          ])),
        ],
      ),
    );
  }

  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Delete Account?"),
          content: Text("This will permanently delete your acount"),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "Delete",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();

                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        );
      },
    );
  }
}
