import 'model/test_model.dart';
import 'model/task_model.dart';
import 'model/appointment_model.dart';
import 'model/schedule_model.dart';

//task_DB = [ [task_id, title, deadline, duration, real_duration, if_done] ];
List<TaskModel> task_DB = [];

//appointment_DB = [ [appointment_id, title, begin_time, end_time] ]
List<AppointmentModel> appointment_DB = [];

//free_DB = [ [free_id, begin_free_time, end_free_time] ]

//schedule_DB = [ [schedule_id (, subtask_id), begin_time, end_time] ]
List<ScheduleModel> schedule_DB = [];

List<TestModel> testData = [
  TestModel(
      id: '1',
      category: 'Business book',
      number: 0,
      isAccepted: false,
      titles: ['ビジネスの教科書', '決算書の読み方', 'ロジカルシンキング']),
  TestModel(
      id: '2',
      category: 'Comics',
      number: 999,
      isAccepted: true,
      titles: [
        'ONE PIECE',
        'SLAM DUNK',
        'HUNTER×HUNTER',
        '鬼滅の刃',
        '銀魂',
        '呪術廻戦'
      ]),
];
