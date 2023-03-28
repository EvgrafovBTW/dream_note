import 'dart:io';

import 'package:dream_note/logic/blocs/dreams/bloc/dreams_bloc.dart';
import 'package:dream_note/screens/consecutive_screens/dream_screen.dart';
import 'package:dream_note/screens/new_dream_screen.dart';
import 'package:dream_note/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../logic/blocs/app_settings/bloc/app_settings_bloc.dart';
import '../../models/dream_model.dart';

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

    Widget getGuardedCardTitle() {
      late Widget title;
      if (widget.dream.title != null) {
        title = Text(
          getCardTitle(),
          style: TextStyle(
            fontSize: sHeight * 0.04,
            fontWeight: FontWeight.w500,
          ),
        );
      } else {
        title = DreamDateTime(
          date: widget.dream.dreamDate,
          sSize: MediaQuery.of(context).size,
        );
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
              if (state.isGuardedMode) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getGuardedCardTitle(),
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
                    Icon(
                      Platform.isAndroid
                          ? Icons.arrow_forward
                          : Icons.arrow_forward_ios,
                    )
                  ],
                );
              }
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

class SlidableDreamCard extends StatelessWidget {
  final Dream dream;
  const SlidableDreamCard(
    this.dream, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            onPressed: (context) {
              deleteDream(context: context, dream: dream);
            },
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            icon: Icons.delete,
          ),
          BlocBuilder<DreamsBloc, DreamsState>(
            builder: (context, state) {
              return SlidableAction(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                onPressed: (context) {
                  toggleDreamFavorites(context: context, dream: dream);
                },
                foregroundColor: Colors.white,
                backgroundColor: Colors.amber,
                icon: dream.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
              );
            },
          ),
        ],
      ),
      child: DreamCard(
        dream,
      ),
    );
  }
}
