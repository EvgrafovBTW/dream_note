import 'package:dream_note/logic/blocs/app_settings/bloc/app_settings_bloc.dart';
import 'package:dream_note/logic/blocs/bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'package:dream_note/models/dream_model.dart';
import 'package:dream_note/screens/consecutive_screens/dream_screen.dart';
import 'package:dream_note/utils.dart';
import 'package:flutter/gestures.dart';
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
          List<Widget> dreamCards = List.generate(
            state.dreams.length,
            (i) => DreamCard(state.dreams[i]),
          );
          return CustomScrollView(
            slivers: [
              const SliverAppBar(
                snap: true,
                floating: true,
              ),
              SliverList(
                delegate: SliverChildListDelegate(dreamCards),
              ),
            ],
          );
          /*
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
          */
        },
      ),
    );
  }
}

class DreamCard extends StatefulWidget {
  final Dream dream;
  const DreamCard(
    this.dream, {
    super.key,
  });

  @override
  State<DreamCard> createState() => _DreamCardState();
}

class _DreamCardState extends State<DreamCard> {
  @override
  Widget build(BuildContext context) {
    double sHeight = MediaQuery.of(context).size.height;
    String getCardText(String text) {
      String newText = text;
      if (text.length > 300) {
        newText = '${newText.substring(0, 300)}...';
      }
      return newText;
    }

    String getCardTitle() {
      String title = '';
      if (widget.dream.title != null) {
        title = widget.dream.title!;
      } else {
        title = getDateString(widget.dream.dreamDate.toIso8601String());
      }
      return title;
    }

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        platformPageRoute(
          material: (context, platform) => MaterialPageRouteData(),
          cupertino: (context, platform) => CupertinoPageRouteData(),
          context: context,
          builder: (context) => DreamScreen(widget.dream),
        ),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          getCardTitle(),
                          style: TextStyle(
                            fontSize: sHeight * 0.02,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (widget.dream.title != null)
                        Text(
                          getDateString(
                              widget.dream.dreamDate.toIso8601String()),
                          style: TextStyle(
                            color: state.isDarkMode
                                ? Colors.white54
                                : Colors.black54,
                          ),
                        )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: getCardText(widget.dream.dreamContent),
                          ),
                          if (widget.dream.dreamContent.length > 300)
                            TextSpan(
                              text: ' развернуть...',
                              style: TextStyle(
                                color: state.primaryColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    platformPageRoute(
                                      material: (context, platform) =>
                                          MaterialPageRouteData(),
                                      cupertino: (context, platform) =>
                                          CupertinoPageRouteData(),
                                      context: context,
                                      builder: (context) =>
                                          DreamScreen(widget.dream),
                                    ),
                                  );
                                },
                            )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
