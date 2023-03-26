import 'package:dream_note/screens/new_dream_screen.dart';
import 'package:dream_note/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../models/dream_model.dart';

class DreamScreen extends StatelessWidget {
  final Dream dream;
  const DreamScreen(this.dream, {super.key});

  @override
  Widget build(BuildContext context) {
    /*
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        actions: [
          PlatformIconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outline,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            children: [
              DreamDateTime(
                date: dream.dreamDate,
                sSize: MediaQuery.of(context).size,
              ),
              const Divider(),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Text(dream.dreamContent),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );*/
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const BackButton(
              color: Colors.white,
            ),
            actions: [
              PlatformIconButton(
                onPressed: inProductionNotif,
                icon: const Icon(
                  Icons.favorite_outline,
                  color: Colors.white54,
                ),
              ),
            ],
            snap: true,
            floating: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                DreamHeader(dream: dream),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Text(dream.dreamContent),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DreamHeader extends StatelessWidget {
  const DreamHeader({
    super.key,
    required this.dream,
  });

  final Dream dream;

  @override
  Widget build(BuildContext context) {
    return PlatformAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      // material: (context, platform) =>
      //     MaterialAppBarData(shadowColor: Colors.transparent),
      title: dream.title != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    dream.title!,
                  ),
                ),
                Text(
                  getDateString(
                    dream.dreamDate.toIso8601String(),
                  ),
                )
              ],
            )
          : DreamDateTime(
              date: dream.dreamDate,
              sSize: MediaQuery.of(context).size,
            ),
    );
  }
}
