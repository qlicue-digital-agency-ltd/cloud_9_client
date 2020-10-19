import 'package:cloud_9_client/components/card/post_card.dart';
import 'package:cloud_9_client/components/tiles/no_item_tile.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:cloud_9_client/provider/post_provider.dart';

import 'package:cloud_9_client/screens/background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EducationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _postProvider = Provider.of<PostProvider>(context);
    final _authUser = Provider.of<AuthProvider>(context).authenticatedUser;
    Future<void> _getData() async {
      _postProvider.fetchPosts(_authUser.id);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Education',
          style: TextStyle(color: Colors.white),
        ),
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                color: Colors.white,
                elevation: 2,
                borderRadius: BorderRadius.circular(20),
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: Text('Search.....'),
                ),
              ),
            ),
            preferredSize: Size(double.infinity, 50)),
      ),
      body: _postProvider.isFetchingPostData
          ? Center(child: CircularProgressIndicator())
          : _postProvider.availablePosts.isEmpty
              ? Center(
                  child: NoItemTile(
                      icon: 'assets/icons/agent.png',
                      title: 'No Posts',
                      subtitle: 'We have no posts of yet'),
                )
              : RefreshIndicator(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: _postProvider.availablePosts.length,
                        itemBuilder: (context, index) {
                          return PostCard(
                            onLike: () {},
                            onShare: () {},
                            post: _postProvider.availablePosts[index],
                          );
                        }),
                  ),
                  onRefresh: _getData),
    );
  }
}
