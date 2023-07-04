import 'model/task_model.dart';
import 'model/appointment_model.dart';
import 'model/schedule_model.dart';

// TaskModel => {task_id, title, deadline, duration, real_duration, if_done}.
List<TaskModel> task_DB = [];

// AppointmentModel => {appointment_id, title, begin_time, end_time}.
List<AppointmentModel> appointment_DB = [];

// 以降は適宜変更お願いします.

// FreeModel => {free_id, begin_free_time, end_free_time}.
// ScheduleModel = {schedule_id (, subtask_id), begin_time, end_time}.
List<ScheduleModel> schedule_DB = [];
