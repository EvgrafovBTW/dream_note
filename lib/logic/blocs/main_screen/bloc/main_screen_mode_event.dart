part of 'main_screen_mode_bloc.dart';

abstract class MainScreenModeEvent extends Equatable {
  const MainScreenModeEvent();

  @override
  List<Object> get props => [];
}

class MainScreenModeChangeFeed extends MainScreenModeEvent {}

class MainScreenModeChangeCalendar extends MainScreenModeEvent {}
