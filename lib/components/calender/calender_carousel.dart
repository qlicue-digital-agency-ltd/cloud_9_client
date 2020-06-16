import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarCarouselCard extends StatefulWidget {
  @override
  _CalendarCarouselCardState createState() => _CalendarCarouselCardState();
}

class _CalendarCarouselCardState extends State<CalendarCarouselCard> {
  CalendarController _calendarController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'en_US',
      events: _selectedDay,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.none,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      calendarStyle: CalendarStyle(
        weekdayStyle: TextStyle(color: Colors.white),
        weekendStyle: TextStyle(color: Colors.white),
        outsideStyle: TextStyle(color: Colors.grey),
        unavailableStyle: TextStyle(color: Colors.black),
        outsideWeekendStyle: TextStyle(color: Colors.grey),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        dowTextBuilder: (date, locale) {
          return DateFormat.E(locale)
              .format(date)
              .substring(0, 3)
              .toUpperCase();
        },
        weekdayStyle: TextStyle(color: Colors.white),
        weekendStyle: TextStyle(color: Colors.white),
      ),
      headerVisible: true,
      
      headerStyle: HeaderStyle(
        titleTextStyle: TextStyle(fontSize:30, color:Colors.white),
        formatButtonDecoration: BoxDecoration(
          color: Colors.red,
          
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      builders: CalendarBuilders(
        markersBuilder: (context, date, events, holidays) {
          return [
            Container(
              decoration: new BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              margin: const EdgeInsets.all(4.0),
              width: 4,
              height: 4,
            )
          ];
        },
        selectedDayBuilder: (context, date, _) {
          return Container(
            decoration: new BoxDecoration(
              color: Colors.deepOrange,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.all(4.0),
            width: 100,
            height: 100,
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
      calendarController: _calendarController,
    );
  }

  final Map<DateTime, List> _selectedDay = {
    DateTime(2019, 4, 3): ['Selected Day in the calendar!'],
    DateTime(2019, 4, 5): ['Selected Day in the calendar!'],
    DateTime(2019, 4, 22): ['Selected Day in the calendar!'],
    DateTime(2019, 4, 24): ['Selected Day in the calendar!'],
    DateTime(2019, 4, 26): ['Selected Day in the calendar!'],
  };
}
