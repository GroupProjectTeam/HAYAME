import 'package:flutter/material.dart';
import 'package:hayame/database.dart' as db;
import 'package:hayame/database_function.dart';
import 'package:hayame/database_read_load.dart';

TaskDataController taskDataController = TaskDataController();
AppointmentDataController appointmentDataController =
    AppointmentDataController();

final INTERVAL_TIME_controller = TextEditingController(text: '10');
final RESTING_START_TIME_controller = TextEditingController(text: '22');
final RESTING_END_TIME_controller = TextEditingController(text: '8');

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
            const SizedBox(height: 40),
            TextField(
              controller: INTERVAL_TIME_controller,
              decoration: const InputDecoration(
                filled: true,
                labelText: "Interval time (minutes)",
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: RESTING_END_TIME_controller,
              decoration: const InputDecoration(
                filled: true,
                labelText: "time to get up (hour)",
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: RESTING_START_TIME_controller,
              decoration: const InputDecoration(
                filled: true,
                labelText: "time to sleep (hour)",
              ),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              child: const Text(
                "Set",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                setState(() {
                  db.INTERVAL_TIME = int.parse(INTERVAL_TIME_controller.text);
                  db.RESTING_START_TIME =
                      int.parse(RESTING_START_TIME_controller.text);
                  db.RESTING_END_TIME =
                      int.parse(RESTING_END_TIME_controller.text);
                });
              },
            ), //press [Set] button
            const SizedBox(height: 40),
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
            const SizedBox(height: 20),
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
            const SizedBox(height: 40),
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
