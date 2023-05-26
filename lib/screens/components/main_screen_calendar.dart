import 'package:dream_note/logic/blocs/dreams/bloc/dreams_bloc.dart';
import 'package:dream_note/models/dream_model.dart';
import 'package:dream_note/screens/components/dream_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class MainScreenCalendar extends StatefulWidget {
  const MainScreenCalendar({
    super.key,
  });

  @override
  State<MainScreenCalendar> createState() => _MainScreenCalendarState();
}

class _MainScreenCalendarState extends State<MainScreenCalendar> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  bool _compareDate(DateTime fromDream, DateTime fromCalendar) {
    return fromDream
        .copyWith(
        year: fromDream.year,
        month: fromDream.month,
        day: fromDream.day,
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
        isUtc: true)
        .compareTo(fromCalendar) ==
        0;
  }

  List<Dream> _getDreamsForDay(DateTime day) {
    DreamsBloc dreamsBloc = BlocProvider.of<DreamsBloc>(context);
    List<Dream> dreamsAtDayList = [];
    for (Dream d in dreamsBloc.state.dreams) {
      if (_compareDate(d.dreamDate, day)) {
        dreamsAtDayList.add(d);
      }
    }
    return dreamsAtDayList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime(1900),
          lastDay: DateTime(2200),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          onFormatChanged: (format) {
            print(format);
          },
          eventLoader: (day) {
            return _getDreamsForDay(day);
          },
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarBuilders: const CalendarBuilders(),
          calendarFormat: CalendarFormat.month,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
          },
        ),
        Expanded(
          child: DreamList(dreamList : _getDreamsForDay(_selectedDay), maxLines: 10,),
        )
      ],
    );
  }
}
