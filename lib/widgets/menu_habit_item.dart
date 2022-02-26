import 'package:flutter/material.dart';
import '../screens/add_habits/menu_habit_details_screen.dart';

class MenuHabitItem extends StatelessWidget {
  final String id;
  final String title;
  final String difficulty;
  final Function removeItem;

  MenuHabitItem({
    required this.id,
    required this.title,
    required this.difficulty,
    required this.removeItem,
  });

  // String get difficultyText {
  //   switch (difficulty) {
  //     case Difficulty.Easy:
  //       return 'Easy';
  //     case Difficulty.Medium:
  //       return 'Medium';
  //     case Difficulty.Hard:
  //       return 'Hard';
  //     default:
  //       return 'Unknown';
  //   }
  // }

  void selectHabit(BuildContext context) {
    Navigator.of(context).pushNamed(
      MenuHabitDetailsScreen.routeName,
      arguments: id,
    );
    //     .then((result) {
    //   if (result != null) {
    //     removeItem(result);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    // final habitsData = Provider.of<Habits>(context);
    return InkWell(
      onTap: () => selectHabit(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.asset(
                    'assets/images/habit-cover-images/cat-fit-1.jpg',
                    fit: BoxFit.cover, // for FITTING into the box
                    height: 170,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 5,
                  child: Container(
                    width: 270,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            // bottom row begin
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(
                        width: 6,
                      ),
                      Text('$title'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work),
                      SizedBox(
                        width: 6,
                      ),
                      Text(difficulty),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.accessibility_rounded),
                    tooltip: 'Add',
                    onPressed: () {},
                  ),
                  // Row(
                  //   children: [
                  //     ,
                  //     SizedBox(
                  //       width: 6,
                  //     ),
                  //     Text('New'),
                  //   ],
                  // ),
                ],
              ),
            ),
            // bottom row end
          ],
        ),
      ),
    );
  }
}
