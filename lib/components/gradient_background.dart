import 'package:flutter/material.dart';
class Gradient_WIdget extends StatelessWidget {
  const Gradient_WIdget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
        "lib/assets/gradient.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      );
  }
}
