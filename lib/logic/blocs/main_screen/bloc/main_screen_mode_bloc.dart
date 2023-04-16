import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_screen_mode_event.dart';
part 'main_screen_mode_state.dart';

class MainScreenModeBloc
    extends Bloc<MainScreenModeEvent, MainScreenModeState> {
  MainScreenModeBloc() : super(MainScreenModeFeed()) {
    on<MainScreenModeChangeFeed>((event, emit) => emit(MainScreenModeFeed()));
    on<MainScreenModeChangeCalendar>(
        (event, emit) => emit(MainScreenModeCalendar()));
  }
}
