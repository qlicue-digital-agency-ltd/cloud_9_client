import 'package:cloud_9_client/models/consultation.dart';
import 'package:cloud_9_client/models/procedure.dart';
import 'package:cloud_9_client/models/profile.dart';
import 'package:meta/meta.dart';

class Nurse {
  final int id;
  final String email;
  final List<Consultation> consultations;
  final List<Procedure> procedures;
  final Profile profile;

  Nurse({
    @required this.id,
    @required this.consultations,
    @required this.procedures,
    @required this.email,
    @required this.profile,
  });

  Nurse.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['email'] != null),
        id = map['id'],
        email = map['email'].toString(),
        profile = Profile.fromMap(map['profile']),
        consultations = map['consultations'] != null
            ? (map['consultations'] as List)
                .map((i) => Consultation.fromMap(i))
                .toList()
            : null,
        procedures = map['procedures'] != null
            ? (map['procedures'] as List)
                .map((i) => Procedure.fromMap(i))
                .toList()
            : null;
}
