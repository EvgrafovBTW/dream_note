import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DreamUser extends Equatable {
  String id;
  String name;
  String? lastName;
  String email;
  String gender;
  String? createdDate;
  String? phone;
  DreamUser({
    required this.id,
    required this.name,
    this.lastName,
    required this.email,
    required this.gender,
    this.createdDate,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'lastName': lastName,
      'email': email,
      'gender': gender,
      'createdDate': createdDate,
      'phone': phone,
    };
  }

  factory DreamUser.fromMap(Map<String, dynamic> map) {
    return DreamUser(
      id: map['id'] as String,
      name: map['name'] as String,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      email: map['email'] as String,
      gender: map['gender'] as String,
      createdDate:
          map['createdDate'] != null ? map['createdDate'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DreamUser.fromJson(String source) =>
      DreamUser.fromMap(json.decode(source) as Map<String, dynamic>);

  DreamUser copyWith({
    String? id,
    String? name,
    String? lastName,
    String? email,
    String? gender,
    String? createdDate,
    String? phone,
  }) {
    return DreamUser(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      createdDate: createdDate ?? this.createdDate,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<dynamic> get props => [
        name,
        lastName,
        id,
        email,
        gender,
        createdDate,
        phone,
      ];
}
