import 'package:dream_note/screens/components/dream_whats_new.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'dart:convert';

part 'app_data_event.dart';
part 'app_data_state.dart';

class AppDataBloc extends HydratedBloc<AppDataEvent, AppDataState> {
  AppDataBloc() : super(AppDataInitial()) {
    on<UpdateAppVersion>(
      (event, emit) => emit(
        state.copyWith(
          appVersion: event.newVersion,
          needInfo: event.needInfo,
        ),
      ),
    );
    on<EmitInfoScreen>(
      (event, emit) {
        emit(state.copyWith(needInfo: false));
        showPlatformModalSheet(
          context: event.context,
          builder: (c) => DreamWhatsNew(
            version: state.appVersion,
          ),
        );
      },
    );
  }

  @override
  AppDataState? fromJson(Map<String, dynamic> json) =>
      AppDataState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(AppDataState state) => state.toMap();
}
