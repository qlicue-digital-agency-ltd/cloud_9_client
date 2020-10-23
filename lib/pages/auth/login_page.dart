import 'package:cloud_9_client/components/text-fields/label_text_field.dart';

import 'package:cloud_9_client/constants/constants.dart';
import 'package:cloud_9_client/pages/auth/register_page.dart';
import 'package:cloud_9_client/pages/background/background.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  bool _isObscure = true;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: Color(0xFF6395e6),
      body: Stack(
        children: [
          Background(),
          SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage(
                            'assets/icons/cloud9_transparent_logo.png'))),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.0),
                  child: Text('CLOUD9 CLINIC',
                      style: TextStyle(
                          fontFamily: 'trajanProRegular',
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    color: Color(0xFF6395e6),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 50.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: LabelTextfield(
                            prefixIcon: FontAwesomeIcons.envelope,
                            message: 'Please enter your email',
                            maxLines: 1,
                            hitText: 'Email',
                            labelText: null,
                            focusNode: _emailFocusNode,
                            textEditingController: _emailEditingController,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: TextFormField(
                              focusNode: _passwordFocusNode,
                              controller: _passwordEditingController,
                              obscureText: _isObscure,
                              onChanged: (String value) {},
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                              cursorColor: Theme.of(context).cursorColor,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  prefixIcon: Material(
                                    elevation: 0,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    child: Icon(
                                      Icons.lock,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  suffixIcon: InkWell(
                                    splashColor: Theme.of(context).primaryColor,
                                    highlightColor: Colors.transparent,
                                    child: Icon(_isObscure
                                        ? FontAwesomeIcons.eye
                                        : FontAwesomeIcons.eyeSlash),
                                    onTap: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    },
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 13)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    color: Colors.white,
                                    child: Container(
                                      height: 50,
                                      child: Center(
                                          child: _authProvider.isSignInUser
                                              ? CircularProgressIndicator()
                                              : Text(
                                                  "LOG IN",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontFamily:
                                                          "WorkSansBold"),
                                                )),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        _authProvider
                                            .signInUser(
                                                email: _emailEditingController
                                                    .text,
                                                password:
                                                    _passwordEditingController
                                                        .text)
                                            .then((val) {
                                          if (!val) {
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    homeScreen);
                                          } else {
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    landingScreen);
                                          }
                                        });
                                      }
                                    }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: "WorkSansMedium",
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: FlatButton(
                      onPressed: () {
                        //showInSnackBar("Not implemented yet");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ));
                      },
                      child: Text(
                        "Don't have an account? Sign Up!",
                        style: TextStyle(
                           decoration: TextDecoration.underline,
                            color: Colors.white,
                            fontSize: 16.0,
                            fontFamily: "WorkSansMedium",
                            fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          )),
        ],
      ),
    );
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }
}
