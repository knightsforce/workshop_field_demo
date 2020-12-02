import 'dart:convert';

import 'package:workshop_demo/domain/field.dart';

class ProfileData {
  final String name;
  final String lastName;
  final String email;

  ProfileData({
    this.name,
    this.lastName,
    this.email,
  });

  factory ProfileData.fromJSON(String str) {
    Map<String, dynamic> json = jsonDecode(str);
    return ProfileData(
      name: json[FieldId.name.value],
      lastName: json[FieldId.lastName.value],
      email: json[FieldId.email.value],
    );
  }

  String toJSON() => jsonEncode({
        FieldId.name.value: name,
        FieldId.lastName.value: lastName,
        FieldId.email.value: email,
      });
}
