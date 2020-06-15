import 'package:flutter/material.dart';

class Category {
  final int id;
  final String name;
  final String image;
  bool isSelected;

  Category(
      {@required this.id,
      @required this.name,
      @required this.image,
      this.isSelected = false});
}

List<Category> serviceCategories = <Category>[
  Category(
      id: 1, name: 'ALL', image: 'assets/images/lisa.jpeg', isSelected: true),
  Category(id: 2, name: 'Acne\nTreatments', image: 'assets/images/lisa.jpeg'),
  Category(id: 3, name: 'Hair', image: 'assets/images/lisa.jpeg'),
  Category(id: 4, name: 'Rejuvenation', image: 'assets/images/lisa.jpeg',isSelected: true),
  Category(id: 5, name: 'Dermatology', image: 'assets/images/lisa.jpeg'),
  Category(id: 6, name: 'Marks\nRemoval', image: 'assets/images/lisa.jpeg'),
];
