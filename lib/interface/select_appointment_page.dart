import 'package:flutter/material.dart';
import 'package:hayame/database.dart' as db;
import 'package:hayame/database_function.dart';

//----------------
//buttonUI

void delete_apointment_buttonUI(id) {
  delete_appointment(id);
  print(db.appointment_DB);
}

//----------------
//fromUI

final real_duration_controller = TextEditingController();

//----------------
//pageUI

class select_appointment_page extends StatefulWidget {
  const select_appointment_page({super.key});
  @override
  State<StatefulWidget> createState() => select_appointment_pageState();
}

class select_appointment_pageState extends State<select_appointment_page> {
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
          title: const Text("select_appointment_page"),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            const SizedBox(height: 40),
            ElevatedButton(
              child: const Text(
                "Delete",
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
              onPressed: () {
                print(db.todo_select);
                delete_apointment_buttonUI(db.todo_select);
                Navigator.pop(context);
              }, //press [Delete] button
            ),
          ],
        ));
  }
}
