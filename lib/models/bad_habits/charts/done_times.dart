import 'package:habit_tracker/models/eventSource.dart';
import 'package:habit_tracker/models/goodHabit.dart';
import 'package:habit_tracker/utils.dart';
import 'package:hive/hive.dart';

class DoneTimes {
  DoneTimes(this.date, this.doneTimes);
  DateTime date;
  int doneTimes;
}

List<DoneTimes> getChartData(GoodHabit selectedHabit) {
  List<DoneTimes> chartData = [];
  var currentDay = DateTime.now();
  // var eventsData;
  // Hive.openBox('event_source').then((value) {
  var value = Hive.box<EventSource>('event_source');

  if (value.values.first.eventSource != null) {
    for (var i = currentDay;
        DateTime.now().difference(i).inDays < 7;
        i = i.subtract(Duration(days: 1))) {
      var x = 0;
      kEvents = value.values.first.eventSource!;
      var dayEvents = kEvents[DateTime.utc(i.year, i.month, i.day)];
      if (dayEvents != null) {
        dayEvents.forEach((element) {
          if (element.title == selectedHabit.title) {
            x = x + element.doneTimes;
          }
        });
      }
      chartData.add(
        DoneTimes(
          DateTime.utc(i.year, i.month, i.day),
          x,
        ),
      );
    }
  }
  // ignore: unnecessary_null_comparison

  return chartData;
  // });
}
