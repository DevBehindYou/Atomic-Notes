import 'package:flutter/material.dart';

class Intro5 extends StatelessWidget {
  const Intro5({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff323130),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("assets/intro5.png"),
            ),
          ),
        ],
      ),
    );
  }
}
