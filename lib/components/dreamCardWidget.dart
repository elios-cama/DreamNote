// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:dreamnote/model/dream_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];


class DreamCardWidget extends StatelessWidget {
  DreamCardWidget({
    Key? key,
    required this.dream,
    required this.index,
  }) : super(key: key);

  final DreamModel dream;
  final int index;

  @override
  Widget build(BuildContext context) {
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd().format(dream.time);
    final minHeight = getMinHeight(index);

    return Container(
      padding: EdgeInsets.all(10),
      height: 150,
      width: 150,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage("lib/assets/guardian.png")),
                    
                SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dream.category,
                        style: TextStyle(color: Color(0xFF7F5FFF), fontSize: 15)),
                    Text(
                      time,
                      style: TextStyle(fontSize: 9),
                    )
                  ],
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 3),
              child: Text(dream.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),),
              ),
            Text(
                dream.description,
                style: TextStyle(fontSize: 11,),
                overflow: TextOverflow.fade,
                softWrap: true,
                )
          ],
        ),
      ),
    );
  }
}



 double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
