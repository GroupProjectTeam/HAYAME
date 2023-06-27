import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scheduling_app/database_read_load.dart';
import 'package:scheduling_app/model/appointment_model.dart';
import 'package:scheduling_app/model/task_model.dart';

import 'database.dart' as db;

void add_task(String titleFromUI, DateTime deadlineFromUI, int durationFromUI) {
  int newTaskID = TaskDataController.currentID + 1;
  TaskDataController.currentID = newTaskID;
  var newTask = TaskModel(
      id: newTaskID,
      title: titleFromUI,
      deadline: deadlineFromUI,
      duration: durationFromUI,
      realDuration: 0,
      ifDone: false);
  db.task_DB.add(newTask);
}

void delete_task(int taskIdFromUi) {
  for (int i = 0; i < db.task_DB.length; i++) {
    if (db.task_DB[i].id == taskIdFromUi) {
      db.task_DB.remove(i);
      return;
    }
  }
  debugPrint("The ID isn't found...");
}

void done_task(int taskIdFromUi, int realDurationFromUi) {
  for (int i = 0; i < db.task_DB.length; i++) {
    if (db.task_DB[i].id == taskIdFromUi) {
      db.task_DB[i].duration = realDurationFromUi;
      db.task_DB[i].ifDone = true;
      return;
    }
  }
  debugPrint("The ID isn't found...");
}

void change_task(int taskIdFromUi, TaskModel newtaskFromUi) {
  for (int i = 0; i < db.task_DB.length; i++) {
    if (db.task_DB[i].id == taskIdFromUi) {
      db.task_DB.remove(i);
      db.task_DB.insert(i, newtaskFromUi);
      return;
    }
  }
  debugPrint("The ID isn't found...");
}

void add_appointment(
    String titleFromUI, DateTime beginTimeFromUI, DateTime endTimeFromUI) {
  int newAppointmentID = AppointmentDataController.currentID + 1;
  AppointmentDataController.currentID = newAppointmentID;
  var newAppointment = AppointmentModel(
      id: newAppointmentID,
      title: titleFromUI,
      beginTime: beginTimeFromUI,
      endTime: endTimeFromUI);
  db.appointment_DB.add(newAppointment);
}

void delete_appointment(int appointmentIdFromUi) {
  for (int i = 0; i < db.appointment_DB.length; i++) {
    if (db.appointment_DB[i].id == appointmentIdFromUi) {
      db.appointment_DB.remove(i);
      return;
    }
  }
  debugPrint("The ID isn't found...");
}

void change_appointment(
    int appointmentIdFromUi, AppointmentModel newAppointmentFromUi) {
  for (int i = 0; i < db.appointment_DB.length; i++) {
    if (db.appointment_DB[i].id == appointmentIdFromUi) {
      db.appointment_DB.remove(i);
      db.appointment_DB.insert(i, newAppointmentFromUi);
      return;
    }
  }
  debugPrint("The ID isn't found...");
}

// Future<void> save_to_csv(var database, String name) async {
//   if (await Permission.storage.request().isGranted) {
//     String dir = "${(await getExternalStorageDirectory())!.path}/$name.csv";
//     String file = dir;
//     File f = File(file);
//     String csv = const ListToCsvConverter().convert(database);
//     f.writeAsString(csv);
//   } else {
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.storage,
//     ].request();
//   }
// }
