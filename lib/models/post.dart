import 'package:cloud_9_client/models/comment.dart';
import 'package:cloud_9_client/models/user.dart';
import 'package:flutter/material.dart';

class Post {
  final int id;
  final String image;
  final String title;
  final String body;

  final int likeCount;

  final bool likedByMe;
  User user;
  final int userId;
  List<Comment> comments = [];

  Post(
      {@required this.id,
      @required this.image,
      @required this.title,
      @required this.body,
      @required this.userId,
      @required this.likeCount,
      @required this.likedByMe});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'title': title, 'body': body, 'image': image};
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Post.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        id = map['id'],
        title = map['title'],
        body = map['body'],
        image = map['image'],
        likeCount = map['likes_count'],
        likedByMe = map['liked_by_me'],
        userId = map['user_id'],
        comments = map['comments'] != null
            ? (map['comments'] as List).map((i) => Comment.fromMap(i)).toList()
            : null,
        user = User.fromMap(map['user']);
}
