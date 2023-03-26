// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dreams_bloc.dart';

class DreamsState extends Equatable {
  final List<Dream> dreams;
  const DreamsState({
    this.dreams = const [],
  });

  @override
  List<Object> get props => [dreams];

  DreamsState copyWith({
    List<Dream>? dreams,
  }) {
    return DreamsState(
      dreams: dreams ?? this.dreams,
    );
  }
}

class DreamsInitial extends DreamsState {}

class DreamsLoading extends DreamsState {}
