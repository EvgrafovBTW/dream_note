part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserData extends UserEvent {
  final DreamUser user;
  const UpdateUserData(this.user);
}

class InitUser extends UserEvent {
  String id;
  String name;
  String? lastName;
  String email;
  String gender;
  String? createdDate;
  String? phone;
  InitUser({
    required this.id,
    required this.name,
    this.lastName,
    required this.email,
    required this.gender,
    this.createdDate,
    this.phone,
  });
}
