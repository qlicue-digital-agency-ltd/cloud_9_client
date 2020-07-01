import 'package:flutter/material.dart';

class ServieImage {
  final int id;
  final String url;
  final int serviceId;

  ServieImage({@required this.id, @required this.url, @required this.serviceId});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'service_id': serviceId,
      'url': url
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  ServieImage.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['service_id'] != null),
        id = map['id'],
        url = map['url'],
        serviceId = map['service_id']
       ;
}
