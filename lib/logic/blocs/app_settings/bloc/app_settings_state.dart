// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'app_settings_bloc.dart';

class AppSettingsState extends Equatable {
  Color primaryColor;
  Color onPrimaryColor;
  bool isDarkMode;
  bool isGuardedMode;
  AppSettingsState({
    this.primaryColor = Colors.teal,
    this.onPrimaryColor = Colors.grey,
    this.isDarkMode = false,
    this.isGuardedMode = false,
  });

  @override
  List<Object> get props => [
        primaryColor,
        onPrimaryColor,
        isDarkMode,
        isGuardedMode,
      ];

  AppSettingsState copyWith({
    Color? primaryColor,
    Color? onPrimaryColor,
    bool? isDarkMode,
    bool? isGuardedMode,
  }) {
    return AppSettingsState(
      primaryColor: primaryColor ?? this.primaryColor,
      onPrimaryColor: onPrimaryColor ?? this.onPrimaryColor,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isGuardedMode: isGuardedMode ?? this.isGuardedMode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'primaryColor': primaryColor.value,
      'onPrimaryColor': onPrimaryColor.value,
      'isDarkMode': isDarkMode,
      'isGuardedMode': isGuardedMode,
    };
  }

  factory AppSettingsState.fromMap(Map<String, dynamic> map) {
    return AppSettingsState(
      primaryColor: Color(map['primaryColor'] as int),
      onPrimaryColor: Color(map['onPrimaryColor'] as int),
      isDarkMode: map['isDarkMode'] as bool,
      isGuardedMode: map['isGuardedMode'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppSettingsState.fromJson(String source) =>
      AppSettingsState.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AppSettingsInitial extends AppSettingsState {}
