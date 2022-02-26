import 'package:flutter/material.dart';
import 'package:habit_tracker/screens/add_habits/categories_screen.dart';
import 'package:habit_tracker/screens/add_habits/category_habits_screen.dart';

class TypeItemScreen extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  TypeItemScreen(this.id, this.title, this.color);

  void selectType(BuildContext ctx) {
    id == 'b'
        ? Navigator.of(ctx).pushNamed(
            CategoryHabitsScreen.routeName,
            arguments: {
              'id': id,
              'title': title,
            },
          )
        : Navigator.of(ctx).pushNamed(
            CategoriesScreen.routeName,
            arguments: {
              'id': id,
              'title': title,
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectType(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
