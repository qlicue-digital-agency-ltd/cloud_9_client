import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;

  Product(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.price,
      @required this.image});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'description': description,
      'image': image,
      'price': price
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
        price = double.parse(map['price'].toString()),
        image = map['image'];
}
