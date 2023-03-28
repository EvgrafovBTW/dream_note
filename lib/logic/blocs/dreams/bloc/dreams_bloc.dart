import 'package:bloc/bloc.dart';
import 'package:dream_note/models/dream_model.dart';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'dreams_event.dart';
part 'dreams_state.dart';

class DreamsBloc extends HydratedBloc<DreamsEvent, DreamsState> {
  DreamsBloc() : super(DreamsInitial()) {
    on<DreamAdd>((event, emit) {
      List<Dream> newDreams = List.from(state.dreams);
      newDreams.insert(0, event.newDream);
      emit(
        state.copyWith(
          dreams: newDreams,
        ),
      );
    });
    on<DreamRemove>((event, emit) {
      List<Dream> newDreams = List.from(state.dreams);
      newDreams.removeWhere((d) => d.id == event.dream.id);
      emit(
        state.copyWith(
          dreams: newDreams,
        ),
      );
    });

    on<DreamToggleFavorite>((event, emit) {
      Dream favDream = event.dream.copyWith(isFavorite: event.isFavorite);
      List<Dream> newDreams = List.from(state.dreams);
      newDreams =
          newDreams.map((d) => d.id == event.dream.id ? favDream : d).toList();
      emit(
        state.copyWith(
          dreams: newDreams,
        ),
      );
    });
  }

  @override
  DreamsState? fromJson(Map<String, dynamic> json) => DreamsState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(DreamsState state) => state.toMap();
}
