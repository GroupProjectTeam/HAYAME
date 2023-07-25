import 'package:hayame/model/statistics_model.dart';
import 'package:hayame/model/task_model.dart';
import 'database.dart' as db;
import 'statistics_func.dart' as sf;

int MaxDisplayDataNum = 4;

class DurationPoint {
  final double x;
  final double y;

  DurationPoint({required this.x, required this.y});
}

List<DurationPoint> get durationPoints {
  List<TaskModel> done_task = sf.get_done_task_DB(db.task_DB);
  List<int> duration_data_id = [];
  List<double> duration_data = [];
  List<DurationPoint> duration_list = [];
  
  List<SortTaskModel> sorted_list = sf.get_sorted_list(done_task);
  List<SortTaskModel> cut_list = [];
  if (sorted_list.length > MaxDisplayDataNum){
    for(int i = 0; i < MaxDisplayDataNum; i++){
      cut_list.add(sorted_list[sorted_list.length - MaxDisplayDataNum + i]);
    }
    sorted_list = cut_list;
  }

  for (int i = 0; i < sorted_list.length; i++){
    print("sorted");
    print("${sorted_list[i].id} : ${sorted_list[i].deadline}");
  }
  
  for (int i = 0; i < sorted_list.length; i++){
    duration_data_id.add(sorted_list[i].id);
    duration_data.add(sorted_list[i].duration.toDouble());
  }



  print("duration_data");
  for (int i = 0; i < sorted_list.length; i++){
    duration_list.add(DurationPoint(x: duration_data_id[i].toDouble(), y: duration_data[i]));
  }
  
  return duration_list;
}

List<DurationPoint> get realDurationPoints {
  List<TaskModel> done_task = sf.get_done_task_DB(db.task_DB);

  List<int> real_duration_data_id = [];
  List<double> real_duration_data = [];
  List<DurationPoint> real_duration_list = [];

  List<SortTaskModel> sorted_list = sf.get_sorted_list(done_task);

  List<SortTaskModel> cut_list = [];
  if (sorted_list.length > MaxDisplayDataNum){
    for(int i = 0; i < MaxDisplayDataNum; i++){
      cut_list.add(sorted_list[sorted_list.length - MaxDisplayDataNum + i]);
    }
    sorted_list = cut_list;
  }

  for (int i = 0; i < sorted_list.length; i++){
    print("sorted");
    print("${sorted_list[i].id} : ${sorted_list[i].deadline}");
  }
  
  for (int i = 0; i < sorted_list.length; i++){
    print("sorted");
    print("${sorted_list[i].id} : ${sorted_list[i].deadline}");
  }

  for (int i = 0; i < sorted_list.length; i++){
    real_duration_data_id.add(sorted_list[i].id);
    real_duration_data.add(sorted_list[i].realDuration.toDouble());
  }

  print("duration_data");
  for (int i = 0; i < sorted_list.length; i++){
    real_duration_list.add(DurationPoint(x: real_duration_data_id[i].toDouble(), y: real_duration_data[i]));
  }
  return real_duration_list;
}