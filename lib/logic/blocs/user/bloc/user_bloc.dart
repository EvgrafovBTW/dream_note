import 'package:dream_note/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UpdateUserData>((event, emit) {
      if (state.user != null) {
        emit(state.copyWith(user: event.user));
      } else {
        emit(
          UserState(user: event.user),
        );
      }
    });
    on<InitUser>(
      (event, emit) => emit(
        UserState(
          user: DreamUser(
            id: event.id,
            name: event.name,
            email: event.email,
            gender: event.gender,
            phone: event.phone,
            createdDate: event.createdDate,
            lastName: event.lastName,
          ),
        ),
      ),
    );
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) => UserState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(UserState state) => state.toMap();
}
