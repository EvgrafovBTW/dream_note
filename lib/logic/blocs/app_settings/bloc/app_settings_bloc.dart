import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'app_settings_event.dart';
part 'app_settings_state.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  AppSettingsBloc() : super(AppSettingsInitial()) {
    on<ChangeMainAppColor>(
      (event, emit) => emit(
        state.copyWith(
          primaryColor: event.newMainColor,
        ),
      ),
    );
  }
}
