import 'package:flutter/material.dart';
import 'package:habit_tracker/models/badHabit.dart';
import 'package:habit_tracker/providers/streams.dart';
import 'package:habit_tracker/screens/myBadHabitDetailScreen.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class MyBadHabitItem extends StatefulWidget {
  const MyBadHabitItem({
    Key? key,
    required this.badHabit,
    required this.deleteHt,
  }) : super(key: key);

  final BadHabit badHabit;
  final Function deleteHt;

  @override
  _MyBadHabitItemState createState() => _MyBadHabitItemState();
}

void selectBadHabit(BuildContext context, String id) {
  Navigator.of(context).pushNamed(
    MyBadHabitDetailScreen.routeName,
    arguments: id,
  );
}

class _MyBadHabitItemState extends State<MyBadHabitItem> {
  // for measuring progress of today for today's progress bar
  var _todaySeconds;
  void setTodaySeconds(var todaySeconds) {
    _todaySeconds = todaySeconds;
  }

  final _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  @override
  void initState() {
    if (!_stopWatchTimer.isRunning) {
      var days = DateTime.now().difference(widget.badHabit.lastDate).inDays;
      var seconds =
          DateTime.now().difference(widget.badHabit.lastDate).inSeconds;
      _stopWatchTimer.setPresetSecondTime(seconds);
      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
      var todaySeconds = seconds - (days * 86400);
      setTodaySeconds(todaySeconds);
      // ----------------- need to optimize ----------------
      // _stopWatchTimer.secondTime.listen((value) {
      // setTodaySeconds(todaySeconds);
      // print('secondTime $value');
      // });
      // ----------------- need to optimize ----------------
    }

    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
    print('Stopwatch disposed - item');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Provider.of<Streams>(context)
        .setStopwatchStreamValue(widget.badHabit.id, _stopWatchTimer);
    return InkWell(
      onTap: () => selectBadHabit(context, widget.badHabit.id),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(
            horizontal: size.height * .01, vertical: size.height * .01),
        child: ListTile(
          leading: CircularPercentIndicator(
            radius: size.height * .043,
            // fillColor: Colors.amber,
            progressColor: Colors.amber,
            // have to revert when validation logic is implemented
            percent: _todaySeconds > 0 ? _todaySeconds / 86400 : 0,
            center: CircleAvatar(
              backgroundColor: Colors.indigo.shade400,
              radius: size.height * .037,
              child: Text(
                '${(DateTime.now()).difference(widget.badHabit.lastDate).inDays}d',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: Theme.of(context).textTheme.headline6!.fontFamily,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          title: Text(
            widget.badHabit.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            '${DateFormat.yMMMd().format(widget.badHabit.createDate) + ' - today'}',
            // habits[index].difficultyLevel,
            // ),
          ),
          trailing: MediaQuery.of(context).size.width > 520
              ? TextButton.icon(
                  onPressed: () => widget.deleteHt(widget.badHabit.id),
                  label: const Text('Delete'),
                  icon: const Icon(Icons.delete),
                )
              : IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    widget.deleteHt(widget.badHabit.id);
                  },
                  color: Theme.of(context).errorColor,
                ),
        ),
      ),
    );
  }
}
