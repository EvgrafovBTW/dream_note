import 'package:dream_note/logic/blocs/app_data/bloc/app_data_bloc.dart';
import 'package:dream_note/logic/blocs/bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'package:dream_note/screens/components/dream_card.dart';
import 'package:dream_note/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../logic/blocs/dreams/bloc/dreams_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    AppDataBloc appDataBloc = BlocProvider.of<AppDataBloc>(context);
    if (appDataBloc.state.needInfo) {
      appDataBloc.add(EmitInfoScreen(context));
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'floatingActionButton',
        onPressed: () {
          pageController.animateToPage(
            1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.decelerate,
          );
        },
      ),
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
            List<Widget> dreamCards = List.generate(
              state.dreams.length,
              (i) => SlidableDreamCard(state.dreams[i]),
            );
            return SafeArea(
              child: PageView(
                controller: pageController,
                children: [
                  CustomScrollView(
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
                  ),
                  Column(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class MainScreenModeSwitcher extends StatelessWidget {
  const MainScreenModeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
