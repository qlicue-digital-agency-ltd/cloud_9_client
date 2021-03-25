import 'package:flutter/material.dart';
import 'package:cloud_9_client/components/text-fields/labelledText.dart';

class MealCard extends StatelessWidget {
  final String carbohydrates;
  final String proteins;
  final String vegetables;
  final String fruits;
  final String other;
  final String meal;

  const MealCard(
      {Key key,
      @required this.carbohydrates,
      @required this.proteins,
      @required this.vegetables,
      @required this.fruits,
      @required this.other,
      @required this.meal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Material(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  meal,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            LabelledText(
              title: 'Carbohydrates',
              description: carbohydrates,
            ),
            LabelledText(
              title: 'Proteins',
              description: proteins,
            ),
            LabelledText(
              title: 'Vegetables',
              description: vegetables,
            ),
            LabelledText(
              title: 'Fruits',
              description: fruits,
            ),
            LabelledText(
              title: 'Other',
              description: other,
            ),
          ],
        ),
      ),
    );
  }
}
