// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_settings_bloc.dart';

class AppSettingsState extends Equatable {
  Color primaryColor;
  Color onPrimaryColor;
  AppSettingsState({
    this.primaryColor = Colors.teal,
    this.onPrimaryColor = Colors.white,
  });

  @override
  List<Object> get props => [primaryColor];

  AppSettingsState copyWith({
    Color? primaryColor,
  }) {
    return AppSettingsState(
      primaryColor: primaryColor ?? this.primaryColor,
    );
  }
}

class AppSettingsInitial extends AppSettingsState {}
