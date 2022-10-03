import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../providers/theme_provider.dart';
import '../../../providers/todo_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/date_and_time.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _format = CalendarFormat.twoWeeks;

  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDay;

  @override
  void initState() {
    _selectedDay = _focusedDay;
    super.initState();
  }

  CalendarStyle _getCalendarStyle(ThemeProvider themeProvider) {
    return CalendarStyle(
      markersMaxCount: 1,
      weekendTextStyle: const TextStyle(color: Colors.red),
      selectedDecoration: BoxDecoration(
          color: AppColors.getMaterialColorFromColor(
              themeProvider.selectedForegroundColor),
          shape: BoxShape.circle),
      todayDecoration: BoxDecoration(
          color: AppColors.getMaterialColorFromColor(
              themeProvider.selectedForegroundColor)[300],
          shape: BoxShape.circle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TodoProvider, ThemeProvider>(
      builder: (context, todoProvider, themeProvider, child) {
        return Material(
          elevation: 5,
          child: TableCalendar(
            locale: 'uk',
            startingDayOfWeek: StartingDayOfWeek.monday,
            pageAnimationEnabled: true,
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, dateTime, events) {
                return todoProvider.getCountTask(dateTime) > 0
                    ? Container(
                        alignment: Alignment.topRight,
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: const Color(0xFF757575),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            todoProvider.getCountTask(dateTime).toString(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Container();
              },
            ),
            calendarFormat: _format,
            focusedDay: _focusedDay,
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            calendarStyle: _getCalendarStyle(themeProvider),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onFormatChanged: (format) {
              if (_format != format) {
                setState(() {
                  _format = format;
                });
              }
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                DateAndTime.selectedDate = DateTime(
                    selectedDay.year, selectedDay.month, selectedDay.day);
                todoProvider.setup();
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
        );
      },
    );
  }
}
