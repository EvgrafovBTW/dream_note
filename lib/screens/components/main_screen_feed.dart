import 'package:flutter/material.dart';

class MainScreenFeed extends StatelessWidget {
  const MainScreenFeed({
    super.key,
    required this.dreamCards,
  });

  final List<Widget> dreamCards;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // SliverAppBar(
        //   snap: true,
        //   floating: true,
        //   title: PlatformSwitch(
        //     value: false,
        //     onChanged: (v) {},
        //   ),
        // ),
        SliverList(
          delegate: SliverChildListDelegate(dreamCards),
        ),
      ],
    );
  }
}
