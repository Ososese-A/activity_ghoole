import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:project_ghoole/styles/app_colors.dart';

Widget calendarBuilder () {
  DateTime month = DateTime(2025, 6);

  List<String> completedDates = [
    '2025-09-02',
    '2025-09-05',
    '2025-09-07',
    '2025-09-11',
    '2025-08-22',
    '2025-08-17',
    '2025-07-01'
  ];

  List<DateTime> parsedDates = completedDates.map((dt) => DateTime.parse(dt)).toList();

//check if the current number of months 
  DateTime currentDate = DateTime.now();
  int interim = month.month - currentDate.month - 1;
  int noOfMonths = interim.abs();
  List<Widget> calendar = [];

  for (int i = noOfMonths - 1; i >= 0; i--) {
    final indexDate = DateTime( currentDate.month > month.month ? month.year : currentDate.year, month.month + i);
  final firstDay = DateTime(indexDate.year, indexDate.month, 1);
  final lastDay = DateTime(indexDate.year, indexDate.month + 1, 0);
  final daysToSkip = 6 - (firstDay.weekday - 7).abs();
  final daysInMonth = lastDay.day;
  final gridDate = DateFormat.yMMMM().format(indexDate);
  List<String> weedayLabels = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
  List<Widget> days = [];
  List<Widget> daysInterim = [];
  days.addAll(List.generate(weedayLabels.length, (i) =>  Text(weedayLabels[i], style: TextStyle(color: AppColors.priWhite),)));
  days.addAll(List.generate(daysToSkip, (_) => _emptyCell()));
  daysInterim.addAll(List.generate(daysInMonth, (i) {
    final isActive = parsedDates.any((dt) => dt.year == indexDate.year && dt.month == indexDate.month && dt.day == i + 1);
    //  _normalCell(day: i + 1);

    return isActive ? _activeCell(day: i + 1) : _normalCell(day: i + 1);
  }));
  days.addAll(daysInterim);
  calendar.add(Text(gridDate, style: TextStyle(color: AppColors.priWhite)));
  calendar.add(GridView.count(
        crossAxisCount: 7,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 24.0,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: days,
      ));
  }

  return Column(
    children: calendar,
  );
}


Widget _emptyCell () {
  return Container(
    height: 35.0,
    width: 32.0,
    decoration: BoxDecoration(
      color: AppColors.secBrown,
      border: Border.all(
        width: 1.0,
        color: AppColors.priBrown
      ),
      borderRadius: BorderRadius.circular(4.0)
    ),
    child: Text(" "),
  );
}

Widget _activeCell ({required int day}) {
  return Container(
    height: 35.0,
    width: 32.0,
    decoration: BoxDecoration(
      color: AppColors.priWhite,
      borderRadius: BorderRadius.circular(4.0)
    ),
    child: Center(
      child: Text(
        "$day",
        style: TextStyle(
          color: AppColors.secBrown,
          fontWeight: FontWeight.w600
        ),
      ),
    ),
  );
}

Widget _normalCell ({required int day}) {
  return Container(
    height: 35.0,
    width: 32.0,
    decoration: BoxDecoration(
      color: AppColors.priBrown,
      borderRadius: BorderRadius.circular(4.0)
    ),
    child: Center(
      child: Text(
        "$day",
        style: TextStyle(
          color: AppColors.priWhite
        ),
      ),
    ),
  );
}