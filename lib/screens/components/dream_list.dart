import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../models/dream_model.dart';
import '../../utils.dart';
import '../consecutive_screens/dream_screen.dart';

class DreamList extends StatelessWidget {
  const DreamList({super.key, required this.dreamList, required this.maxLines});

  final List<Dream> dreamList;
  final int maxLines;

  String getCardTitle(Dream d) {
    String title = '';
    if (d.title != null) {
      title = d.title!;
    } else {
      title = getDateString(d.dreamDate.toIso8601String());
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (Dream d in dreamList)
          GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  platformPageRoute(
                    material: (context, platform) => MaterialPageRouteData(),
                    cupertino: (context, platform) => CupertinoPageRouteData(),
                    context: context,
                    builder: (context) => DreamScreen(d),
                  )
              ),
              child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            getCardTitle(d),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          d.dreamContent,
                          maxLines: maxLines,
                        ),
                      ),
                    ],
                  )
              )
          )
      ],
    );
  }
}
