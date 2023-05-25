import 'package:dream_note/logic/blocs/dreams/bloc/dreams_bloc.dart';
import 'package:dream_note/models/dream_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import 'dream_card.dart';

class MainScreenCalendar extends StatefulWidget {
  const MainScreenCalendar({
    super.key,
  });

  @override
  State<MainScreenCalendar> createState() => _MainScreenCalendarState();
}

class _MainScreenCalendarState extends State<MainScreenCalendar> {
  late DreamsBloc dreamsBloc;
  List<Dream> dreamList = [];
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  late Widget listView;

  @override
  void initState() {
    super.initState();
    DreamsBloc dreamsBloc = BlocProvider.of<DreamsBloc>(context);
    dreamList = dreamsBloc.state.dreams;
    listView = _getCardDreamsForDay(_selectedDay);
  }

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

  Widget _getCardDreamsForDay(DateTime day) {
    List<Widget> dreamCards = [];
    for (Dream d in _getDreamsForDay(_selectedDay)) {
      dreamCards.add(DreamCard(d));
    }
    listView = ListView.builder(
        itemCount: dreamCards.length,
        itemBuilder: (context, index) {
          return dreamCards[index];
        });
    return listView;
  }

  List<Dream> _getDreamsForDay(DateTime day) {
    List<Dream> dreamsAtDayList = [];
    for (Dream d in dreamList) {
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
              listView = _getCardDreamsForDay(_selectedDay);
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
        Flexible(
          child: _getCardDreamsForDay(_selectedDay),
        )
      ],
    );
  }
}
