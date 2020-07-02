import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/models/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostProvider with ChangeNotifier {
  //variable declaration
  bool _isFetchingPostData = false;
  List<Post> _availablePosts = [];

  PostProvider() {
    fetchPosts(clientId: 2);
  }

//getters
  bool get isFetchingPostData => _isFetchingPostData;
  List<Post> get availablePosts => _availablePosts;

  Future<bool> fetchPosts({@required int clientId}) async {
    bool hasError = true;
    _isFetchingPostData = true;
    notifyListeners();

    final List<Post> _fetchedPosts = [];
    try {
      final http.Response response =
          await http.get(api + "posts");

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        data['posts'].forEach((postData) {
          final post = Post.fromMap(postData);
          _fetchedPosts.add(post);
        });
        hasError = false;
      }
    } catch (error) {
      print(error);
      hasError = true;
    }

    _availablePosts = _fetchedPosts;
    _isFetchingPostData = false;
    print(_availablePosts.length);
    notifyListeners();

    return hasError;
  }
}
