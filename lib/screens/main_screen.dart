import 'package:dream_note/logic/blocs/bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'package:dream_note/models/dream_model.dart';
import 'package:dream_note/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../logic/blocs/dreams/bloc/dreams_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
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
          return SingleChildScrollView(
            child: Column(
              children: [
                PlatformAppBar(),
                for (Dream d in state.dreams)
                  Container(
                    child: Column(
                      children: [
                        Divider(),
                        Text(
                          d.title ?? d.dreamDate.toIso8601String(),
                        ),
                        Text(d.dreamContent),
                        Divider(),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
