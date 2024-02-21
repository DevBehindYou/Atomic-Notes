// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Intro1 extends StatelessWidget {
  const Intro1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff323130),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("assets/intro1.png"),
            ),
          ),
        ],
      ),
    );
  }
}
