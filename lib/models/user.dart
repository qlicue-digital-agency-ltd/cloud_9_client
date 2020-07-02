import 'package:cloud_9_client/models/profile.dart';
import 'package:meta/meta.dart';

class User {
  final int id;
  final String email;
  final String token;
  final Profile profile;

  User({
    @required this.id,
    @required this.token,
    @required this.email,
    @required this.profile,
  });

  User.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['email'] != null),
        id = map['id'],
        token = map['token'].toString(),
        email = map['email'].toString(),
        profile = Profile.fromMap(map['profile']);
}
