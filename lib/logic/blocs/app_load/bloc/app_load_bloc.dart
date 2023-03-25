import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_load_event.dart';
part 'app_load_state.dart';

class AppLoadBloc extends Bloc<AppLoadEvent, AppLoadState> {
  AppLoadBloc() : super(AppLoadInitial()) {
    on<AppLoadStart>((event, emit) => emit(AppLoading()));
    on<AppLoadComplete>((event, emit) => emit(AppLoaded()));
  }
}
