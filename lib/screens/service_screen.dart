import 'package:cloud_9_client/components/card/category_card.dart';
import 'package:cloud_9_client/components/card/service_card.dart';
import 'package:cloud_9_client/models/category.dart';
import 'package:cloud_9_client/models/service.dart';
import 'package:cloud_9_client/screens/background.dart';
import 'package:cloud_9_client/screens/calender_screen.dart';
import 'package:cloud_9_client/screens/service_detail_screen.dart';
import 'package:flutter/material.dart';

class ServiceScreen extends StatelessWidget {
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
                  'Services',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ])),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                      child: CategoryCard(
                        onTap: () {},
                        category: serviceCategories[index],
                      ),
                    );
                  },
                  itemCount: serviceCategories.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ServiceCard(
                    onTapCalender: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CalenderScreen(),
                          ));
                    },
                    service: serviceList[index],
                    onTapMore: () {
                      print('moreeeee');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ServiceDetailScreen(
                              service: serviceList[index],
                            ),
                          ));
                    },
                  ),
                );
              }, childCount: serviceList.length),
            )
          ],
        ),
      ),
    ));
  }
}
