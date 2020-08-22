import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/models/service.dart';
import 'package:cloud_9_client/screens/background.dart';
import 'package:flutter/material.dart';

class ServiceDetailScreen extends StatelessWidget {
  final Service service;

  const ServiceDetailScreen({Key key, @required this.service})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Background(
        screen: SafeArea(
      child: Container(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
             actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => SetAppointmentScreen()));
                  },
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              service.title,
              maxLines: 2,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
            ),
            SizedBox(height: 50),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      service.images.isNotEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: NetworkImage(api +
                                                  'service/image/' +
                                                  service.images[0].id
                                                      .toString()),
                                              fit: BoxFit.cover)),
                                      height: 200,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(api +
                                                      'service/image/' +
                                                      service.images[0].id
                                                          .toString()),
                                                  fit: BoxFit.cover)),
                                          height: 200,
                                        ),
                                        Positioned(
                                          top: 80,
                                          left: 40,
                                          child: Text(
                                            '+' +
                                                service.images.length
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            )
                          : Container(),
                      SizedBox(height: 10),
                      Text(
                        'DESCRIPTION',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        service.body,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ]),
              ),
            )
          ]))),
    ));
  }
}
