//schedule_DB = [ [schedule_id (, subtask_id), begin_time, end_time] ]

class ScheduleModel {
  final int id;
  DateTime beginTime;
  DateTime endTime;

  ScheduleModel(
      {required this.id, required this.beginTime, required this.endTime});

  /// Map型に変換
  Map toJson() => {
        'id': id,
        'beginTime': beginTime,
        'endTime': endTime,
      };

  /// JSONオブジェクトを代入
  ScheduleModel.fromJson(Map json)
      : id = json['id'],
        beginTime = json['beginTime'],
        endTime = json['endTime'];
}
