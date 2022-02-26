import 'package:flutter/material.dart';
import 'package:habit_tracker/providers/bad_habits.dart';
import 'package:habit_tracker/providers/good_habits.dart';

import 'package:habit_tracker/widgets/bad_habits/my_bad_habit_list.dart';
import 'package:habit_tracker/widgets/good_habits/my_good_habit_list.dart';
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
    final goodHabitsData = Provider.of<GoodHabits>(context);
    final badHabitsData = Provider.of<BadHabits>(context);
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
          MyGoodHabitList(goodHabitsData.deleteGoodHabit),
          MyBadHabitList(badHabitsData.deleteBadHabit),
        ]),
        // MyHabitList(goodHabits, badHabits, habitsData.deleteHabit),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () =>
              goodHabitsData.startAddNewGoodHabit(context, true, 'null'),
        ),
      ),
    );
  }
}
