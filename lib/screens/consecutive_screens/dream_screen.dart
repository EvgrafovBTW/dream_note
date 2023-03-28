// ignore_for_file: use_build_context_synchronously

import 'package:dream_note/logic/blocs/app_settings/bloc/app_settings_bloc.dart';
import 'package:dream_note/logic/blocs/dreams/bloc/dreams_bloc.dart';
import 'package:dream_note/screens/new_dream_screen.dart';
import 'package:dream_note/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../models/dream_model.dart';

class DreamScreen extends StatelessWidget {
  final Dream dream;
  const DreamScreen(this.dream, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const BackButton(
              color: Colors.white,
            ),
            actions: [
              PlatformIconButton(
                onPressed: () async {
                  await deleteDream(
                    context: context,
                    dream: dream,
                  );
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.delete,
                ),
              ),
              BlocBuilder<DreamsBloc, DreamsState>(
                builder: (context, state) {
                  Dream currentDream =
                      state.dreams.firstWhere((d) => d.id == dream.id);
                  return PlatformIconButton(
                    onPressed: () {
                      toggleDreamFavorites(
                          context: context, dream: currentDream);
                    },
                    icon: Icon(
                      currentDream.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                    ),
                  );
                },
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
      backgroundColor:
          BlocProvider.of<AppSettingsBloc>(context).state.isDarkMode
              ? Colors.white24
              : Colors.black38,
      material: (context, platform) =>
          MaterialAppBarData(shadowColor: Colors.transparent, elevation: 0),
      cupertino: (context, platform) => CupertinoNavigationBarData(),
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
