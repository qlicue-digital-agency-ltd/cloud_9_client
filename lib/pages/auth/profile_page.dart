import 'package:cloud_9_client/components/buttons/dropdown_button.dart';
import 'package:cloud_9_client/constants/constants.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _fullnameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF6395e6),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: AppBar(
                leading: Container(),
                elevation: 0,
                title: Text('Profile'),
                backgroundColor: Colors.transparent,
                actions: <Widget>[],
              ),
            ),
            Center(
                child: InkWell(
              onTap: () {
                _authProvider.chooseAmImage();
              },
              child: Container(
                height: 180,
                width: MediaQuery.of(context).size.width / 2,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      _authProvider.pickedImage == null
                          ? CircleAvatar(
                              radius: 60,
                              child: Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          FileImage(_authProvider.pickedImage),
                                      fit: BoxFit.cover)),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        ' Select menu Image!',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            )),
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
                      return 'Please enter your fullname';
                    } else
                      return null;
                  },
                  focusNode: emailFocusNode,
                  controller: _fullnameController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      fontSize: 16.0,
                      color: Colors.black),
                  decoration: InputDecoration(
                      focusColor: Colors.white,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.white)),
                      hintText: "Fullname",
                      labelText: "Fullname",
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
                  child: CustomDropdownButton(
                    value: _authProvider.selectedGender,
                    item: _authProvider.genderList,
                    title: 'Gender',
                    customDropdownButtonOnChange: (String val) {
                      print(val);
                      _authProvider.setSelectedGender = val;
                    },
                  )),
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
                      return 'Please enter your phone';
                    } else
                      return null;
                  },
                  focusNode: passwordFocusNode,
                  controller: _locationController,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      fontSize: 16.0,
                      color: Colors.black),
                  decoration: InputDecoration(
                      focusColor: Colors.white,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: "Phone",
                      labelText: "Phone",
                      hintStyle: TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 17.0,
                          color: Colors.white),
                      prefixIcon: Icon(
                        FontAwesomeIcons.phoneAlt,
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
                      return 'Please enter your location';
                    } else
                      return null;
                  },
                  focusNode: confirmPasswordFocusNode,
                  controller: _phoneController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      fontSize: 16.0,
                      color: Colors.black),
                  decoration: InputDecoration(
                      focusColor: Colors.white,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: "location",
                      labelText: "location",
                      hintStyle: TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          fontSize: 17.0,
                          color: Colors.white),
                      prefixIcon: Icon(
                        FontAwesomeIcons.locationArrow,
                        size: 22.0,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0),
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.blue,
                    offset: Offset(1.0, 6.0),
                    blurRadius: 20.0,
                  ),
                  BoxShadow(
                    color: Colors.blueAccent,
                    offset: Offset(1.0, 6.0),
                    blurRadius: 20.0,
                  ),
                ],
                gradient: new LinearGradient(
                    colors: [Colors.deepOrange, Colors.blue],
                    begin: const FractionalOffset(0.2, 0.2),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: MaterialButton(
                  highlightColor: Colors.transparent,
                  splashColor: Color(0xFF6395e6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 42.0),
                    child: _authProvider.isSubmitingProfileData
                        ? CircularProgressIndicator()
                        : Text(
                            "Save & Proceed",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: "WorkSansBold"),
                          ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      if (_authProvider.pickedImage != null) {
                        _authProvider
                            .updateProfile(
                                fullname: _fullnameController.text,
                                location: _locationController.text,
                                phone: _phoneController.text)
                            .then((val) {
                          if (!val) {
                            _locationController.clear();
                            _fullnameController.clear();
                            _phoneController.clear();

                            _authProvider.autoAuthenticate().then((value) {
                                Navigator.of(context)
                                    .pushReplacementNamed(homeScreen);
                            });
                            print('iiiii---------------iiiiiiiiiiiiiiiii');
                            print(_authProvider.authenticatedUser.profile.avatar);
                            print('iiiiiiiiiiii+++++++++++++++iiiiiiiiii');
                          }
                        });
                      } else {
                        showInSnackBar('Select profile Image');
                      }
                    }
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 40, top: 20),
              child: Divider(),
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
      backgroundColor: Colors.deepOrange,
      duration: Duration(seconds: 3),
    ));
  }
}
