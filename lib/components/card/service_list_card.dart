import 'package:cloud_9_client/models/service.dart';
import 'package:flutter/material.dart';

typedef ServiceListCardOnTap = Function();

class ServiceListCard extends StatelessWidget {
  final ServiceListCardOnTap onBookTap;
  final ServiceListCardOnTap onViewTap;
  final Service service;

  const ServiceListCard(
      {Key key,
      @required this.onBookTap,
      @required this.onViewTap,
      @required this.service})
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
                  image: AssetImage(
                    'assets/images/0.jpg',
                 
                  ),
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
                    service.title,
                    maxLines: 1,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    service.body,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: onViewTap,
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
                    Icons.note,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 3),
                  Text('View'),
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
