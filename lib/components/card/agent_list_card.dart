import 'package:flutter/material.dart';

typedef AgentListCardOnTap = Function();
typedef AgentListMoreOnTap = Function();

class AgentListCard extends StatelessWidget {

  final AgentListMoreOnTap agentListMoreOnTap;

  const AgentListCard(
      {Key key,
     
      @required this.agentListMoreOnTap})
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
              'assets/images/lisa.jpeg',
              height: 80,
            ),
          ),
          title: Text(
            'C91092UI',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text('Mr Alison John'),
          trailing: FlatButton(
            onPressed: agentListMoreOnTap,
            child: Text('Add'),
          ),
        ));
  }
}
