import 'package:cloud_9_client/components/card/consultation_card.dart';
import 'package:cloud_9_client/models/staff.dart';
import 'package:cloud_9_client/screens/background.dart';
import 'package:flutter/material.dart';

class ConsultationScreen extends StatelessWidget {
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
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.clear_all,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {},
                )
              ],
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                title: Text(
                  'Consultation',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                ConsultationCard(
                  staff: staffList[0],
                  subtitle: 'For Doctor Consultation',
                  onTapMail: () {},
                  onTapCall: () {},
                  onTapEmail: () {},
                ),
                SizedBox(
                  height: 20,
                ),
                ConsultationCard(
                  staff: staffList[1],
                  subtitle: 'For Agent Consultation',
                  onTapMail: () {},
                  onTapCall: () {},
                  onTapEmail: () {},
                ),
                SizedBox(
                  height: 20,
                ),
                ConsultationCard(
                  staff: staffList[2],
                  subtitle: 'For Hospital Consultation',
                  onTapMail: () {},
                  onTapCall: () {},
                  onTapEmail: () {},
                )
              ]),
            )
          ],
        ),
      ),
    ));
  }
}
