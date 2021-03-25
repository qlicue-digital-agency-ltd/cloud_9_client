import 'package:flutter/material.dart';

class PhysicalActivity {
  final String activity;
  final DateTime date;
  final TimeOfDay time;
  final String duration;

  PhysicalActivity(
      {@required this.activity,
      @required this.date,
      @required this.time,
      @required this.duration});
}
