import 'package:cloud_9_client/components/card/agent_list_card.dart';
import 'package:cloud_9_client/screens/background.dart';
import 'package:flutter/material.dart';

class AgentScreen extends StatelessWidget {
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
              Material(
                color: Colors.white,
                elevation: 2,
                borderRadius: BorderRadius.circular(20),
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: Text('Search.....'),
                ),
              ),
            ])),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: AgentListCard(
                    agentListMoreOnTap: () {},
                  ),
                );
              }, childCount: 10),
            )
          ],
        ),
      ),
    ));
  }
}
