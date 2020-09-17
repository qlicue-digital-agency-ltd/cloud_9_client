import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/models/comment.dart';
import 'package:cloud_9_client/models/post.dart';
import 'package:cloud_9_client/models/user.dart';
import 'package:cloud_9_client/shared/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostProvider with ChangeNotifier {
  //variable declaration
  bool _isFetchingPostData = false;
  List<Post> _availablePosts = [];
  bool _isSubmitingCommentData = false;
  SharedPref _sharedPref = SharedPref();
  PostProvider() {
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    await _sharedPref.readSingleString('token').then((token) {
      if (token != null) {
        _sharedPref.read('user').then((value) {
          final _authenticatedUser = User.fromMap(value);
          fetchPosts(_authenticatedUser.id);
        });
      }
    });
  }

//getters
  bool get isFetchingPostData => _isFetchingPostData;
  List<Post> get availablePosts => _availablePosts;
  bool get isSubmitingCommentData => _isSubmitingCommentData;

  Future<bool> fetchPosts(userId) async {
    bool hasError = true;
    _isFetchingPostData = true;
    notifyListeners();

    final List<Post> _fetchedPosts = [];
    final Map<String, dynamic> _data = {
      'user_id': userId,
    };
    try {
      final http.Response response = await http.post(
        api + "posts",
        body: json.encode(_data),
        headers: {'Content-Type': 'application/json'},
      );

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

  //http requests
  Future<bool> createComment(
      {@required String body,
      @required int postId,
      @required int userId}) async {
    bool hasError = true;
    _isSubmitingCommentData = true;
    notifyListeners();
    final Map<String, dynamic> _data = {
      'body': body,
      'post_id': postId,
      'user_id': userId,
    };

    try {
      final http.Response response = await http.post(
        api + "comment",
        body: json.encode(_data),
        headers: {'Content-Type': 'application/json'},
      );

      final Map<String, dynamic> data = json.decode(response.body);
      print(data);

      if (response.statusCode == 200) {
        hasError = false;
        _availablePosts
            .where((post) => post.id == postId)
            .first
            .comments
            .add(Comment.fromMap(data['comment']));
      }
    } catch (error) {
      print(error);
      hasError = true;
    }
    _isSubmitingCommentData = false;

    notifyListeners();

    return hasError;
  }
}
