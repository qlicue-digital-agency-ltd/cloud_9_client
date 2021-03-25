import 'package:cloud_9_client/models/service.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

typedef ServiceCardOnTap = Function();

class ServiceCard extends StatelessWidget {
  final ServiceCardOnTap onTapMore;
  final ServiceCardOnTap onTapCalender;
  final Service service;

  const ServiceCard(
      {Key key,
      @required this.onTapCalender,
      @required this.onTapMore,
      @required this.service})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Stack(
      children: <Widget>[
        ClipRRect(
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: 400,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                   CachedNetworkImage(
                      imageUrl: service.images[0].url,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          Center(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(value: downloadProgress.progress),
                          )),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                     height: 200,
                     width: MediaQuery.of(context).size.width,
                     fit: BoxFit.cover,
                    ),

              // Container(
              //   height: 200,
              //   width: MediaQuery.of(context).size.width,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //         image: NetworkImage(service.images[0].url),
              //         fit: BoxFit.cover),
              //   ),
              // ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  service.title,
                  maxLines: 1,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  service.body,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  maxLines: 3,
                ),
              ),
              Spacer(),
              Row(children: [
                Spacer(),
                // IconButton(
                //   color: Colors.blue,
                //   icon: Icon(Icons.calendar_today),
                //   onPressed: onTapCalender,
                //   tooltip: 'Schedule Appointment',
                // ),
                FlatButton(
                  onPressed: onTapCalender,
                  child: const Text('Make Appointment'),
                  textColor: Colors.blue,
                ),
                FlatButton(
                  onPressed: onTapMore,
                  child: Text('More...'),
                  textColor: Colors.blue,
                )
              ])
            ]),
          ),
        ),
      ],
    ));
  }
}
