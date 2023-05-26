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
    return ListView.builder(
        itemCount: dreamList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  platformPageRoute(
                    material: (context, platform) => MaterialPageRouteData(),
                    cupertino: (context, platform) => CupertinoPageRouteData(),
                    context: context,
                    builder: (context) => DreamScreen(dreamList[index]),
                  )),
              child: Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        getCardTitle(dreamList[index]),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      '${dreamList[index].dreamContent}\n\n\n\n\n\n\n\n',
                      maxLines: maxLines,
                    ),
                  ),
                ],
              )));
        });
  }
}
