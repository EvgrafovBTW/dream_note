import 'package:flutter/material.dart';

import 'package:dream_note/models/post_model.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              post.postTitle,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(post.postContent),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: screenWidth,
                maxHeight: (screenHeight * 0.75),
              ),
              child: Image(
                image: AssetImage(post.imageURL),
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Visibility(
                    visible: false,
                    child: Container(),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
