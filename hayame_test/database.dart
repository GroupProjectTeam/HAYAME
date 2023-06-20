import 'interface.dart' as ui;

//task_DB = [ [task_id, title, deadline, duration, real_duration, if_done] ];
List task_DB = [
  [001, "task1", 202306201200, 30, 50, false]
];

//appointment_DB = [ [appointment_id, title, begin_time, end_time] ]
List appointment_DB = [
  [001, "task1", 202306201200, 202306201800]
];

//free_DB = [ [free_id, begin_free_time, end_free_time] ]

//schedule_DB = [ [task_id, subtask_id, begin_time, end_time] ]
List schedule_DB = [
  [001, 001, 202306201200, 202306201800]
];
