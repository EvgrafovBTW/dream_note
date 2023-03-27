part of 'dreams_bloc.dart';

abstract class DreamsEvent extends Equatable {
  const DreamsEvent();

  @override
  List<Object> get props => [];
}

class DreamAdd extends DreamsEvent {
  final Dream newDream;
  const DreamAdd(this.newDream);
}

class DreamRemove extends DreamsEvent {
  final Dream dream;
  const DreamRemove(this.dream);
}
