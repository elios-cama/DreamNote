
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LittlePurpleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onpress;
  const LittlePurpleButton({
    Key? key, this.icon = FontAwesomeIcons.user,required this.onpress, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF7F5FFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Icon(
          icon,
          size: 15,
        ),
        onPressed: onpress,
      ),
    );
  }
}
