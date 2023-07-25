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
  List<TaskModel> done_task = [];
  List<int> duration_data_id = [];
  List<double> duration_data = [];
  List<DurationPoint> duration_list = [];
  List<SortTaskModel> sorted_list = [];
  List<SortTaskModel> cut_list = [];

  done_task = sf.get_done_task_DB(db.task_DB);
  print("done_task.length:${done_task.length}");
  if (done_task.isEmpty){
    duration_list = [DurationPoint(x: 0.toDouble(), y: 0.toDouble())];    
  }
  else{
    sorted_list = sf.get_sorted_list(done_task);
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

    for (int i = 0; i < sorted_list.length; i++){
      duration_list.add(DurationPoint(x: duration_data_id[i].toDouble(), y: duration_data[i]));
    }
  }
  
  // duration_list = [DurationPoint(x: 0.toDouble(), y: 0.toDouble()),DurationPoint(x: 1.toDouble(), y: 0.toDouble())];
  print("duration_list");
  print(duration_list);
  for(int i = 0; i < duration_list.length; i++){
    print("${duration_list[i].x}, ${duration_list[i].y}");
  }
  return duration_list;
}

List<DurationPoint> get realDurationPoints {
  List<TaskModel> done_task = [];
  List<int> real_duration_data_id = [];
  List<double> real_duration_data = [];
  List<DurationPoint> real_duration_list = [];
  List<SortTaskModel> sorted_list = [];
  List<SortTaskModel> cut_list = [];

  done_task = sf.get_done_task_DB(db.task_DB);
  print("done_task.length:${done_task.length}");
  if (done_task.isEmpty){
    real_duration_list = [DurationPoint(x: 0.toDouble(), y: 0.toDouble())];    
  }
  else{
    sorted_list = sf.get_sorted_list(done_task);
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
      real_duration_data_id.add(sorted_list[i].id);
      real_duration_data.add(sorted_list[i].realDuration.toDouble());
    }

    for (int i = 0; i < sorted_list.length; i++){
      real_duration_list.add(DurationPoint(x: real_duration_data_id[i].toDouble(), y: real_duration_data[i]));
    }
  }
  
  // real_duration_list = [DurationPoint(x: 0.toDouble(), y: 0.toDouble()),DurationPoint(x: 1.toDouble(), y: 0.toDouble())];
  print("real_duration_list");
  print(real_duration_list);
  for(int i = 0; i < real_duration_list.length; i++){
    print("${real_duration_list[i].x}, ${real_duration_list[i].y}");
  }
  return real_duration_list;
}