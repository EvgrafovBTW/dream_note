import 'package:dream_note/models/dream_model.dart';
import 'package:dream_note/screens/consecutive_screens/dream_screen.dart';
import 'package:dream_note/utils.dart';
import 'package:flutter/material.dart';


/// Класс который создает виджет со списком снов
class DreamList extends StatelessWidget {
  const DreamList({super.key, required this.dreamList, required this.maxLines});

  final List<Dream> dreamList;
  final int maxLines;

  /// Возвращает название сна, в случае если его нет, возвращает строку с датой
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
            onTap: () => platformNavigateTo(context: context, screen: DreamScreen(dreamList[index])),
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
