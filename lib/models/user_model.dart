import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DreamUser {
  String name;
  String? lastName;
  DreamUser({
    required this.name,
    this.lastName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'lastName': lastName,
    };
  }

  factory DreamUser.fromMap(Map<String, dynamic> map) {
    return DreamUser(
      name: map['name'] as String,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DreamUser.fromJson(String source) =>
      DreamUser.fromMap(json.decode(source) as Map<String, dynamic>);

  DreamUser copyWith({
    String? name,
    String? lastName,
  }) {
    return DreamUser(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
    );
  }
}
