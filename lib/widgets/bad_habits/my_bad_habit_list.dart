import "package:flutter/material.dart";
// import 'package:habit_tracker/models/badHabit.dart';
import 'package:habit_tracker/providers/habits.dart';
import 'package:habit_tracker/widgets/bad_habits/my_bad_habit_item.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class MyBadHabitList extends StatelessWidget {
  // final List<BadHabit> badHabits;
  final Function deleteHt;

  MyBadHabitList(this.deleteHt);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:
            Provider.of<Habits>(context, listen: false).fetchAndSetBadHabits(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Habits>(
                child: Center(
                  child: const Text('No habits yet added'),
                ),
                builder: (ctx, badHabits, ch) => badHabits.badItems.length <= 0
                    ? ch!
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return MyBadHabitItem(
                            key: ValueKey(badHabits.badItems[index].id),
                            badHabit: badHabits.badItems[index],
                            deleteHt: deleteHt,
                          );
                        },
                        itemCount: badHabits.badItems.length,
                      ),
              ),
      ),
    );
  }
}
