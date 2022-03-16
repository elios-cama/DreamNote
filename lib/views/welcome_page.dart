// ignore_for_file: prefer_const_constructors

import 'package:dreamnote/components/delayed_animation.dart';
import 'package:dreamnote/components/rounded_button.dart';
import 'package:dreamnote/views/home_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/gradient.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            DelayedAnimation(
              delay: 1500,
              child: Container(
                margin: EdgeInsets.only(top: 150),
                height: 250,
                child: Image.asset('lib/assets/logo_dr.png'),
              ),
            ),
            
            DelayedAnimation(
              delay: 2500,
              child: RoundedPurpleButton(
                text: 'Se connecter',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}