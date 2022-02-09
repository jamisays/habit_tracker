import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RelapseItem extends StatelessWidget {
  // const RelapseItem({Key? key}) : super(key: key);
  final index;
  final habit;
  // final time;

  Widget get getDuration {
    // if index is zero, returns date difference from create date to first index
    // date, that means first relapse date, else return difference from
    // previous index to next index relapse date
    return Text(index > 0
        ? DateFormat.yMd().add_jm().format(habit.relapsedDaysList[index - 1]) +
            ' - ' +
            DateFormat.yMd().add_jm().format(habit.relapsedDaysList[index])
        : DateFormat.yMd().add_jm().format(habit.createDate) +
            ' - ' +
            DateFormat.yMd().add_jm().format(habit.relapsedDaysList[index]));
  }

  Widget get getStreak {
    return Text((index > 0
            ? habit.relapsedDaysList[index]
                .difference(habit.relapsedDaysList[index - 1])
            : habit.relapsedDaysList[index].difference(habit.createDate))
        .toString());
  }

  // var days;
  // var hours;
  // var minutes;

  RelapseItem(this.index, this.habit);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: getDuration,
      trailing: getStreak,
      subtitle:
          Text(habit.relapsedReasons[habit.relapsedDaysList[index]].toString()),
    );
  }
}
