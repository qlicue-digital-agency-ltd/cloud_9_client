import 'package:flutter/material.dart';

class Profile {
  int id;
  String uuid;
  String registrationNumber;
  String fullname;
  String avatar;
  String phone;
  String gender;
  String location;
  int userId;

  Profile(
      {@required this.id,
      @required this.uuid,
      @required this.userId,
      @required this.registrationNumber,
      @required this.fullname,
      @required this.avatar,
      @required this.phone,
      @required this.gender,
      @required this.location});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'date': uuid,
      'user_id': userId,
      'registration_number': registrationNumber,
      'fullname': fullname,
      'avatar': avatar,
      'phone': phone,
      'location': location,
      'gender': gender,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Profile.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['user_id'] != null),
        id = map['id'],
        uuid = map['uuid'],
        userId = map['user_id'],
        registrationNumber = map['registration_number'],
        fullname = map['fullname'],
        avatar = map['avatar'],
        phone = map['phone'].toString(),
        gender = map['gender'],
        location = map['location'].toString();
}
