import 'package:dream_note/logic/blocs/dreams/bloc/dreams_bloc.dart';
import 'package:dream_note/models/dream_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class MainScreenCalendar extends StatelessWidget {
  const MainScreenCalendar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DreamsBloc dreamsBloc = BlocProvider.of<DreamsBloc>(context);
    List<Dream> dreamList = dreamsBloc.state.dreams;
    List<DateTime> dreamsDateList = [];
    for (Dream d in dreamList) {
      dreamsDateList.add(d.dreamDate.copyWith(
          year: d.dreamDate.year,
          month: d.dreamDate.month,
          day: d.dreamDate.day,
          hour: 0,
          minute: 0,
          second: 0,
          millisecond: 0,
          isUtc: true));
      // print(dreamsDateList.last);
      // print(dreamsDateList.last.isUtc);
    }

    return Column(
      children: [
        TableCalendar(
          focusedDay: DateTime.now(),
          firstDay: DateTime(1900),
          lastDay: DateTime(2200),
          onFormatChanged: (format) {
            print(format);
          },
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              return Center(
                child: dreamsDateList.contains(day)
                    ? CircleAvatar(
                        backgroundColor: Colors.deepPurpleAccent,
                        child: Text(
                          day.day.toString(),
                        ))
                    : Text(day.day.toString()),
              );
            },
          ),
          calendarFormat: CalendarFormat.month,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
          },
          // locale: "ru_RU",
        ),
      ],
    );
  }
}
