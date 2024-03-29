import 'package:flutter/material.dart';
import 'package:habit_tracker/dummy_data.dart';
import 'package:habit_tracker/models/category.dart';
import 'package:habit_tracker/providers/bad_habits.dart';
import 'package:habit_tracker/providers/good_habits.dart';
import 'package:habit_tracker/widgets/category_item.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CategoriesScreen extends StatelessWidget {
  static const routeName = '/categories_screen';

  List<Category>? displayedCategories;

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = routeArgs['id'];
    final categoryTitle = routeArgs['title'];

    if (categoryId != 'b') {
      displayedCategories = dummyCategories.where((category) {
        return category.id.startsWith('c');
      }).toList();
    } else {
      displayedCategories = dummyCategories.where((category) {
        return category.id.contains(categoryId!);
      }).toList();
    }

    return ChangeNotifierProvider(
      create: (ctx) => categoryId == 'b' ? BadHabits() : GoodHabits(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle!),
        ),
        body: GridView(
          padding: EdgeInsets.all(15),
          children: displayedCategories!
              .map((catData) => CategoryItem(
                    catData.id,
                    catData.title,
                    catData.color,
                  ))
              .toList(),
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
