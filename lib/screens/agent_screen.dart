import 'package:cloud_9_client/components/card/agent_list_card.dart';
import 'package:cloud_9_client/components/card/consultation_card.dart';
import 'package:cloud_9_client/models/agent.dart';
import 'package:cloud_9_client/models/staff.dart';
import 'package:cloud_9_client/screens/background.dart';
import 'package:flutter/material.dart';

class AgentScreen extends StatefulWidget {
  @override
  _AgentScreenState createState() => _AgentScreenState();
}

class _AgentScreenState extends State<AgentScreen> {
  bool _hasAgent = false;

  _addAgent() {
    setState(() {
      _hasAgent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Background(
        screen: SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0,
              expandedHeight: 120.0,
              backgroundColor: Colors.transparent,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                title: Text(
                  'Agent',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(height: 50),
              _hasAgent
                  ? Container()
                  : Material(
                      color: Colors.white,
                      elevation: 2,
                      borderRadius: BorderRadius.circular(20),
                      child: ListTile(
                        leading: Icon(Icons.search),
                        title: Text('Search.....'),
                      ),
                    ),
            ])),
            _hasAgent
                ? SliverList(
                    delegate: SliverChildListDelegate([
                    ConsultationCard(
                      onTapCall: () {},
                      onTapEmail: () {},
                      onTapMail: () {},
                      staff: staffList[3],
                      subtitle: 'My Agent',
                    )
                  ]))
                : SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: AgentListCard(
                          agentListMoreOnTap: () {
                            _addAgent();
                          },
                          agent: agentList[index],
                        ),
                      );
                    }, childCount: agentList.length),
                  ),
          ],
        ),
      ),
    ));
  }
}
