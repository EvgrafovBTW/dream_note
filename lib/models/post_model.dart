import 'dart:convert';

class Post {
  int id;
  String postTitle;
  String postContent;
  String imageURL;
  // DateTime postTime;

  Post({
    required this.id,
    required this.postTitle,
    required this.postContent,
    required this.imageURL,
    // required this.postTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'id': id,
      'postTitle': postTitle,
      'postContent': postContent,
      'imageURL': imageURL,
      // 'postTime': postTime,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as int,
      postTitle: map['postTitle'] as String,
      postContent: map['postContent'] as String,
      imageURL: map['imageURL'] as String,
      // postTime: DateTime.fromMillisecondsSinceEpoch(map['postTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);

  Post copyWith({
    int? id,
    String? postContent,
    String? postTitle,
    String? imageURL,
    // DateTime? postTime,
  }) {
    return Post(
      id: id ?? this.id,
      postTitle: postTitle ?? this.postTitle,
      postContent: postContent ?? this.postContent,
      imageURL: imageURL ?? this.imageURL,
      // postTime: postTime ?? this.postTime,
    );
  }
}