import 'package:cloud_9_client/components/card/post_card.dart';
import 'package:cloud_9_client/components/tiles/no_item_tile.dart';
import 'package:cloud_9_client/provider/post_provider.dart';

import 'package:cloud_9_client/screens/background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EducationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _postProvider = Provider.of<PostProvider>(context);
    Future<void> _getData() async {
      _postProvider.fetchPosts();
    }

    return Background(
        screen: SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
            SliverAppBar(
              elevation: 0,
              expandedHeight: 120.0,
              backgroundColor: Colors.transparent,
            
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                title: Text(
                  'Education',
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
          ],
          body: _postProvider.isFetchingPostData
              ? Center(child: CircularProgressIndicator())
              : _postProvider.availablePosts.isEmpty
                  ? Center(
                      child: NoItemTile(
                          icon: 'assets/icons/agent.png',
                          title: 'No Posts',
                          subtitle:
                              'We have no posts of yet'),
                    )
                  : RefreshIndicator(
                      child: ListView.builder(
                          itemCount: _postProvider.availablePosts.length,
                          itemBuilder: (context, index) {
                            return PostCard(
                              onLike: () {},
                              onShare: () {},
                              post: _postProvider.availablePosts[index],
                            );
                          }),
                      onRefresh: _getData),
        ),
      ),
    ));
  }
}
