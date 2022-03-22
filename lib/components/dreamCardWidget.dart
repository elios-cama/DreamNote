// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:dreamnote/model/dream_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

final _lightColors = [
  Color(0xFFA3F7B5),
  Color(0xFFC2BBF0),
  Color(0xFFF7A072),
  Color(0xFFC6E2E9),
  Color(0xFFB5E2FA),
  Color(0xFFE3DC95),
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
    late IconData avatar;
    if(dream.category =="friends"){avatar = Icons.group_outlined;}
    else if
    (dream.category =="Friends"){avatar = Icons.group_outlined;}
    else
    if(dream.category =="Love"){avatar = FontAwesomeIcons.userFriends;}
    else
    if(dream.category =="love"){avatar = Icons.favorite_border_outlined;}
    else
    if(dream.category =="Girlfriend"){avatar = Icons.favorite_border_outlined;}
    else
    if(dream.category =="Boyfriend"){avatar = Icons.favorite_border_outlined;}
    else{avatar = Icons.cloud_queue;}
    return Container(
      padding: EdgeInsets.all(10),
      height: 150,
      width: 150,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                /*CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage("lib/assets/white.png")),*/
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Center(child:Icon(avatar, size: 20,color: Colors.black,)),
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dream.category,
                        style:
                            TextStyle(color: Color(0xFF7F5FFF), fontSize: 15)),
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
              child: Text(
                dream.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
            Text(
              dream.description,
              style: TextStyle(
                fontSize: 11,
              ),
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
