import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'app_settings_event.dart';
part 'app_settings_state.dart';

class AppSettingsBloc extends HydratedBloc<AppSettingsEvent, AppSettingsState> {
  AppSettingsBloc() : super(AppSettingsInitial()) {
    on<ChangeMainAppColor>(
      (event, emit) => emit(
        state.copyWith(
          primaryColor: event.newMainColor,
        ),
      ),
    );
    on<ChangeAdditionalAppColor>(
      (event, emit) => emit(
        state.copyWith(
          onPrimaryColor: event.newAdditionalColor,
        ),
      ),
    );
    on<ToggleDarkMode>(
      (event, emit) => emit(
        state.copyWith(
          isDarkMode: event.darkModeValue,
        ),
      ),
    );
  }

  @override
  AppSettingsState? fromJson(Map<String, dynamic> json) =>
      AppSettingsState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(AppSettingsState state) => state.toMap();
}
