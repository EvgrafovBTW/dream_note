import 'package:bloc/bloc.dart';
import 'package:dream_note/models/user_model.dart';
import 'dart:convert';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<ChangeUserData>((event, emit) => UserState(user: event.userData));
  }
}
