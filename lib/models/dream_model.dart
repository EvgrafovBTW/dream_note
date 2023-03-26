import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Dream {
  String dreamContent;
  DateTime dreamDate;
  dynamic moonPhase;
  String? title;
  bool isFavorite;

  Dream({
    required this.dreamContent,
    required this.dreamDate,
    this.moonPhase,
    this.title,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dreamContent': dreamContent,
      'dreamDate': dreamDate.millisecondsSinceEpoch,
      'moonPhase': moonPhase,
      'title': title,
      'isFavorite': isFavorite,
    };
  }

  factory Dream.fromMap(Map<String, dynamic> map) {
    return Dream(
      dreamContent: map['dreamContent'] as String,
      dreamDate: DateTime.fromMillisecondsSinceEpoch(map['dreamDate'] as int),
      moonPhase: map['moonPhase'] as dynamic,
      title: map['title'] != null ? map['title'] as String : null,
      isFavorite: map['isFavorite'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Dream.fromJson(String source) =>
      Dream.fromMap(json.decode(source) as Map<String, dynamic>);
}
