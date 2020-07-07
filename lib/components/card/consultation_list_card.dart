import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/models/consultation.dart';
import 'package:flutter/material.dart';

typedef ConsultationListCardOnTap = Function();

class ConsultationListCard extends StatelessWidget {
  final ConsultationListCardOnTap onBookTap;
  final ConsultationListCardOnTap onViewTap;
  final Consultation consultation;

  const ConsultationListCard(
      {Key key,
      @required this.onBookTap,
      @required this.onViewTap,
      @required this.consultation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        clipBehavior: Clip.antiAlias,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(consultation.service.images.isNotEmpty
                      ? api +
                          'service/image/' +
                          consultation.service.images[0].id.toString()
                      : 'https://lorempixel.com/640/480/?19411'),
                  fit: BoxFit.fill,
                )),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    consultation.service.title,
                    maxLines: 1,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    consultation.service.body,
                    maxLines: 1,
                  ),
                  Row(children: <Widget>[
                    Text('From ' +
                        consultation.startTime +
                        '\t To ' +
                        consultation.endTime)
                  ])
                ],
              ),
            ),
          ),
        
          InkWell(
            onTap: onBookTap,
            child: Container(
              width: 60,
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Icon(
                    Icons.calendar_today,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 3),
                  Text('Book'),
                ],
              ),
            ),
          )
        ]));
  }
}
