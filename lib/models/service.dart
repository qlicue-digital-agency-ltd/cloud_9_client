import 'package:cloud_9_client/models/consultation.dart';
import 'package:cloud_9_client/models/procedure.dart';
import 'package:flutter/material.dart';

import 'image.dart';

class Service {
  final int id;
  final String title;
  final String body;
  final int categoryId;
  List<ServieImage> images;
  List<Procedure> procedures;
  List<Consultation> consultations;

  Service({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.categoryId,
    @required this.procedures,
    @required this.consultations,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'body': body,
      'category_id': categoryId,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Service.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['title'] != null),
        id = map['id'],
        title = map['title'],
        body = map['body'],
        categoryId = int.parse(map['category_id'].toString()),
        images = map['images'] != null
            ? (map['images'] as List)
                .map((i) => ServieImage.fromMap(i))
                .toList()
            : null,
        consultations = map['consultations'] != null
            ? (map['consultations'] as List)
                .map((i) => Consultation.fromMap(i))
                .toList()
            : null,
        procedures = map['procedures'] != null
            ? (map['procedures'] as List)
                .map((i) => Procedure.fromMap(i))
                .toList()
            : null;
}
