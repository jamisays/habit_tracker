import 'package:flutter/material.dart';
import 'package:habit_tracker/providers/bad_habits.dart';
import 'package:habit_tracker/providers/good_habits.dart';
import 'package:habit_tracker/screens/add_habits/type_item_screen.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class TypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) {
        GoodHabits();
        BadHabits();
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Categories'),
        // ),
        body: GridView(
          padding: EdgeInsets.all(15),
          children: [
            TypeItemScreen('g', 'Good Habits', Colors.orange),
            TypeItemScreen('b', 'Bad Habits', Colors.deepOrangeAccent),
          ],
          //     .map((catData) => CategoryItem(
          //           catData.id,
          //           catData.title,
          //           catData.color,
          //         ))
          //     .toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
        ),
      ),
    );
  }
}
