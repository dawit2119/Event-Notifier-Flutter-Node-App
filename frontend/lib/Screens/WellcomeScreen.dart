import 'dart:async';

import 'package:flutter/material.dart';

class WellcomeScreen extends StatelessWidget {
  const WellcomeScreen({Key? key}) : super(key: key);
  static const String routeName = "/wellcome";
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4), () => Navigator.pushNamed(context, '/'));
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/welcomepage.jpg"),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: Center(
          child: Container(
            height: MediaQuery.of(context).size.width/3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.blueGrey,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Text(
                    "Hollyplace Scheduler ",
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 40,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'app',
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
        ),
    );
  }
}
