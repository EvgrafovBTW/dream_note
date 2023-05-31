import 'package:dream_note/logic/blocs/feed/bloc/feed_bloc.dart';
import 'package:dream_note/screens/components/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../models/post_model.dart';

class PostCardList extends StatefulWidget {
  const PostCardList({super.key, required this.postList});

  final List<Post> postList;

  @override
  State<PostCardList> createState() => _PostCardListState();
}

class _PostCardListState extends State<PostCardList> {
  // List<Post> listPost;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    BlocProvider.of<FeedBloc>(context).add(FeedLoad());
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) {
      // setState(() {
      // BlocProvider.of<FeedBloc>(context).add(FeedLoad());
      // });
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data time field"),
      ),
      body: Scrollbar(
        child: SmartRefresher(
            enablePullDown: true,
            // header: WaterDropMaterialHeader(),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: SingleChildScrollView(
              child: BlocBuilder<FeedBloc, FeedState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      for (Post post in state.posts) PostCard(post: post)
                    ],
                  );
                },
              ),
            )),
      ),
    );
  }
}
