import 'dart:async';

import 'package:dream_note/logic/blocs/feed/bloc/feed_bloc.dart';
import 'package:dream_note/models/post_model.dart';
import 'package:dream_note/screens/components/post_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

/// Класс с экраном постов
class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {

  /// Событие которое срабатывает при обновлении
  Future<void> _handleRefresh() async {
    setState(() {
      //TODO: обнаружен недочет что он срабатывает и при открытии страницы два выхода: при инициализации экрана не вызывать/убрать загрузку при инициализации приложения
      BlocProvider.of<FeedBloc>(context).add(FeedLoad());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox.expand(
        child: BlocBuilder<FeedBloc, FeedState>(
          builder: (context, state) {
            if (state.posts.isEmpty) {
              return Text('Постов нема');
            }
            return LiquidPullToRefresh(
              onRefresh: _handleRefresh,
              showChildOpacityTransition: false,
              child: PostCardList(postList: state.posts),
            );
          },
        ),
      ),
    );
  }
}
