part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class ChangeUserData extends UserEvent {
  final DreamUser userData;
  const ChangeUserData(this.userData);
}
