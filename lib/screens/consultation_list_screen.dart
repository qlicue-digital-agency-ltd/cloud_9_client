import 'package:cloud_9_client/components/card/consultation_list_card.dart';
import 'package:cloud_9_client/models/consultation.dart';

import 'package:cloud_9_client/screens/service_detail_screen.dart';
import 'package:cloud_9_client/screens/set_cosultation_appointment.dart';

import 'package:flutter/material.dart';

class ConsultationListScreen extends StatefulWidget {
  final List<Consultation> consultations;

  ConsultationListScreen({Key key, @required this.consultations})
      : super(key: key);

  @override
  _ConsultationListScreenState createState() => _ConsultationListScreenState();
}

class _ConsultationListScreenState extends State<ConsultationListScreen> {
  @override
  Widget build(BuildContext context) {
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SetConsultationAppointmentScreen(
                                consultation: widget.consultations[index])));
                  },
                ),
              );
            }));
  }
}
