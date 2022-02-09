import 'package:flutter/material.dart';
import 'package:habit_tracker/models/goodHabit.dart';
import 'package:habit_tracker/widgets/menu_habit_item.dart';
import '../dummy_data.dart';

class CategoryHabitsScreen extends StatefulWidget {
  static const routeName = '/category-habits';

  @override
  _CategoryHabitsScreenState createState() => _CategoryHabitsScreenState();
}

class _CategoryHabitsScreenState extends State<CategoryHabitsScreen> {
  String? categoryTitle;
  List<GoodHabit>? displayedHabits;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = routeArgs['id'];
    categoryTitle = routeArgs['title'];
    displayedHabits = dummyHabits.where((habit) {
      return habit.category!.contains(categoryId!);
    }).toList();
    super.didChangeDependencies();
  }

  void _removeHabit(String habitId) {
    setState(() {
      displayedHabits!.removeWhere((habit) => habit.id == habitId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MenuHabitItem(
            id: displayedHabits![index].id,
            title: displayedHabits![index].title,
            difficulty: displayedHabits![index].difficultyLevel!,
            removeItem: _removeHabit,
          );
        },
        itemCount: displayedHabits!.length,
      ),
      // body: ListView(
      //   children: categoryHabits.map((e) {
      //   return Card(),
      // })),   // only 'Listview'
    );
  }
}
