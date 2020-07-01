import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final String image;

  Product(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.image});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'description': description,
      'image': image
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Product.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        id = map['id'],
        name = map['name'],
        description = map['description'],
        image = map['image'];
}
