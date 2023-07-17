import 'package:flutter/material.dart';

//----------------
//pageUI

class statistics_page extends StatefulWidget {
  const statistics_page({super.key});
  @override
  State<StatefulWidget> createState() => statistics_pageState();
}

class statistics_pageState extends State<statistics_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      children: [
        SizedBox(height: 40),
        ElevatedButton(
          child: const Text(
            "Setting 1",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () {
            //press [] button to
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          child: const Text(
            "Setting 2",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () {
            //press [] button to
          },
        ),
      ],
    ));
  }
}
