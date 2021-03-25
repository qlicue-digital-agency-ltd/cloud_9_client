import 'package:cloud_9_client/models/appointment.dart';
import 'package:flutter/material.dart';

typedef AppointmentCardOnTap = Function();
typedef AppointmentMoreOnTap = Function();

class AppointmentCard extends StatelessWidget {
  final AppointmentCardOnTap appointmentListCardOnTap;
  final AppointmentMoreOnTap appointmentMoreOnTap;
  final Appointment appointment;

  const AppointmentCard(
      {Key key,
      @required this.appointmentListCardOnTap,
      @required this.appointmentMoreOnTap,
      @required this.appointment})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(15),
          child: ListTile(
            onTap: appointmentListCardOnTap,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                appointment.appointmentableType == 'App\\Procedure'
                    ? 'assets/icons/procedure.png'
                    : 'assets/icons/consultation.png',
                height: 45,
              ),
            ),
            title: Text(
              appointment.appointmentable.service.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Date ' +
                    appointment.date +
                    '\nstarting at ' +
                    appointment.appointmentable.startTime),
                Row(children: [Padding(
                  padding: const EdgeInsets.only(right:8.0),
                  child: Icon(Icons.monetization_on_outlined,color: Colors.blue,),
                ),
                  appointment.appointmentable.orders.length == 0 ?  Text('Unpaid',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)) :Text( appointment.appointmentable.orders[0].paymentStatus == 'null' ?  'Unpaid' : appointment.appointmentable.orders[0].paymentStatus,style: TextStyle(color: appointment.appointmentable.orders[0].paymentStatus == 'null' ? Colors.red : Colors.green,fontWeight: FontWeight.bold))
                ],),

              ],
            ),
            trailing: IconButton(
                icon: Icon(Icons.more_vert), onPressed: appointmentMoreOnTap),
          )),
    );
  }
}
