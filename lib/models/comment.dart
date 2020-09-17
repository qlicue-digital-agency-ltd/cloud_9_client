import 'package:cloud_9_client/models/user.dart';
import 'package:flutter/material.dart';


class Comment {
  final int id;
  final String body;
  final int userId;
  final int postId;
  String time;
  User user;

  Comment({
    @required this.id,
    @required this.body,
    @required this.userId,
    @required this.postId,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'body': body,
      'user_id': userId,
      'post_id': postId,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Comment.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['user_id'] != null),
        id = map['id'],
        body = map['body'],
        userId = map['user_id'],
        postId = map['post_id'],
        time = map['updated_at'].toString(),
        user = User.fromMap((map['user']));
}
