import 'package:cloud_9_client/models/service.dart';
import 'package:cloud_9_client/screens/background.dart';
import 'package:cloud_9_client/screens/calender_screen.dart';
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
        padding: EdgeInsets.all(20),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0,
              expandedHeight: 120.0,
              backgroundColor: Colors.transparent,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CalenderScreen()));
                  },
                )
              ],
              pinned: true,
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Text(
                service.title,
                maxLines: 1,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
              ),
              SizedBox(height: 50),
              service.images.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image:
                                          NetworkImage(service.images[0].url),
                                      fit: BoxFit.cover)),
                              height: 150,
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
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              service.images[0].url),
                                          fit: BoxFit.cover)),
                                  height: 150,
                                ),
                                Positioned(
                                  top: 55,
                                  left: 40,
                                  child: Text(
                                    '+' + service.images.length.toString(),
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
            ])),
            SliverList(
                delegate: SliverChildListDelegate([
              Text(
                service.body,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )
            ]))
          ],
        ),
      ),
    ));
  }
}
