import 'package:flutter/cupertino.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Streams with ChangeNotifier {
  late StopWatchTimer? stopwatchStream;
  Map<String, StopWatchTimer> stopwatchStreamList = {};

  void setStopwatchStreamValue(String id, StopWatchTimer itemStopwatch) {
    stopwatchStreamList[id] = itemStopwatch;
    // print(stopwatchStreamList[id]);
    // print(stopwatchStreamList![id]);
    // notifyListeners();
    // stopwatchStreamList!.putIfAbsent(id, () => itemStopwatch);
  }

  void disposeBadItemScream(String id) {
    stopwatchStreamList[id] = null as StopWatchTimer;
  }
}
