import 'dart:convert';

import '../services/constant.dart';

class Cast {
  String name;
  String profileUrl;
  Cast({
    required this.name,
    required this.profileUrl,
  });

  factory Cast.fromMap(Map<String, dynamic> map) {
    return Cast(
      name: map['name'] ?? '',
      profileUrl: map['profile_path'] != null
          ? Constants.imagebaseurl + map['profile_path']
          : "",
    );
  }
  factory Cast.fromJson(String source) => Cast.fromMap(json.decode(source));
}
