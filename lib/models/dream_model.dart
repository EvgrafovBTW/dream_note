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
}
