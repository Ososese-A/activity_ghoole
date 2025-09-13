import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_ghoole/styles/app_colors.dart';

Widget calendarComponent ({required List<DateTime> months}) {
  return Column(
    children: months.map((month) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat.yMMMM().format(month),
            style: const TextStyle(
              color: AppColors.secWhite,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),

          const SizedBox(height: 12.0,),

          //calendar month grid goes here
          _calendarMonthGrid(month: month),

          const SizedBox(height: 32.0,)
        ],
      );
    }).toList(),
  );
}

Widget _calendarMonthGrid ({required DateTime month}) {

  final lastDay = DateTime(month.year, month.month + 1, 0);
  final firstDay = DateTime(month.year, month.month, 1);
  final daysInMonth  = lastDay.day;

  final Map<int, int> weekdayToColumn ={
    DateTime.monday: 0,
    DateTime.tuesday: 1,
    DateTime.wednesday: 2,
    DateTime.thursday: 3,
    DateTime.friday: 4,
    DateTime.saturday: 5,
    DateTime.sunday: 6,
  };

  //create a coulmn for each weekday
  List<List<Widget>> columns = List.generate(7, (_) => []);

  // calculate how many emptycells to add before the first day
  int startWeekday = firstDay.weekday;
  int startColumnIndex = weekdayToColumn[startWeekday]!;

  //add the empty cells to all the columns before the first day
  for (int i=0; i < startColumnIndex; i++) {
    // columns[i].add(const SizedBox(height: 40.0,));
    columns[i].add(_calendarPlaceholderCell());
  }

  // for (int i = 1; i < firstDay.weekday; i++) {
  //   final columnIndex = weekdayToColumn[i]!;
  //   columns[columnIndex].add(const SizedBox(height: 40.0,));
  // }

  // fiil in the actual days
  for (int day = 1; day <= daysInMonth; day++) {
    final date = DateTime(month.year, month.month, day);
    final columnIndex = weekdayToColumn[date.weekday]!;
    columns[columnIndex].add(_calendarCell(day: day));
  }

  // reverse each column
  for (int i = 0; i < columns.length; i++) {
    columns[i] = columns[i].reversed.toList();
  }

  final weeekdayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: List.generate(7, (index) {
      // final weeekdayLabel = DateFormat.E().format(
      //   DateTime(2025, 9, DateTime.monday + index),
      // );

      return Expanded(
        child: Column(
          children: [
            Text(
              weeekdayLabels[index],
              style: const TextStyle(
                color: AppColors.secWhite,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 8),
            ...columns[index],
          ],
        )
      );
    }),
  );
}

Widget _calendarCell ({required int day}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: AppColors.priBrown,
      borderRadius: BorderRadius.circular(2),
      border: Border.all(color: AppColors.secBrown),
    ),
    child: Center(
      child: Text(
        "$day",
        style: const TextStyle(
          color: AppColors.secWhite,
          fontWeight: FontWeight.w600
        ),
      ),
    ),
  );
}

Widget _calendarPlaceholderCell() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: AppColors.secBrown.withOpacity(0.2), // subtle contrast
      borderRadius: BorderRadius.circular(2),
      border: Border.all(color: AppColors.secBrown.withOpacity(0.4)),
    ),
    child: const Center(
      child: Text(
        "",
        style: TextStyle(
          color: AppColors.secWhite,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}