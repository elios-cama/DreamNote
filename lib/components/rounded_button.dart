import 'package:flutter/material.dart';

class RoundedPurpleButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  const RoundedPurpleButton({
    Key? key,
    this.text = '',
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size  = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8, 
      margin: EdgeInsets.symmetric(vertical: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Color(0xFF8942F2),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
            padding: EdgeInsets.all(17)),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}