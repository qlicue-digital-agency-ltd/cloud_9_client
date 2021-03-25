import 'package:flutter/material.dart';
import 'package:cloud_9_client/components/text-fields/labelledText.dart';

import 'package:cloud_9_client/models/physical_activity.dart';

class ActivityCard extends StatelessWidget {

  final PhysicalActivity activity;

  const ActivityCard(
      {Key key,
      @required this.activity,
     })
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
          children: [
            LabelledText(
              title: 'Activity',
              description: activity.activity,
            ),
            Divider(),
            Row(
              children: [Text(activity.time.format(context)), Spacer(), Text(activity.duration)],
            )
          ],
        ),
      ),
    );
  }
}
