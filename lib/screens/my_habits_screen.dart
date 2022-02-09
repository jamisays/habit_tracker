import 'package:flutter/material.dart';

import 'package:habit_tracker/providers/habits.dart';
import 'package:habit_tracker/widgets/my_bad_habit_list.dart';
import 'package:habit_tracker/widgets/my_good_habit_list.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class MyHabitsScreen extends StatefulWidget {
  @override
  _MyHabitsScreenState createState() => _MyHabitsScreenState();
}

class _MyHabitsScreenState extends State<MyHabitsScreen> {
  @override
  Widget build(BuildContext context) {
    // MyHabitList(this.habits, _deleteHabit);
    final habitsData = Provider.of<Habits>(context);
    // final goodHabits = habitsData.goodItems;
    // final badHabits = habitsData.badItems;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 5,
          bottom: TabBar(
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.redAccent,
            ),
            tabs: [
              Tab(
                text: 'Good',
              ),
              Tab(
                text: 'Bad',
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          MyGoodHabitList(habitsData.deleteGoodHabit),
          MyBadHabitList(habitsData.deleteBadHabit),
        ]),
        // MyHabitList(goodHabits, badHabits, habitsData.deleteHabit),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () =>
              habitsData.startAddNewGoodHabit(context, true, 'null'),
        ),
      ),
    );
  }
}
