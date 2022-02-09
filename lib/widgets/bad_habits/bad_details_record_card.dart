import 'package:flutter/material.dart';

class RecordCard extends StatelessWidget {
  // const RecordCard({Key? key}) : super(key: key);
  final days;
  final footarText;
  final icon;

  RecordCard(this.days, this.footarText, this.icon);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.amber.shade100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          Text(
            days.toString(),
            style: TextStyle(
              fontSize: size.height * .06,
              fontFamily: 'Helvetica',
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Best Streak',
            style: TextStyle(
              fontSize: size.height * .025,
              fontFamily: 'Helvetica',
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
