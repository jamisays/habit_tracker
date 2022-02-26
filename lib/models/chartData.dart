import 'package:habit_tracker/models/events/eventSource.dart';
import 'package:hive/hive.dart';

import '../utils.dart';

class ChartData {
  ChartData(this.date, this.successRate);
  DateTime date;
  double successRate;
}

// List<ChartData> generateChartData() {
//   List<ChartData> chartData = [];
//   var firstDayOfMonth =
//       DateTime.utc(DateTime.now().year, DateTime.now().month, 1).day;
//   var currentDay = DateTime.now().day;
//   for (int i = firstDayOfMonth; i <= currentDay; i++) {
//     chartData.add(
//       ChartData(
//         DateTime.utc(DateTime.now().year, DateTime.now().month, i),
//         60.0 + i,
//       ),
//     );
//   }
//   return chartData;
// }

List<ChartData> generateChartData() {
  List<ChartData> chartData = [];
  var currentDay = DateTime.now();
  // var eventsData;
  // Hive.openBox('event_source').then((value) {
  var value = Hive.box<EventSource>('event_source');

  if (value.values.first.eventSource != null) {
    for (var i = currentDay;
        DateTime.now().difference(i).inDays < 7;
        i = i.subtract(Duration(days: 1))) {
      var x = 0.0;
      kEvents = value.values.first.eventSource!;
      var dayEvents = kEvents[DateTime.utc(i.year, i.month, i.day)];
      if (dayEvents != null) {
        dayEvents.forEach((element) {
          if (element.isDone) {
            x = x + 1.0;
          }
        });
        x = x / dayEvents.length;
        x = x * 100;
      }
      chartData.add(
        ChartData(
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
