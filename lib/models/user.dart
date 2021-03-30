import 'package:cloud_9_client/models/profile.dart';
import 'package:meta/meta.dart';

class User {
  int id;
  final String email;
  String token;
  String fcmToken;
  Profile profile;

  User({
    this.id,
    this.token,
    @required this.email,
    this.fcmToken,
    this.profile,
    uid,
  });

  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        token = map['token'].toString(),
        email = map['email'].toString(),
        fcmToken = map['fcm_token'],
        profile = Profile.fromMap(map['profile']);
}
