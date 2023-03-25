part of 'dreams_bloc.dart';

abstract class DreamsState extends Equatable {
  const DreamsState();
  
  @override
  List<Object> get props => [];
}

class DreamsInitial extends DreamsState {}
