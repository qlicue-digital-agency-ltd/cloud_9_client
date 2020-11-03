import 'package:cloud_9_client/components/text-fields/date_text_field.dart';
import 'package:cloud_9_client/components/text-fields/label_text_field.dart';
import 'package:cloud_9_client/components/text-fields/mobile_number.dart';
import 'package:cloud_9_client/models/consultation.dart';
import 'package:cloud_9_client/provider/appointment_provider.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:cloud_9_client/provider/utility_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetConsultationAppointmentScreen extends StatefulWidget {
  final Consultation consultation;

  SetConsultationAppointmentScreen({Key key, @required this.consultation})
      : super(key: key);

  @override
  _SetConsultationAppointmentScreenState createState() =>
      _SetConsultationAppointmentScreenState();
}

class _SetConsultationAppointmentScreenState
    extends State<SetConsultationAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _codeFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

  TextEditingController _codeTextController = TextEditingController();
  TextEditingController _dateTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();

  @override
  void initState() {
    _dateTextController.text = DateTime.now().toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _appointmentProvider = Provider.of<AppointmentProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context);
    final _utilityProvider = Provider.of<UtilityProvider>(context);
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Set Appointments',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
        )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 10),
                        Image.asset('assets/icons/consultation.png',
                            height: 50),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            'Appointment for ' +
                                widget.consultation.service.title +
                                ' Consultation',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Enter Details ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    LabelTextfield(
                      focusNode: _codeFocusNode,
                      hitText: "Eg. AG0001A",
                      keyboardType: TextInputType.text,
                      labelText: "Agent Code",
                      maxLines: 1,
                      message: null,
                      textEditingController: _codeTextController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFieldDatePicker(
                      labelText: "Date",
                      prefixIcon: Icon(Icons.date_range),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      lastDate: DateTime.now().add(Duration(days: 366)),
                      firstDate: DateTime.now(),
                      initialDate: DateTime.now().add(Duration(days: 1)),
                      onDateChanged: (selectedDate) {
                        print(selectedDate);
                        // Do something with the selected date
                        _dateTextController.text = selectedDate.toString();
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MobileTextfield(
                      focusNode: _phoneFocusNode,
                      hitText: '715 123 456',
                      keyboardType: TextInputType.phone,
                      labelText: 'Phone Number',
                      maxLines: 1,
                      message: 'Phone number required',
                      onCodeChange: (country) {
                        print(country);
                        _utilityProvider.setSelectedCountry = country;
                      },
                      selectedCountry: _utilityProvider.selectedCountry,
                      textEditingController: _phoneTextController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.blue,
                            textColor: Colors.white,
                            onPressed: () {
                              final _mobile =
                                  _utilityProvider.selectedCountry.dialingCode +
                                      _phoneTextController.text
                                          .replaceAll('(', '')
                                          .replaceAll(')', '')
                                          .replaceAll('-', '')
                                          .replaceAll(' ', '');
                              if (_formKey.currentState.validate()) {
                                _appointmentProvider
                                    .postConsultationAppointment(
                                  agentUuid: _codeTextController.text,
                                  userId: _authProvider.authenticatedUser.id,
                                  consultationId: widget.consultation.id,
                                  date: _dateTextController.text,
                                  phoneNumber: _mobile,
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
                            child: Text(
                              '\t\t\t\Book Now\t\t\t\t',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ]),
                    SizedBox(height: 20),
                  ]),
                ),
              ),
            ),
          ),
        ));
  }
}
