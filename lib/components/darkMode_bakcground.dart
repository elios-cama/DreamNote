import 'package:flutter/material.dart';
class DarkMode_Widget extends StatelessWidget {
  const DarkMode_Widget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
        "lib/assets/black_theme.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      );
  }
}

