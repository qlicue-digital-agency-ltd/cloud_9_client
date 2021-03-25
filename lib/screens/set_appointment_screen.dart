import 'package:cloud_9_client/components/text-fields/date_text_field.dart';
import 'package:cloud_9_client/components/text-fields/label_text_field.dart';
import 'package:cloud_9_client/components/text-fields/mobile_number.dart';
import 'package:cloud_9_client/models/service.dart';
import 'package:cloud_9_client/provider/appointment_provider.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:cloud_9_client/provider/service_provider.dart';
import 'package:cloud_9_client/provider/utility_provider.dart';
import 'package:cloud_9_client/screens/appointment_detail_screen.dart';
import 'package:cloud_9_client/screens/appointment_screen.dart';
import 'package:cloud_9_client/screens/home_screen.dart';
import 'package:cloud_9_client/components/text-fields/rowed_text_field.dart';

import 'package:cloud_9_client/models/appointment.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetAppointmentScreen extends StatefulWidget {
  final Service service;
  final bool isProcedure;

  SetAppointmentScreen(
      {Key key, @required this.service, this.isProcedure = true})
      : super(key: key);

  @override
  _SetAppointmentScreenState createState() => _SetAppointmentScreenState();
}

class _SetAppointmentScreenState extends State<SetAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FocusNode _codeFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

  TextEditingController _consultationReasonTextEditingController = TextEditingController();
  FocusNode _consultationReasonFocusNode = FocusNode();

  TextEditingController _codeTextController = TextEditingController();
  TextEditingController _dateTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();

  String _appointmentType;
  Service _selectedService;

  List<String> appointmentTypes = ['Consultation', 'Procedure'];

  @override
  void initState() {
    _dateTextController.text = DateTime.now().toString();
    _appointmentType =
    widget.isProcedure ? appointmentTypes[1] : appointmentTypes[0];
    _selectedService = widget.service;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _appointmentProvider = Provider.of<AppointmentProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context);
    final _utilityProvider = Provider.of<UtilityProvider>(context);
    final _serviceProvider = Provider.of<ServiceProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        Text('Type'),
                        Spacer(),
                        DropdownButton(
                          value: _appointmentType,
                          onChanged: (String newValue) {
                            setState(() {
                              _appointmentType = newValue;
                            });
                          },
                          items: appointmentTypes.map<DropdownMenuItem<String>>
                            ((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        Spacer()
                      ],),
                    ),
                    // _appointmentType == appointmentTypes[1] ?

                    // _serviceProvider.availableServices.length != 0 ?
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('Service'),
                        subtitle: DropdownButton(
                          isExpanded: true,
                          value: _selectedService,
                          onChanged: (Service newValue) {
                            setState(() {
                              _selectedService = newValue;
                            });
                          },
                          items: _serviceProvider.availableServices.map<
                              DropdownMenuItem<Service>>
                            ((Service value) {
                            return DropdownMenuItem<Service>(
                              value: value,
                              child: Text(
                                value.title, overflow: TextOverflow.fade,),
                            );
                          }).toList(),
                        ),
                      ),
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
                                if (_appointmentType == appointmentTypes[1]) {
                                  _appointmentProvider
                                      .postProcedureAppointment(
                                    agentUuid: _codeTextController.text,
                                    userId: _authProvider.authenticatedUser.id,
                                    serviceId: _selectedService.id,
                                    date: _dateTextController.text,
                                    phoneNumber: _mobile,
                                  )
                                      .then((result) {
                                    if (result['success']) {
                                      _showBookingConfirmationDialog(context, result['appointment']);
                                    } else {
                                      showInSnackBar(value: 'Something went wrong, please try again!', context: context,color: Colors.red);
                                    }
                                  });
                                }
                                if (_appointmentType == appointmentTypes[0]) {
                                  _appointmentProvider
                                      .postConsultationAppointment(
                                      agentUuid: _codeTextController.text,
                                      date: _dateTextController.text,
                                      userId: _authProvider.authenticatedUser
                                          .id,
                                      phoneNumber: _mobile,
                                      consultationId: _selectedService.id).then((result)  {

                                    if(result['success']){
                                      _showBookingConfirmationDialog(context, result['appointment']);
                                    }
                                    else{
                                      showInSnackBar(value: 'Something went wrong, please try again!', context: context,color: Colors.red);
                                    }
                                  });
                                }
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

  Future<void> _showBookingConfirmationDialog(BuildContext context, Appointment appointment) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Appointment Booked'),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RowedTextField(
                          title: 'Appointment Type',
                          subtitle: appointment.appointmentableType.split('\\')[1]
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RowedTextField(
                            title: 'Date',
                            subtitle: appointment.date
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RowedTextField(
                            title: 'Service',
                            subtitle: appointment.appointmentable.service.title
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RowedTextField(
                            title: 'Status',
                            subtitle: 'Booked'
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FlatButton(
                              color: Colors.red,
                              textColor: Colors.white,
                              child: Text('Done'),
                              onPressed: () {
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomeScreen()));
                              },
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: FlatButton(
                              textColor: Colors.white,
                              color: Theme.of(context).primaryColor,
                              child: Text('Complete Payment'),
                              onPressed: () {
                                Navigator.push(
                                    context,MaterialPageRoute(
                                    builder: (context)=>AppointmentDetailScreen(appointment: appointment )));
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }),
        );
      },
    );
  }

  void showInSnackBar({@required String value,@required BuildContext context,Color color}) {
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
      backgroundColor: color == null ? Colors.green : color,
      duration: Duration(seconds: 3),
    ));
  }
}
