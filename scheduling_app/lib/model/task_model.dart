import 'package:intl/intl.dart';

class TaskModel {
  final int id; // 5桁の数字.
  String title; // タスクの名前.
  DateTime deadline; // タスクの締め切り.
  int duration; // タスクの見積もり時間.
  int realDuration = 0; // タスクの実際にかかった時間.
  bool ifDone = false; // タスクが完了したかどうか.

  TaskModel(
      {required this.id,
      required this.title,
      required this.deadline,
      required this.duration,
      required this.realDuration,
      required this.ifDone});

  // Map型に変換.
  Map toJson() => {
        'id': id,
        'title': title,
        'deadline': deadline.toString(),
        'duration': duration,
        'realDuration': realDuration,
        'ifDone': ifDone
      };

  // JSONオブジェクトを代入.
  TaskModel.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        deadline = DateFormat('y-M-d h:m:00.000').parse(json['deadline']),
        duration = json['duration'],
        realDuration = json['realDuration'],
        ifDone = json['ifDone'];
}
