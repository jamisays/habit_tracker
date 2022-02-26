import 'package:flutter/material.dart';
import 'package:habit_tracker/screens/statistics_screen.dart';
import 'package:habit_tracker/screens/add_habits/type_screen.dart';
import 'package:habit_tracker/widgets/main_drawer.dart';
import 'calendar_screen/calendar_screen.dart';
import 'my_habits_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {'page': CalendarScreen(), 'title': 'Home'},
    {'page': MyHabitsScreen(), 'title': 'My Habits'},
    {'page': TypeScreen(), 'title': 'Habit Type'},
    {'page': StatisticsScreen(), 'title': 'Statistics'},
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'].toString()),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        // backgroundColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).primaryColor,
        fixedColor: Colors.blueAccent,
        unselectedItemColor: Theme.of(context).primaryColor,
        // selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'My Habits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Add Habits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}
