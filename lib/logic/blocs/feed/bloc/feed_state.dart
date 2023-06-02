part of 'feed_bloc.dart';

/// Класс с данными постов
class FeedState extends Equatable {
  final List<Post> posts;

  const FeedState({
    this.posts = const [],
  });

  @override
  List<Object> get props => [posts];

  FeedState copyWith({
    List<Post>? posts,
  }) {
    return FeedState(
      posts: posts ?? this.posts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'posts': posts.map((x) => x.toMap()).toList(),
    };
  }

  factory FeedState.fromMap(Map<String, dynamic> map) {
    return FeedState(
      posts: List<Post>.from(
        map['posts'].map<Post>(
          (x) => Post.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedState.fromJson(String source) =>
      FeedState.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FeedsInitial extends FeedState {}

class FeedsLoading extends FeedState {}
