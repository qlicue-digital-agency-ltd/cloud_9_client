import 'package:cloud_9_client/components/card/consultation_list_card.dart';
import 'package:cloud_9_client/models/consultation.dart';
import 'package:cloud_9_client/provider/appointment_provider.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';

import 'package:cloud_9_client/screens/service_detail_screen.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ConsultationListScreen extends StatefulWidget {
  final List<Consultation> consultations;

  ConsultationListScreen({Key key, @required this.consultations})
      : super(key: key);

  @override
  _ConsultationListScreenState createState() => _ConsultationListScreenState();
}

class _ConsultationListScreenState extends State<ConsultationListScreen> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _codeFocusNode = FocusNode();

  TextEditingController _codeTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _appointmentProvider = Provider.of<AppointmentProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context);
    void _showAgentDialog(context, Consultation consultation) {
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
              height: MediaQuery.of(context).size.height / 3,
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
                                  .postConsultationAppointment(
                                agentUuid: _codeTextController.text,
                                userId: _authProvider.authenticatedUser.id,
                                consultationId: consultation.id,
                              )
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

    void _showDialog(context, name, Consultation consultation) {
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
              height: MediaQuery.of(context).size.height / 3,
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
                            _showAgentDialog(context, consultation);
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
                                .postConsultationAppointment(
                              agentUuid: null,
                              userId: _authProvider.authenticatedUser.id,
                              consultationId: consultation.id,
                            )
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

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Consultation',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView.builder(
            itemCount: widget.consultations.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ConsultationListCard(
                  onViewTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ServiceDetailScreen(
                            service: widget.consultations[index].service,
                          ),
                        ));
                  },
                  consultation: widget.consultations[index],
                  onBookTap: () {
                    _showDialog(
                        context,
                        widget.consultations[index].service.title,
                        widget.consultations[index]);
                    print(widget.consultations[index].service.consultations);
                  },
                ),
              );
            }));
  }
}
