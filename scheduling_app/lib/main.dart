import 'package:flutter/material.dart';
import 'package:scheduling_app/model/task_model.dart';
import 'package:scheduling_app/model/appointment_model.dart';
import 'database.dart' as db;
import 'database_function.dart' as fc;
import 'database_read_load.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  TaskDataController taskDataController = TaskDataController();
  AppointmentDataController appointmentDataController =
      AppointmentDataController();

  debugPrint("---Task start---");
  fc.debug_print_query_task();
  debugPrint("---read---");
  await taskDataController.readTaskData();
  fc.debug_print_query_task();
  debugPrint("---add---");
  fc.add_task("taskTitle1", DateTime(2023, 6, 1, 12, 00), 30);
  fc.debug_print_query_task();
  debugPrint("---delete---");
  fc.delete_task(db.task_DB[0].id);
  fc.debug_print_query_task();
  debugPrint("---add 2---");
  fc.add_task("taskTitle2", DateTime(2023, 6, 2, 12, 00), 30);
  fc.add_task("taskTitle3", DateTime(2023, 6, 3, 12, 00), 30);
  fc.debug_print_query_task();
  debugPrint("---change---");
  TaskModel newtaskFromUi = TaskModel(
      id: db.task_DB[0].id,
      title: "changed Task title",
      deadline: db.task_DB[0].deadline,
      duration: db.task_DB[0].duration,
      realDuration: db.task_DB[0].realDuration,
      ifDone: db.task_DB[0].ifDone);
  fc.change_task(db.task_DB[0].id, newtaskFromUi);
  fc.debug_print_query_task();
  debugPrint("---done---");
  fc.done_task(db.task_DB[0].id, 120);
  fc.debug_print_query_task();
  debugPrint("---all delete---");
  fc.all_delete_task();
  fc.debug_print_query_task();
  debugPrint("---add final---");
  fc.add_task("taskTitleFinal", DateTime(2023, 6, 30, 12, 00), 30);
  fc.debug_print_query_task();
  debugPrint("---save---");
  await taskDataController.setInitialSharedPrefrences();

  debugPrint("---Appointment start---");
  fc.debug_print_query_appointment();
  debugPrint("---read---");
  await appointmentDataController.readAppointmentData();
  fc.debug_print_query_appointment();
  debugPrint("---add---");
  fc.add_appointment("appointmentTitle1", DateTime(2023, 7, 1, 12, 00),
      DateTime(2023, 7, 1, 14, 00));
  fc.debug_print_query_appointment();
  debugPrint("---delete---");
  fc.delete_appointment(db.appointment_DB[0].id);
  fc.debug_print_query_appointment();
  debugPrint("---add 2---");
  fc.add_appointment("appointmentTitle2", DateTime(2023, 7, 2, 12, 00),
      DateTime(2023, 7, 2, 14, 00));
  fc.add_appointment("appointmentTitle3", DateTime(2023, 7, 3, 12, 00),
      DateTime(2023, 7, 3, 14, 00));
  fc.debug_print_query_appointment();
  debugPrint("---change---");
  AppointmentModel newAppointmentFromUi = AppointmentModel(
      id: db.appointment_DB[0].id,
      title: "changed appointment title",
      beginTime: db.appointment_DB[0].beginTime,
      endTime: db.appointment_DB[0].endTime);
  fc.change_appointment(db.appointment_DB[0].id, newAppointmentFromUi);
  fc.debug_print_query_appointment();
  debugPrint("---all delete---");
  fc.all_delete_appointment();
  fc.debug_print_query_appointment();
  debugPrint("---add final---");
  fc.add_appointment("appointmentTitleFinal", DateTime(2023, 7, 31, 12, 00),
      DateTime(2023, 7, 31, 14, 00));
  fc.debug_print_query_appointment();
  debugPrint("---save---");
  await appointmentDataController.setInitialSharedPrefrences();
}
