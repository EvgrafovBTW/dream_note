// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'app_data_bloc.dart';

class AppDataState extends Equatable {
  final String appVersion;
  final bool needInfo;
  const AppDataState({
    this.appVersion = '0.0.1',
    this.needInfo = false,
  });

  @override
  List<Object> get props => [appVersion, needInfo];

  AppDataState copyWith({
    String? appVersion,
    bool? needInfo,
  }) {
    return AppDataState(
      appVersion: appVersion ?? this.appVersion,
      needInfo: needInfo ?? this.needInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'appVersion': appVersion,
      'needInfo': needInfo,
    };
  }

  factory AppDataState.fromMap(Map<String, dynamic> map) {
    return AppDataState(
      appVersion: map['appVersion'] as String,
      needInfo: map['needInfo'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppDataState.fromJson(String source) =>
      AppDataState.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AppDataInitial extends AppDataState {}
