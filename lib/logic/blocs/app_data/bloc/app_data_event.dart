part of 'app_data_bloc.dart';

abstract class AppDataEvent extends Equatable {
  const AppDataEvent();

  @override
  List<Object> get props => [];
}

class UpdateAppVersion extends AppDataEvent {
  final String newVersion;
  final bool needInfo;
  const UpdateAppVersion(this.newVersion, this.needInfo);
}

class EmitInfoScreen extends AppDataEvent {
  final context;
  const EmitInfoScreen(this.context);
}
