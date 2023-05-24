import 'package:dream_note/logic/blocs/app_data/bloc/app_data_bloc.dart';
import 'package:dream_note/logic/blocs/bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'package:dream_note/logic/blocs/main_screen/bloc/main_screen_mode_bloc.dart';
import 'package:dream_note/screens/components/dream_card.dart';
import 'package:dream_note/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../logic/blocs/dreams/bloc/dreams_bloc.dart';
import 'components/main_screen_calendar.dart';
import 'components/main_screen_feed.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    AppDataBloc appDataBloc = BlocProvider.of<AppDataBloc>(context);
    MainScreenModeBloc mainScreenModeBloc =
        BlocProvider.of<MainScreenModeBloc>(context);
    if (appDataBloc.state.needInfo) {
      appDataBloc.add(EmitInfoScreen(context));
    }

    return Scaffold(
      /*floatingActionButton: FloatingActionButton(
        heroTag: 'floatingActionButtonMainScreen',
        onPressed: () {
          pageController.animateToPage(
            pageController.page == 1 ? 0 : 1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.decelerate,
          );
        },
        child: BlocBuilder<MainScreenModeBloc, MainScreenModeState>(
          builder: (context, state) {
            if (state is MainScreenModeFeed) {
              return const Icon(Icons.calendar_month_outlined);
            }
            return const Icon(Icons.feed_outlined);
          },
        ),
      ),*/
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
                onPageChanged: (value) {
                  if (value == 1) {
                    mainScreenModeBloc.add(MainScreenModeChangeFeed());
                  } else {
                    mainScreenModeBloc.add(MainScreenModeChangeCalendar());
                  }
                },
                controller: pageController,
                children: [
                  MainScreenFeed(dreamCards: dreamCards),
                  const MainScreenCalendar(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
