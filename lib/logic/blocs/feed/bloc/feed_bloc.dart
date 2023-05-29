import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dream_note/models/post_model.dart';

part 'feed_event.dart';

part 'feed_state.dart';

class FeedBloc extends HydratedBloc<FeedEvent, FeedState> {
  FeedBloc() : super(FeedsInitial()) {
    on<FeedLoad>((event, emit) async {
      List<Post> loadPosts = event.posts;
      emit(
          state.copyWith(posts: loadPosts)
      );
    });
  }

  @override
  FeedState? fromJson(Map<String, dynamic> json) => FeedState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(FeedState state) => state.toMap();
}