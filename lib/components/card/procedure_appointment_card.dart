import 'package:cloud_9_client/models/procedure.dart';
import 'package:flutter/material.dart';

typedef ProcedureAppointmentCardOnTap = Function( );

class ProcedureAppointmentCard extends StatelessWidget {
  final ProcedureAppointmentCardOnTap onTapConfirm;
  final String icon;
  final Procedure procedure;
  final String name;

  const ProcedureAppointmentCard({
    Key key,
    @required this.onTapConfirm,
    @required this.icon,
    @required this.procedure,
    @required this.name,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
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
            SizedBox(
              height: 50,
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 10),
                Image.asset(icon, height: 50),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    'Appointment for ' + name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                )
              ],
            ),
          
          
          ]),
        ),
     
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: Form(child: Column(children: [
            TextFormField(),
          ],),)
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
                onPressed: onTapConfirm,
                child: Text(
                  '\t\t\t\Book Now\t\t\t\t',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ]),
        SizedBox(height: 20),
      ]),
    );
  }
}
