import 'package:dream_note/models/post_model.dart';
import 'package:dream_note/screens/components/post_card.dart';
import 'package:flutter/material.dart';

/// Класс который возвращает список карточек постов
class PostCardList extends StatelessWidget {
  const PostCardList({super.key, required this.postList});

  final List<Post> postList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: postList.length,
        itemBuilder: (context, index) {
          return PostCard(post: postList[index]);
        });
  }
}
