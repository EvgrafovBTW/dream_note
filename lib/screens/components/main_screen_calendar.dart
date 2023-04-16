import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MainScreenCalendar extends StatelessWidget {
  const MainScreenCalendar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          calendarBuilders: CalendarBuilders(),
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
