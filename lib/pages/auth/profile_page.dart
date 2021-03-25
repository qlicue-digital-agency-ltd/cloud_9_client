import 'package:cloud_9_client/components/buttons/custom_string_dropdown.dart';

import 'package:cloud_9_client/components/text-fields/label_text_field.dart';
import 'package:cloud_9_client/components/text-fields/mobile_number.dart';
import 'package:cloud_9_client/constants/constants.dart';
import 'package:cloud_9_client/pages/background/background.dart';
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

  final FocusNode _fullnameFocusNode = FocusNode();
  final FocusNode _locationFocusNode = FocusNode();
  final FocusNode _mobileFocusNode = FocusNode();

  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _locationTextEditingController =
      TextEditingController();
  TextEditingController _mobileTextEditingController = TextEditingController();

  @override
  void dispose() {
    _fullnameFocusNode.dispose();
    _locationFocusNode.dispose();
    _mobileFocusNode.dispose();
    _fullnameController.dispose();
    _locationTextEditingController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    _fullnameController.text = _authProvider.authenticatedUser.profile.fullname;
    _locationTextEditingController.text = _authProvider.authenticatedUser.profile.location;
    _mobileTextEditingController.text = _authProvider.authenticatedUser.profile.phone;
    return Scaffold(
      backgroundColor: Colors.white54,
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
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: AppBar(
                    leading: Container(),
                    elevation: 0,
                    title: Text(
                      'Profile',
                      style: TextStyle(color: Color(0xFF6395e6)),
                    ),
                    backgroundColor: Colors.transparent,
                    iconTheme: IconThemeData(
                      color: Color(0xFF6395e6), //change your color here
                    ),
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
                            ' Select an Image!',
                            style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    color: Color(0xFF6395e6),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: LabelTextfield(
                            prefixIcon: FontAwesomeIcons.user,
                            message: 'Please enter your fullname',
                            maxLines: 1,
                            hitText: 'Fullname',
                            labelText: null,
                            focusNode: _fullnameFocusNode,
                            textEditingController: _fullnameController,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: MobileTextfield(
                            message: 'Please enter Mobile Number',
                            maxLines: 1,
                            hitText: 'Mobile',
                            labelText: null,
                            focusNode: _mobileFocusNode,
                            textEditingController: _mobileTextEditingController,
                            keyboardType: TextInputType.number,
                            selectedCountry: _authProvider.selectedCountry,
                            onCodeChange: (country) {
                              print(country);
                              _authProvider.setSelectedCountry = country;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: LabelTextfield(
                            prefixIcon: FontAwesomeIcons.locationArrow,
                            message: 'Please enter Location, dristict or ward',
                            maxLines: 1,
                            hitText: 'Location',
                            labelText: null,
                            focusNode: _locationFocusNode,
                            textEditingController: _locationTextEditingController,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
                            child: CustomStringDropdown(
                              items: _authProvider.genderList,
                              onChange: (val) {
                                _authProvider.setSelectedGender = val;
                              },
                              title: 'Gender',
                              value: _authProvider.selectedGender,
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 0.0, left: 25.0, right: 25.0),
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
                                          child: _authProvider
                                                  .isSubmitingProfileData
                                              ? CircularProgressIndicator()
                                              : Text(
                                                  "SAVE",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontFamily: "WorkSansBold"),
                                                )),
                                    ),
                                    onPressed: () {
                                      final _phone = _authProvider
                                              .selectedCountry.dialingCode +
                                          _mobileTextEditingController.text
                                              .replaceAll('(', '')
                                              .replaceAll(')', '')
                                              .replaceAll('-', '')
                                              .replaceAll(' ', '');

                                      if (_formKey.currentState.validate()) {
                                        if (_authProvider.pickedImage != null) {
                                          _authProvider
                                              .updateProfile(
                                                  fullname:
                                                      _fullnameController.text,
                                                  location:
                                                      _locationTextEditingController
                                                          .text,
                                                  phone: _phone)
                                              .then((val) {
                                            if (!val) {
                                              _locationTextEditingController
                                                  .clear();
                                              _fullnameController.clear();
                                              _mobileTextEditingController.clear();

                                              _authProvider
                                                  .autoAuthenticate()
                                                  .then((value) {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        homeScreen);
                                              });
                                              print(
                                                  'iiiii---------------iiiiiiiiiiiiiiiii');
                                              print(_authProvider.authenticatedUser
                                                  .profile.avatar);
                                              print(
                                                  'iiiiiiiiiiii+++++++++++++++iiiiiiiiii');
                                            }
                                          });
                                        } else {
                                          showInSnackBar('Select profile Image');
                                        }
                                      }
                                    }),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 40, right: 40, top: 20),
                          child: Divider(),
                        ),
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
      backgroundColor: Colors.deepOrange,
      duration: Duration(seconds: 3),
    ));
  }
}
