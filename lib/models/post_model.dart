import 'dart:convert';

class Post {
  int id;
  String postTitle;
  String postContent;
  DateTime postTime;

  Post({
    required this.id,
    required this.postTitle,
    required this.postContent,
    required this.postTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'id': id,
      'postTitle': postTitle,
      'postContent': postContent,
      'postTime': postTime,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as int,
      postTitle: map['postTitle'] as String,
      postContent: map['postContent'] as String,
      postTime: DateTime.fromMillisecondsSinceEpoch(map['postTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);

  Post copyWith({
    int? id,
    String? postContent,
    String? postTitle,
    DateTime? postTime,
  }) {
    return Post(
      id: id ?? this.id,
      postTitle: postTitle ?? this.postTitle,
      postContent: postContent ?? this.postContent,
      postTime: postTime ?? this.postTime,
    );
  }
}