import 'package:cloud_9_client/models/doctor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef DoctorConsultationCardOnTap = Function();

class DoctorConsultationCard extends StatelessWidget {
  final DoctorConsultationCardOnTap onTap;

  final Doctor doctor;

  const DoctorConsultationCard({
    Key key,
    @required this.doctor,
    @required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Column(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: Colors.blue,
          ),
          height: 100,
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 8.0),
                  child: Text(
                    'For Doctor Consultation',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 10),
                Icon(
                  FontAwesomeIcons.userNurse,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Doctor',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ]),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20),
          child: Row(children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(doctor.profile.avatar),
              radius: 30,
            ),
            SizedBox(width: 20),
            Text(doctor.profile.fullname,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
          ]),
        ),
        SizedBox(
          height: 20,
        ),
        Divider(),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton.icon(
                  onPressed: onTap,
                  color: Colors.blue,
                  textColor: Colors.white,
                  icon: Icon(Icons.calendar_today),
                  label: Text('Book Now'))
            ])
      ]),
    );
  }
}
