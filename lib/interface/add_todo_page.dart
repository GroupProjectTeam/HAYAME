import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hayame/interface/add_task_page.dart';
import 'package:hayame/interface/add_appointment_page.dart';

DateTime select_date = DateTime(2023, 7, 4, 8, 00);

//----------------
//pageUI

class add_todo_page extends StatefulWidget {
  const add_todo_page({super.key});
  @override
  State<StatefulWidget> createState() => add_todo_pageState();
}

class add_todo_pageState extends State<add_todo_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("Add Todo"),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            SizedBox(height: 80),
            ElevatedButton(
              child: const Text(
                "Appointment",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => add_appointment_page()),
                ); //press [Appointment] button to add_appointment_page
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: const Text(
                "Task",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => add_task_page()),
                ); //press [Task] button to add_task_page
              },
            ),
          ],
        ));
  }
}
