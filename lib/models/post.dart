import 'package:flutter/material.dart';

class Post {
  final int id;
  final String image;
  final String title;
  final String body;

  Post({
    @required this.id,
    @required this.image,
    @required this.title,
    @required this.body,
  });

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
        image = map['image'];
}
