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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dreams': dreams.map((x) => x.toMap()).toList(),
    };
  }

  factory DreamsState.fromMap(Map<String, dynamic> map) {
    return DreamsState(
      dreams: List<Dream>.from(
        map['dreams'].map<Dream>(
          (x) => Dream.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DreamsState.fromJson(String source) =>
      DreamsState.fromMap(json.decode(source) as Map<String, dynamic>);
}

class DreamsInitial extends DreamsState {}

class DreamsLoading extends DreamsState {}
