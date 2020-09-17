import 'package:cloud_9_client/constants/constants.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _obscureTextLogin = true;

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Register'),
      ),
      key: _scaffoldKey,
      backgroundColor: Color(0xFF6395e6),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(
                        'assets/icons/cloud9_transparent_logo.png'))),
            Padding(
              padding: EdgeInsets.only(top: 1.0),
              child: Text('CLOUD9 CLINIC',
                  style: TextStyle(
                      fontFamily: 'trajanProRegular',
                      fontSize: 25.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
              child: Theme(
                data: new ThemeData(
                  primaryColor: Colors.white,
                  primaryColorDark: Colors.red[50],
                ),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your email';
                    } else
                      return null;
                  },
                  focusNode: emailFocusNode,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      
                      fontFamily: "WorkSansSemiBold",
                      fontSize: 16.0,
                      color: Colors.white),
                  decoration: InputDecoration(
                      focusColor: Colors.white,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: "Email",
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 17.0,
                          color: Colors.white),
                      prefixIcon: Icon(
                        FontAwesomeIcons.user,
                        size: 22.0,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
              child: Theme(
                data: new ThemeData(
                  primaryColor: Colors.white,
                  primaryColorDark: Colors.red[50],
                ),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your password';
                    } else
                      return null;
                  },
                  focusNode: passwordFocusNode,
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: _obscureTextLogin,
                  style: TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      fontSize: 16.0,
                      color: Colors.white),
                  decoration: InputDecoration(
                      focusColor: Colors.white,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: "Password",
                      labelText: "Password",
                      hintStyle: TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 17.0,
                          color: Colors.white),
                      suffixIcon: InkWell(
                        onTap: () {
                          print('object');
                          setState(() {
                            _obscureTextLogin = !_obscureTextLogin;
                          });
                        },
                        child: Icon(
                          _obscureTextLogin
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          size: 15.0,
                          color: Colors.white,
                        ),
                      ),
                      prefixIcon: Icon(
                        FontAwesomeIcons.lock,
                        size: 22.0,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
              child: Theme(
                data: new ThemeData(
                  primaryColor: Colors.white,
                  primaryColorDark: Colors.red[50],
                ),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your password';
                    } else
                      return null;
                  },
                  focusNode: confirmPasswordFocusNode,
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.text,
                  obscureText: _obscureTextLogin,
                  style: TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      fontSize: 16.0,
                      color: Colors.white),
                  decoration: InputDecoration(
                      focusColor: Colors.white,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: "Confirm Password",
                      labelText: "Confirm Password",
                      hintStyle: TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 17.0,
                          color: Colors.white),
                      suffixIcon: InkWell(
                        onTap: () {
                          print('object');
                          setState(() {
                            _obscureTextLogin = !_obscureTextLogin;
                          });
                        },
                        child: Icon(
                          _obscureTextLogin
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          size: 15.0,
                          color: Colors.white,
                        ),
                      ),
                      prefixIcon: Icon(
                        FontAwesomeIcons.lock,
                        size: 22.0,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        color: Colors.white,
                        child: Container(
                          height: 50,
                          child: Center(
                            
                              child: _authProvider.isSignInUser
                                  ? CircularProgressIndicator()
                                  : Text(
                                      "REGISTER",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Theme.of(context).primaryColor,
                                          fontFamily: "WorkSansBold"),
                                    )),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            if (passwordController.text ==
                                confirmPasswordController.text) {
                              _authProvider
                                  .registerUser(
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((response) {
                                if (response['success']) {
                                  Navigator.of(context)
                                      .pushReplacementNamed(profileScreen);
                                }else{
                                  showInSnackBar('Error: ${response['message']}');
                                }
                              });
                            } else {
                              showInSnackBar('Passwords don\'t match');
                            }
                          }
                        }),
                  ),
                ],
              ),
            ),
            
            SizedBox(
              height: 100,
            )
          ],
        ),
      )),
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
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ));
  }
}
