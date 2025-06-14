import 'package:flutter/material.dart';

class LogoContainer extends StatelessWidget {
  const LogoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 75,
          width: 180,
          decoration: BoxDecoration(
            color: const Color(0xff323130),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 55,
                child: Image.asset("assets/logo_x.png"),
              ),
              RichText(
                text: TextSpan(
                  text: 'Atomic',
                  style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 26,
                      overflow: TextOverflow.ellipsis),
                  children: <TextSpan>[
                    TextSpan(
                        text: "\nNotes",
                        style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 13,
                            overflow: TextOverflow.ellipsis)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "| Always\n| Encrypted\n| and Synchronized",
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
