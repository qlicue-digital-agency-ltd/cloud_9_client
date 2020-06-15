import 'package:flutter/material.dart';

class Staff {
  final int id;
  final String title;
  final String firstname;
  final String lastname;
  final String avatar;
  final String phone;
  final String email;

  Staff({
    @required this.id,
    @required this.title,
    @required this.firstname,
    @required this.lastname,
    @required this.avatar,
    @required this.phone,
    @required this.email,
  });
}

List<Staff> staffList = <Staff>[
  Staff(
      id: 1,
      title: 'Lead Doctor',
      firstname: 'Edward',
      lastname: 'Paul',
      avatar: 'assets/images/rob.png',
      email: 'doctor@cloud9.com',
      phone: '0715123456'),
  Staff(
      id: 1,
      title: 'Super Agent',
      firstname: 'Christian',
      lastname: 'Makabwe',
      avatar: 'assets/images/lisa.jpeg',
      email: 'agent@cloud9.com',
      phone: '0715123456'),
  Staff(
      id: 1,
      title: 'Hospital Attendant',
      firstname: 'Boris',
      lastname: 'Mukiza',
      avatar: 'assets/images/matty.jpg',
      email: 'attendant@cloud9.com',
      phone: '0715123456')
];
