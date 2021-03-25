import 'package:flutter/material.dart';

class Meal {
  final String type;
  final String carbohydrates;
  final String proteins;
  final String vegetables;
  final String fruits;
  final String others;
  final DateTime date;
  final TimeOfDay time;

  Meal(
      { @required this.date,
        @required this.time,
        @required this.type,
      this.carbohydrates,
      this.proteins,
      this.vegetables,
      this.fruits,
      this.others
     });

  Map<String, String> toJSON(){
    return {
      "date" :'',
      "time" : '',
      "type" : this.type,
      "carbohydrates" : this.carbohydrates,
      "proteins" : this.proteins,
      "vegetables" : this.vegetables,
      "fruits" : this.fruits,
      "others" : this.others,

    };
  }
}
