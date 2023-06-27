//task_DB = [ [task_id, title, deadline, duration, real_duration, if_done] ];

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
        'deadline': deadline,
        'duration': duration,
        'realDuration': realDuration,
        'idDone': ifDone
      };

  /// JSONオブジェクトを代入
  TaskModel.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        deadline = json['deadline'],
        duration = json['duration'],
        realDuration = json['realDuration'],
        ifDone = json['ifDone'];
}
