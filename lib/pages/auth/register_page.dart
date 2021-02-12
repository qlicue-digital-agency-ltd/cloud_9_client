import 'package:cloud_9_client/components/text-fields/label_text_field.dart';
import 'package:cloud_9_client/constants/constants.dart';
import 'package:cloud_9_client/pages/background/background.dart';
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

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  String passwordText = '';
  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  TextEditingController _confirmPasswordTextEditingController =
      TextEditingController();
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
      backgroundColor: Colors.white54,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Color(0xFF6395e6), //change your color here
        ),
        elevation: 0,
        title: Text(
          'Register',
          style: TextStyle(color: Color(0xFF6395e6)),
        ),
      ),
      key: _scaffoldKey,
      //   backgroundColor: Color(0xFF6395e6),
      body: Stack(
        children: [
          Background(),
          SingleChildScrollView(
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
                          child: Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: TextFormField(
                              focusNode: _emailFocusNode,
                              controller: _emailEditingController,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () {
                                _emailFocusNode.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode);
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter Email';
                                }
                                else if (!RegExp(
                                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                    .hasMatch(value)){
                                  return 'Please enter valid email';
                                }

                               else return null;
                              },
                              cursorColor: Theme.of(context).cursorColor,
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  prefixIcon: Material(
                                    elevation: 0,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                    child: Icon(
                                      Icons.mail_outline,
                                      color: Theme.of(context).primaryColor,
                                    ),
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
                          child: Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: TextFormField(
                              focusNode: _passwordFocusNode,
                              controller: _passwordEditingController,
                              obscureText: _isObscure,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: (){
                                _passwordFocusNode.unfocus();
                                FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
                              },
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
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: TextFormField(
                              focusNode: _confirmPasswordFocusNode,
                              controller: _confirmPasswordTextEditingController,
                              obscureText: _isObscure,
                              textInputAction: TextInputAction.send,
                              onEditingComplete: () {
                                _confirmPasswordFocusNode.unfocus();
                                register(_authProvider);
                              },
                              validator: (value) {
                                if (value != _passwordEditingController.text) {
                                  return 'Password mismatch';
                                }
                                return null;
                              },
                              cursorColor: Theme.of(context).cursorColor,
                              decoration: InputDecoration(
                                  hintText: "Confirm Password",
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
                          padding: EdgeInsets.symmetric(horizontal: 32),
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
                                                  "REGISTER",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontFamily:
                                                          "WorkSansBold"),
                                                )),
                                    ),
                                    onPressed: () {
                                      register(_authProvider);
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
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ));
  }

  void register(AuthProvider _authProvider){
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      if (_passwordEditingController.text ==
          _confirmPasswordTextEditingController
              .text) {
        _authProvider
            .registerUser(
            email: _emailEditingController
                .text,
            password:
            _passwordEditingController
                .text)
            .then((response) {
          if (response['status']) {
            Navigator.of(context)
                .pushReplacementNamed(
                profileScreen);
          }else{

            showInSnackBar(response['message']);
          }
        });
      } else {
        showInSnackBar(
            'Passwords don\'t match');
      }
    }
  }
}
