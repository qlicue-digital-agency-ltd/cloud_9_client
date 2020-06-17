import 'package:cloud_9_client/models/agent.dart';
import 'package:flutter/material.dart';

typedef AgentListCardOnTap = Function();
typedef AgentListMoreOnTap = Function();

class AgentListCard extends StatelessWidget {
  final AgentListMoreOnTap agentListMoreOnTap;
  final Agent agent;

  const AgentListCard(
      {Key key, @required this.agentListMoreOnTap, @required this.agent})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(15),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              agent.avatar,
              height: 80,
            ),
          ),
          title: Text(
            agent.uuid,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(agent.fullname),
          trailing: FlatButton(
            onPressed: agentListMoreOnTap,
            child: Text('Add'),
          ),
        ));
  }
}
