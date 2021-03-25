import 'package:cloud_9_client/models/physical_activity.dart';
import 'package:flutter/material.dart';
import 'package:cloud_9_client/models/meal.dart';

class Diary {
  final int id;
  final DateTime from;
  final DateTime to;
  final double weight;
  final double height;
  final double bmi;
  final double waist;
  final double bodyComposition;
  final double bloodPressure;
   List<Meal> meals = [];
   List<PhysicalActivity> activities = [];

  Diary(
      {@required this.id,
      @required this.from,
      @required this.to,
      @required this.weight,
      @required this.height,
      @required this.bmi,
      @required this.waist,
      @required this.bodyComposition,
      @required this.bloodPressure,
      this.meals,
      this.activities});
}
