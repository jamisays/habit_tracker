import 'package:flutter/material.dart';
import 'package:habit_tracker/providers/auth.dart';
import 'package:habit_tracker/screens/filters_screen.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  Widget _buildDrawerItems(String title, IconData icon, Function? tapHandler) {
    return ListTile(
      leading: Icon(
        Icons.handyman_sharp,
        size: 25,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Habits',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildDrawerItems('Habits', Icons.handyman_sharp, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          _buildDrawerItems('Filter', Icons.hail, () {
            Navigator.of(context).pushReplacementNamed(FilterScreen.routeName);
          }),
          _buildDrawerItems('Logout', Icons.logout, () {
            Provider.of<Auth>(context, listen: false).logout();
            // Navigator.of(context).pushReplacementNamed('/');
          }),
        ],
      ),
    );
  }
}
