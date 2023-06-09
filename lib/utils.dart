import 'package:dream_note/logic/blocs/dreams/bloc/dreams_bloc.dart';
import 'package:dream_note/models/dream_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:overlay_support/overlay_support.dart';

String getMonthName(int m) {
  Map<int, String> monthNum = {
    1: 'Января',
    2: 'Февраля',
    3: 'Марта',
    4: 'Апреля',
    5: 'Мая',
    6: 'Июня',
    7: 'Июля',
    8: 'Августа',
    9: 'Сентября',
    10: 'Октября',
    11: 'Ноября',
    12: 'Декабря',
  };
  return monthNum[m] ?? 'Января';
}

String getDateString(String d) {
  String dateString = d;
  dateString = dateString.substring(0, dateString.indexOf('T'));
  return dateString;
}

inProductionNotif() => showSimpleNotification(const Text('В разработке'));

deleteDream({
  required BuildContext context,
  required Dream dream,
}) async {
  String dreamName = '';
  if (dream.title != null) {
    dreamName = '"${dream.title!}"';
  } else {
    dreamName = 'от ${getDateString(dream.dreamDate.toIso8601String())}';
  }
  await showPlatformDialog(
    context: context,
    builder: (context) => PlatformAlertDialog(
      title: Column(
        children: [
          Text(
            'Удалить сон $dreamName?',
          )
        ],
      ),
      actions: [
        PlatformTextButton(
          onPressed: () {
            BlocProvider.of<DreamsBloc>(context).add(DreamRemove(dream));
            showSimpleNotification(Text('сон $dreamName успешно удалён'));
            Navigator.pop(context);
          },
          child: const Text(
            'Да',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        PlatformTextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Нет'),
        ),
      ],
    ),
  );
}

toggleDreamFavorites({
  required BuildContext context,
  required Dream dream,
}) {
  String dreamName = '';
  if (dream.title != null) {
    dreamName = '"${dream.title!}"';
  } else {
    dreamName = 'от ${getDateString(dream.dreamDate.toIso8601String())}';
  }
  BlocProvider.of<DreamsBloc>(context)
      .add(DreamToggleFavorite(!dream.isFavorite, dream));
  if (dream.isFavorite) {
    showSimpleNotification(Text('сон $dreamName удалён из избранного'));
  } else {
    showSimpleNotification(Text('сон $dreamName добавлен в избранное'));
  }
}

platformNavigateTo({
  required BuildContext context,
  required Widget screen,
}) {
  Navigator.push(
    context,
    platformPageRoute(
      material: (context, platform) => MaterialPageRouteData(),
      cupertino: (context, platform) => CupertinoPageRouteData(),
      context: context,
      builder: (context) => screen,
    ),
  );
}

class DevBorder extends StatelessWidget {
  final Widget child;
  const DevBorder({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.amber)),
      child: child,
    );
  }
}

String fishText = '''
Таким образом новая модель организационной деятельности позволяет выполнять важные задания по разработке дальнейших направлений развития. Разнообразный и богатый опыт консультация с широким активом позволяет выполнять важные задания по разработке дальнейших направлений развития. Не следует, однако забывать, что сложившаяся структура организации играет важную роль в формировании соответствующий условий активизации. Равным образом начало повседневной работы по формированию позиции позволяет выполнять важные задания по разработке существенных финансовых и административных условий. Разнообразный и богатый опыт сложившаяся структура организации позволяет оценить значение дальнейших направлений развития. Задача организации, в особенности же рамки и место обучения кадров влечет за собой процесс внедрения и модернизации форм развития.

Задача организации, в особенности же сложившаяся структура организации позволяет выполнять важные задания по разработке существенных финансовых и административных условий. Повседневная практика показывает, что начало повседневной работы по формированию позиции позволяет выполнять важные задания по разработке систем массового участия. Товарищи! постоянный количественный рост и сфера нашей активности влечет за собой процесс внедрения и модернизации соответствующий условий активизации. Равным образом новая модель организационной деятельности требуют определения и уточнения соответствующий условий активизации. Идейные соображения высшего порядка, а также рамки и место обучения кадров в значительной степени обуславливает создание систем массового участия. Задача организации, в особенности же начало повседневной работы по формированию позиции требуют от нас анализа системы обучения кадров, соответствует насущным потребностям.''';

int addDreamIndex = 1;

List<Color> settingsColors = [
  Colors.teal,
  Colors.greenAccent,
  Colors.green,
  Colors.lightGreen,
  Colors.lightGreenAccent,
  Colors.lime,
  Colors.indigo,
  Colors.indigoAccent,
  Colors.blue,
  Colors.cyan,
  Colors.lightBlue,
  Colors.pink,
  Colors.pinkAccent,
  Colors.orange,
  Colors.deepOrange,
  const Color.fromARGB(255, 104, 20, 14),
  Colors.brown,
  Colors.purple,
  Colors.deepPurple,
  Colors.grey,
];
