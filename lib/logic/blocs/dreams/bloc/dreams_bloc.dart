import 'package:bloc/bloc.dart';
import 'package:dream_note/models/dream_model.dart';
import 'package:equatable/equatable.dart';

part 'dreams_event.dart';
part 'dreams_state.dart';

class DreamsBloc extends Bloc<DreamsEvent, DreamsState> {
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
  }
}
