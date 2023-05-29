import 'package:flutter/material.dart';

import '../../models/post_model.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(8), child: Text(post.postTitle, style: TextStyle(fontSize: 20),),),
          Padding(padding: EdgeInsets.all(8), child: Text(post.postContent),),
        ],
      ),
    );
  }
}
