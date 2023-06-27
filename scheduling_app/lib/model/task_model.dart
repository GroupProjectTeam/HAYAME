//task_DB = [ [task_id, title, deadline, duration, real_duration, if_done] ];
import 'package:intl/intl.dart';

class TaskModel {
  final int id;
  String title;
  DateTime deadline;
  int duration;
  int realDuration = 0;
  bool ifDone = false;

  TaskModel(
      {required this.id,
      required this.title,
      required this.deadline,
      required this.duration,
      required this.realDuration,
      required this.ifDone});

  /// Map型に変換
  Map toJson() => {
        'id': id,
        'title': title,
        'deadline': deadline.toString(),
        'duration': duration,
        'realDuration': realDuration,
        'ifDone': ifDone
      };

  /// JSONオブジェクトを代入
  TaskModel.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        deadline = DateFormat('y-M-d h:m:00.000').parse(json['deadline']),
        duration = json['duration'],
        realDuration = json['realDuration'],
        ifDone = json['ifDone'];
}
