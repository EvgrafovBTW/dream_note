import 'package:dream_note/logic/blocs/feed/bloc/feed_bloc.dart';
import 'package:dream_note/screens/components/post_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox.expand(
          child: BlocBuilder<FeedBloc, FeedState>(
            builder: (context, state) {
              if (state.posts.isEmpty) {
                return Text('Постов нема');
              }
              return PostCardList(postList: state.posts);
            },
          ),
      ),
    );
  }
}
