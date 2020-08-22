import 'package:cloud_9_client/components/card/procedure_appointment_card.dart';
import 'package:cloud_9_client/models/procedure.dart';
import 'package:cloud_9_client/models/service.dart';
import 'package:cloud_9_client/provider/appointment_provider.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:cloud_9_client/provider/category_provider.dart';
import 'package:cloud_9_client/screens/background.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SetAppointmentScreen extends StatefulWidget {
  final Service service;

  SetAppointmentScreen({Key key, @required this.service}) : super(key: key);

  @override
  _SetAppointmentScreenState createState() => _SetAppointmentScreenState();
}

class _SetAppointmentScreenState extends State<SetAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _codeFocusNode = FocusNode();

  TextEditingController _codeTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _categoryProvider = Provider.of<CategoryProvider>(context);
    final _appointmentProvider = Provider.of<AppointmentProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context);
    void _showAgentDialog(context, Procedure procedure) {
      // flutter defined function
      showDialog(
        context: context,
        builder: (
          BuildContext context,
        ) {
          // return object of type Dialog
          return AlertDialog(
            title: Text("Book Now!"),
            content: Container(
              height:  MediaQuery.of(context).size.height/3,
              child: Column(children: <Widget>[
                Text("Add Agent Code"),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: Colors.blue,
                            primaryColorDark: Colors.red[50],
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter Agent Code';
                              } else
                                return null;
                            },
                            focusNode: _codeFocusNode,
                            controller: _codeTextController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                                focusColor: Colors.blue,
                                fillColor: Colors.blue,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(color: Colors.blue)),
                                hintText: "Agent Code",
                                labelText: "Agent Code",
                                labelStyle: TextStyle(color: Colors.blue),
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 17.0,
                                    color: Colors.white),
                                prefixIcon: Icon(
                                  FontAwesomeIcons.cog,
                                  size: 22.0,
                                  color: Colors.blue,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 2,
                  endIndent: 2,
                ),
                Row(children: <Widget>[
                  Expanded(
                      child: RaisedButton(
                          color: Colors.blue,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _appointmentProvider
                                  .postAppointment(
                                      agentUuid: _codeTextController.text,
                                      userId:
                                          _authProvider.authenticatedUser.id,
                                      senderId: procedure.id,
                                      sender: 'procedure')
                                  .then((value) {
                                if (_appointmentProvider
                                    .isCreatingAppointmentData) {
                                } else {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              });
                            }
                          },
                          child: _appointmentProvider.isCreatingAppointmentData
                              ? CircularProgressIndicator()
                              : Text(
                                  'CONFIRM',
                                  style: TextStyle(color: Colors.white),
                                ))),
                ])
              ]),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void _showDialog(context, name, Procedure procedure) {
      // flutter defined function
      showDialog(
        context: context,
        builder: (
          BuildContext context,
        ) {
          // return object of type Dialog
          return AlertDialog(
            title: Text("Book Now!"),
            content: Container(
              height:  MediaQuery.of(context).size.height/3,
              child: Column(children: <Widget>[
                Text("Please confirm your booking for " + name),
                Divider(
                  indent: 2,
                  endIndent: 2,
                ),
                Row(children: <Widget>[
                  Text("Use Agent: "),
                  Expanded(
                      child: RaisedButton(
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.pop(context);
                            _showAgentDialog(context, procedure);
                          },
                          child: Text(
                            'Agent CODE',
                            style: TextStyle(color: Colors.white),
                          ))),
                ]),
                Row(children: <Widget>[
                  Text("Direct to Clinic: "),
                  Expanded(
                      child: RaisedButton(
                          color: Colors.blue,
                          onPressed: () {
                            
                              _appointmentProvider
                                  .postAppointment(
                                      agentUuid: null,
                                      userId:
                                          _authProvider.authenticatedUser.id,
                                      senderId: procedure.id,
                                      sender: 'procedure')
                                  .then((value) {
                                if (_appointmentProvider
                                    .isCreatingAppointmentData) {
                                } else {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              });
                            
                          },
                          child: Text(
                            'CONFIRM',
                            style: TextStyle(color: Colors.white),
                          ))),
                ])
              ]),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Background(
        screen: SafeArea(
      child: Container(
        padding: EdgeInsets.only(top: 20, left: 5, right: 5),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                'Set Appointments',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
              ),
             actions: <Widget>[],
            ),
            SizedBox(height: 100),
            Row(children: <Widget>[
              SizedBox(width: 20),
              InkWell(
                onTap: () {
                  if (_categoryProvider.procedurePosition > 1)
                    _categoryProvider.toNextProdure(-1);
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      height: 50,
                      width: 50,
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Text(
                _categoryProvider.procedurePosition.toString() +
                    '/' +
                    widget.service.procedures.length.toString(),
                style: TextStyle(fontSize: 30),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  if (_categoryProvider.procedurePosition <
                      widget.service.procedures.length)
                    _categoryProvider.toNextProdure(1);
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      height: 50,
                      width: 50,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
            ]),
            SizedBox(height: 10),
            ProcedureAppointmentCard(
              onTapConfirm: () {
                _showDialog(
                    context,
                    widget.service.title,
                    widget.service
                        .procedures[_categoryProvider.procedurePosition - 1]);
              },
              icon: 'assets/icons/procedure.png',
              procedure: widget
                  .service.procedures[_categoryProvider.procedurePosition - 1],
              name: widget.service.title,
            )
          ]),
        ),
      ),
    ));
  }
}
