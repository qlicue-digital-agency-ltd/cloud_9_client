import 'package:meta/meta.dart';

class User {
  final int id;
  final String email;
  final String token;

  User({
    @required this.id,
    @required this.token,
    @required this.email,
  });

  User.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['token'] != null),
        assert(map['email'] != null),
        id = map['id'],
        token = map['token'].toString(),
        email = map['email'].toString();
}
