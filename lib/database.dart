import 'model/task_model.dart';
import 'model/appointment_model.dart';
import 'model/schedule_model.dart';

int todo_select = 0;
int SYS_START_TIME = DateTime(2023, 7, 4, 8).millisecondsSinceEpoch;
int SYS_END_TIME = DateTime(2023, 7, 30, 22).millisecondsSinceEpoch;

// TaskModel => {task_id, title, deadline, duration, real_duration, if_done}.
List<TaskModel> task_DB = [
  TaskModel(
      id: 101,
      title: "情報学展望レポート",
      deadline: DateTime(2023, 7, 6, 23),
      duration: 120,
      realDuration: 0,
      ifDone: false),
  TaskModel(
      id: 102,
      title: "情報社会論レポート",
      deadline: DateTime(2023, 7, 5, 23),
      duration: 120,
      realDuration: 160,
      ifDone: true),
  TaskModel(
      id: 103,
      title: "特別講座レポート",
      deadline: DateTime(2023, 7, 8, 15),
      duration: 180,
      realDuration: 160,
      ifDone: true),
  TaskModel(
      id: 104,
      title: "研究レポートを準備",
      deadline: DateTime(2023, 7, 7, 12),
      duration: 240,
      realDuration: 270,
      ifDone: true),
  
];

// AppointmentModel => {appointment_id, title, begin_time, end_time}.
List<AppointmentModel> appointment_DB = [
  AppointmentModel(
      id: 104,
      title: "情報システム論",
      beginTime: DateTime(2023, 7, 4, 10),
      endTime: DateTime(2023, 7, 4, 12)),
  AppointmentModel(
      id: 105,
      title: "情報システム論実習",
      beginTime: DateTime(2023, 7, 4, 13),
      endTime: DateTime(2023, 7, 4, 18)),
  AppointmentModel(
      id: 106,
      title: "情報社会論",
      beginTime: DateTime(2023, 7, 5, 10),
      endTime: DateTime(2023, 7, 5, 12)),
  AppointmentModel(
      id: 107,
      title: "研究室ミーティング",
      beginTime: DateTime(2023, 7, 5, 13),
      endTime: DateTime(2023, 7, 5, 16)),
  AppointmentModel(
      id: 108,
      title: "情報学展望",
      beginTime: DateTime(2023, 7, 6, 8),
      endTime: DateTime(2023, 7, 6, 10)),
  AppointmentModel(
      id: 109,
      title: "研究室ミーティング",
      beginTime: DateTime(2023, 7, 7, 13),
      endTime: DateTime(2023, 7, 7, 16)),
];

// 以降は適宜変更お願いします.

// FreeModel => {free_id, begin_free_time, end_free_time}.
// ScheduleModel = {schedule_id (, subtask_id), begin_time, end_time}.

List appointment_and_schedule_DB = [];

//free_DB = [ [free_id, begin_free_time, end_free_time] ]
List free_DB = [];

//schedule_DB = [ [task_id, subtask_id, begin_time, end_time] ]
List schedule_DB = [];
