part of 'app_settings_bloc.dart';

abstract class AppSettingsEvent extends Equatable {
  const AppSettingsEvent();

  @override
  List<Object> get props => [];
}

class ChangeMainAppColor extends AppSettingsEvent {
  final Color newMainColor;
  const ChangeMainAppColor(this.newMainColor);
}

class ChangeAdditionalAppColor extends AppSettingsEvent {
  final Color newAdditionalColor;
  const ChangeAdditionalAppColor(this.newAdditionalColor);
}

class ToggleDarkMode extends AppSettingsEvent {
  final bool darkModeValue;
  const ToggleDarkMode(this.darkModeValue);
}

class ToggleGuardedMode extends AppSettingsEvent {
  final bool guardedModeValue;
  const ToggleGuardedMode(this.guardedModeValue);
}
