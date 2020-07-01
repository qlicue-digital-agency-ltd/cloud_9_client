import 'package:cloud_9_client/models/consultation.dart';
import 'package:cloud_9_client/models/procedure.dart';
import 'package:cloud_9_client/models/service.dart';
import 'package:flutter/material.dart';

class Category {
  final int id;
  final String name;
  final List<Service> services;
  final List<Procedure> procedures;
  final List<Consultation> consultations;

  bool isSelected;

  Category(
      {@required this.id,
      @required this.name,
      @required this.services,
      @required this.procedures,
      @required this.consultations,
      this.isSelected = false});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'name': name};
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    return map;
  }

  Category.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['name'] != null),
        id = map['id'],
        name = map['name'],
        isSelected = map['id'] == 1 ? true : false,
        services = map['services'] != null
            ? (map['services'] as List).map((i) => Service.fromMap(i)).toList()
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
