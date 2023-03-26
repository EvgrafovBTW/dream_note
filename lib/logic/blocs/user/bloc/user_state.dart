// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'user_bloc.dart';

class UserState {
  DreamUser? user;
  UserState({
    this.user,
  });

  // @override
  // List<dynamic> get props => [user];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user?.toMap(),
    };
  }

  factory UserState.fromMap(Map<String, dynamic> map) {
    return UserState(
      user: map['user'] != null
          ? DreamUser.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserState.fromJson(String source) =>
      UserState.fromMap(json.decode(source) as Map<String, dynamic>);

  UserState copyWith({
    DreamUser? user,
  }) {
    return UserState(
      user: user ?? this.user,
    );
  }
}

class UserInitial extends UserState {}
