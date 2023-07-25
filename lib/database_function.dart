import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'database.dart' as db;
import 'package:hayame/model/task_model.dart';
import 'package:hayame/model/appointment_model.dart';

import 'database_read_load.dart';

TaskDataController taskDataController = TaskDataController();
AppointmentDataController appointmentDataController =
    AppointmentDataController();

// ランダムに数字生成.
int randomIntWithRange(int min, int max) {
  int value = math.Random().nextInt(max - min);
  return value + min;
}

// task_DBに同じIDがあるか判定.
bool judge_task_id(int targetId) {
  for (int i = 0; i < db.task_DB.length; i++) {
    if (db.task_DB[i].id == targetId) {
      return false;
    }
  }
  return true;
}

// appointment_DBに同じIDがあるか判定.
bool judge_appointment_id(int targetId) {
  for (int i = 0; i < db.appointment_DB.length; i++) {
    if (db.appointment_DB[i].id == targetId) {
      return false;
    }
  }
  return true;
}

// task追加.
void add_task(String titleFromUI, DateTime deadlineFromUI, int durationFromUI) {
  int newTaskID = randomIntWithRange(10000, 99999);
  while (!judge_task_id(newTaskID)) {
    int newTaskID = randomIntWithRange(10000, 99999);
  }
  var newTask = TaskModel(
      id: newTaskID,
      title: titleFromUI,
      deadline: deadlineFromUI,
      duration: durationFromUI,
      realDuration: 0,
      ifDone: false);
  db.task_DB.add(newTask);
  taskDataController.setInitialSharedPrefrences();
}

// task削除.
void delete_task(int taskIdFromUi) {
  for (int i = 0; i < db.task_DB.length; i++) {
    if (db.task_DB[i].id == taskIdFromUi) {
      db.task_DB.removeAt(i);
      taskDataController.setInitialSharedPrefrences();
      return;
    }
  }
  debugPrint("The ID isn't found...");
}

// task全削除.
void all_delete_task() {
  db.task_DB = [];
  taskDataController.setInitialSharedPrefrences();
}

// task終了.
void done_task(int taskIdFromUi, int realDurationFromUi) {
  for (int i = 0; i < db.task_DB.length; i++) {
    if (db.task_DB[i].id == taskIdFromUi) {
      db.task_DB[i].realDuration = realDurationFromUi;
      db.task_DB[i].ifDone = true;
      taskDataController.setInitialSharedPrefrences();
      return;
    }
  }
  debugPrint("The ID isn't found...");
}

// task変更.
void change_task(int taskIdFromUi, TaskModel newtaskFromUi) {
  for (int i = 0; i < db.task_DB.length; i++) {
    if (db.task_DB[i].id == taskIdFromUi) {
      db.task_DB.removeAt(i);
      db.task_DB.insert(i, newtaskFromUi);
      taskDataController.setInitialSharedPrefrences();
      return;
    }
  }
  debugPrint("The ID isn't found...");
}

// task参照.
TaskModel? query_task(int taskIdFromUi) {
  for (int i = 0; i < db.task_DB.length; i++) {
    if (db.task_DB[i].id == taskIdFromUi) {
      return db.task_DB[i];
    }
  }
  return null;
}

// task参照して表示.
void debug_print_query_task() {
  if (db.task_DB == []) {
    debugPrint("task isn't exist");
  } else {
    for (int i = 0; i < db.task_DB.length; i++) {
      debugPrint(db.task_DB[i].toJson().toString());
    }
  }
}

// appointment追加.
void add_appointment(
    String titleFromUI, DateTime beginTimeFromUI, DateTime endTimeFromUI) {
  int newAppointmentID = randomIntWithRange(10000, 99999);
  while (!judge_appointment_id(newAppointmentID)) {
    int newAppointmentID = randomIntWithRange(10000, 99999);
  }
  var newAppointment = AppointmentModel(
      id: newAppointmentID,
      title: titleFromUI,
      beginTime: beginTimeFromUI,
      endTime: endTimeFromUI);
  db.appointment_DB.add(newAppointment);
  appointmentDataController.setInitialSharedPrefrences();
}

// appointment削除.
void delete_appointment(int appointmentIdFromUi) {
  for (int i = 0; i < db.appointment_DB.length; i++) {
    if (db.appointment_DB[i].id == appointmentIdFromUi) {
      db.appointment_DB.removeAt(i);
      appointmentDataController.setInitialSharedPrefrences();
      return;
    }
  }
  debugPrint("The ID isn't found...");
}

// appointment全削除.
void all_delete_appointment() {
  db.appointment_DB = [];
  appointmentDataController.setInitialSharedPrefrences();
}

// appointment変更.
void change_appointment(
    int appointmentIdFromUi, AppointmentModel newAppointmentFromUi) {
  for (int i = 0; i < db.appointment_DB.length; i++) {
    if (db.appointment_DB[i].id == appointmentIdFromUi) {
      db.appointment_DB.removeAt(i);
      db.appointment_DB.insert(i, newAppointmentFromUi);
      appointmentDataController.setInitialSharedPrefrences();
      return;
    }
  }
  debugPrint("The ID isn't found...");
}

// appointment参照.
AppointmentModel? query_appointment(int appointmentIdFromUi) {
  for (int i = 0; i < db.appointment_DB.length; i++) {
    if (db.appointment_DB[i].id == appointmentIdFromUi) {
      return db.appointment_DB[i];
    }
  }
  return null;
}

// appointment参照して表示.
void debug_print_query_appointment() {
  for (int i = 0; i < db.appointment_DB.length; i++) {
    debugPrint(db.appointment_DB[i].toJson().toString());
  }
}
