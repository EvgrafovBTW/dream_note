part of 'feed_bloc.dart';

/// Файл в котором описываются события
abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object> get props => [];
}

class FeedLoad extends FeedEvent {}
