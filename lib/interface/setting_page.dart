import 'package:flutter/material.dart';
import 'package:hayame/database.dart' as db;
import 'package:hayame/database_function.dart';
import 'package:hayame/database_read_load.dart';

TaskDataController taskDataController = TaskDataController();
AppointmentDataController appointmentDataController =
    AppointmentDataController();

//----------------
//pageUI

class setting_page extends StatefulWidget {
  const setting_page({super.key});
  @override
  State<StatefulWidget> createState() => setting_pageState();
}

class setting_pageState extends State<setting_page> {
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
          title: const Text("Setting"),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            SizedBox(height: 40),
            ElevatedButton(
              child: const Text(
                "Delete all appointments",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                all_delete_appointment();
                print(db.appointment_DB);
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: const Text(
                "Delete all tasks",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                all_delete_task();
                print(db.task_DB);
              },
            ),
            // SizedBox(height: 20),
            // ElevatedButton(
            //   child: const Text(
            //     "setting 3",
            //     style: TextStyle(fontSize: 20),
            //   ),
            //   onPressed: () async {
            //     //
            //     print("1111");
            //     await appointmentDataController.setInitialSharedPrefrences();
            //     print("2222");
            //   },
            // ),
          ],
        ));
  }
}
