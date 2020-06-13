import 'package:flutter/material.dart';

typedef AppointmentCardOnTap = Function();
typedef AppointmentMoreOnTap = Function();

class AppointmentCard extends StatelessWidget {
  final AppointmentCardOnTap appointmentListCardOnTap;
  final AppointmentMoreOnTap appointmentMoreOnTap;

  const AppointmentCard(
      {Key key,
      @required this.appointmentListCardOnTap,
      @required this.appointmentMoreOnTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(15),
        child: ListTile(
          onTap: appointmentListCardOnTap,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              'assets/images/lisa.jpeg',
              height: 80,
            ),
          ),
          title: Text(
            'Tooth check',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text('09 Jan 2020, sam-10am'),
          trailing: IconButton(
              icon: Icon(Icons.more_vert), onPressed: appointmentMoreOnTap),
        ));
  }
}
