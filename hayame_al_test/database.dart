//task_DB = [ [task_id, title, deadline, duration, real_duration, if_done] ];
List task_DB = [
  [001, "task1", 1688460277003, 3600000, 50, false],
  [002, "task2", 1688460277003, 3600000, 50, false],
  [003, "task3", 1688460277003, 7200000, 50, false]
];

//appointment_DB = [ [appointment_id, title, begin_time, end_time] ]
List appointment_DB = [
  [001, "sleep1", 1688373877003, 1688381077003],
  [002, "sleep2", 1688402677073, 1688409877073]
];

//free_DB = [ [free_id, begin_free_time, end_free_time] ]
List free_DB = [];

//schedule_DB = [ [task_id, subtask_id, begin_time, end_time] ]
List schedule_DB = [];

int SYS_START_TIME = 1688373877003;
int SYS_END_TIME = 1688460277003;

// int SYS_START_TIME = DateTime.now().microsecondsSinceEpoch;
// int SYS_END_TIME =
//     DateTime.now().add(new Duration(days: 3)).microsecondsSinceEpoch;

//appointment_and_schedule_DB = [ [display_id, title, begin_time, end_time, is_appointment, original_id] ]
List appointment_and_schedule_DB = [];

// class TaskModel {
//   final int id;
//   String title;
//   DateTime deadline;
//   int duration;
//   int realDuration = 0;
//   bool ifDone = false;
// }

// class AppointmentModel {
//   final int id;
//   String title;
//   DateTime beginTime;
//   DateTime endTime;
// }

// class ScheduleModel {
//   final int id;
//   DateTime beginTime;
//   DateTime endTime;
// }

// ＜database.dart＞

// //taskのデータベース
// List<TaskModel> task_db = []
// ex.) {id: 1, title: task1, deadline: 2023-06-30 12:00:00.000, duration: 30, realDuration: 0, ifDone: false} etc..

// //appointmentのデータベース
// List<AppointmentModel> appointment_db = []
// ex.){id: 1, title: appointment1, beginTime: 2023-06-20 12:00:00.000, endTime: 2023-06-20 14:00:00.000} etc..
