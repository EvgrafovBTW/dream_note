import 'package:dream_note/logic/blocs/bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'package:dream_note/logic/blocs/dreams/bloc/dreams_bloc.dart';
import 'package:dream_note/models/dream_model.dart';
import 'package:dream_note/screens/components/dream_card.dart';
import 'package:dream_note/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class FavoriteDreamsScreen extends StatelessWidget {
  const FavoriteDreamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: BlocBuilder<DreamsBloc, DreamsState>(
          builder: (context, state) {
            if (state.dreams.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Похоже, список ваших снов пуст'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: PlatformElevatedButton(
                      child: const Text('Записать свой первый сон'),
                      onPressed: () =>
                          BlocProvider.of<BottomNavigationBloc>(context).add(
                        BottomNavTap(addDreamIndex),
                      ),
                    ),
                  )
                ],
              );
            }
            List<Widget> dreamCards = [];
            dreamCards.clear();
            for (Dream dream in state.dreams) {
              if (dream.isFavorite) {
                dreamCards.add(SlidableDreamCard(dream));
              }
            }

            return CustomScrollView(
              slivers: [
                const SliverAppBar(
                  snap: true,
                  floating: true,
                  title: Text('Избранное'),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(dreamCards),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
