import 'package:flutter/material.dart';

class LabelledText extends StatelessWidget {
  final String title;
  final String description;

  const LabelledText(
      {Key key, @required this.title, @required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      // margin: EdgeInsets.symmetric(vertical: 4),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(5),
      //   border: Border.all(color: Colors.grey, width: 0.5),
      // ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(
          title,
          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
        ),
        // Divider(),
        Container(
          color: Color(0xFFe8efeb),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(description),
          ),
        )
      ]),
    );
  }
}
