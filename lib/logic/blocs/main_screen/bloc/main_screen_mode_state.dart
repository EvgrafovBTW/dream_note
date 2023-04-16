part of 'main_screen_mode_bloc.dart';

abstract class MainScreenModeState extends Equatable {
  const MainScreenModeState();

  @override
  List<Object> get props => [];
}

class MainScreenModeFeed extends MainScreenModeState {}

class MainScreenModeCalendar extends MainScreenModeState {}
