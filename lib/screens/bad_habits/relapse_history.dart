import 'package:flutter/material.dart';
import 'package:habit_tracker/models/bad_habits/badHabit.dart';
import 'package:habit_tracker/providers/bad_habits.dart';
import 'package:habit_tracker/screens/bad_habits/relapse_item.dart';
import 'package:provider/provider.dart';

class RelapseHistory extends StatefulWidget {
  const RelapseHistory({Key? key}) : super(key: key);
  static const routeName = '/bad_habit_relapse_history';

  @override
  _RelapseHistoryState createState() => _RelapseHistoryState();
}

class _RelapseHistoryState extends State<RelapseHistory> {
  var _isInit = true;
  late BadHabit habit;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final habitId = ModalRoute.of(context)!.settings.arguments as String;

      habit = Provider.of<BadHabits>(context, listen: false)
          .badItems
          .firstWhere((habit) => habit.id == habitId);
      _isInit = false;
      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relapse History'),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: habit.relapsedDaysList.length,
            reverse: true,
            itemBuilder: (context, index) {
              return RelapseItem(
                index,
                habit,
              );
            },
          ),
        ),
      ),
    );
  }
}
