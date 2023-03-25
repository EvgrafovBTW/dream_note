import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dreams_event.dart';
part 'dreams_state.dart';

class DreamsBloc extends Bloc<DreamsEvent, DreamsState> {
  DreamsBloc() : super(DreamsInitial()) {
    on<DreamsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
