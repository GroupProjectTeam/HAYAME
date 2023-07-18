import 'package:collection/collection.dart';
import 'package:hayame/model/task_model.dart';
import 'database.dart' as db;
import 'statistics_func.dart' as sf;

class DurationPoint {
  final double x;
  final double y;

  DurationPoint({required this.x, required this.y});
}

// List<DurationPoint> get durationPoints {
  
//   List<double> duration_data = [];
//   for (int i = 0; i < db.task_DB.length; i++){
//     duration_data.add(db.task_DB[i].duration.toDouble());
//   }
//   return duration_data
//       .mapIndexed(
//           ((index, element) => DurationPoint(x: index.toDouble(), y: element)))
//       .toList();
// }

// List<DurationPoint> get durationPoints {
//   List<TaskModel> done_task = sf.get_done_task_DB(db.task_DB);
//   List<double> duration_data = [];
//   for (int i = 0; i < done_task.length; i++){
//     duration_data.add(done_task[i].duration.toDouble());
//   }
//   return duration_data
//       .mapIndexed(
//           ((index, element) => DurationPoint(x: index.toDouble(), y: element)))
//       .toList();
// }

// List<DurationPoint> get realDurationPoints {
//   List<TaskModel> done_task = sf.get_done_task_DB(db.task_DB);
//   List<double> real_duration_data = [];
//   for (int i = 0; i < done_task.length; i++){
//     real_duration_data.add(done_task[i].realDuration.toDouble());
//   }
//   return real_duration_data
//       .mapIndexed(
//           ((index, element) => DurationPoint(x: index.toDouble(), y: element)))
//       .toList();
// }

List<DurationPoint> get durationPoints {
  List<TaskModel> done_task = sf.get_done_task_DB(db.task_DB);
  List<int> duration_data_id = [];
  List<double> duration_data = [];
  List<DurationPoint> duration_list = [];

  for (int i = 0; i < done_task.length; i++){
    duration_data_id.add(done_task[i].id);
    duration_data.add(done_task[i].duration.toDouble());
  }

  print("duration_data");
  for (int i = 0; i < done_task.length; i++){
    duration_list.add(DurationPoint(x: duration_data_id[i].toDouble(), y: duration_data[i]));
  }
  return duration_list;
}

List<DurationPoint> get realDurationPoints {
  List<TaskModel> done_task = sf.get_done_task_DB(db.task_DB);
  List<int> real_duration_data_id = [];
  List<double> real_duration_data = [];
  List<DurationPoint> real_duration_list = [];

  for (int i = 0; i < done_task.length; i++){
    real_duration_data_id.add(done_task[i].id);
    real_duration_data.add(done_task[i].realDuration.toDouble());
  }

  print("duration_data");
  for (int i = 0; i < done_task.length; i++){
    real_duration_list.add(DurationPoint(x: real_duration_data_id[i].toDouble(), y: real_duration_data[i]));
  }
  return real_duration_list;
}