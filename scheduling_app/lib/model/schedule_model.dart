//schedule_DB = [ [schedule_id (, subtask_id), begin_time, end_time] ]
import 'package:intl/intl.dart';

class ScheduleModel {
  final int id;
  DateTime beginTime;
  DateTime endTime;

  ScheduleModel(
      {required this.id, required this.beginTime, required this.endTime});

  /// Map型に変換
  Map toJson() => {
        'id': id,
        'beginTime': beginTime.toString(),
        'endTime': endTime.toString(),
      };

  /// JSONオブジェクトを代入
  ScheduleModel.fromJson(Map json)
      : id = json['id'],
        beginTime = DateFormat('y-M-d h:m:00.000').parse(json['beginTime']),
        endTime = DateFormat('y-M-d h:m:00.000').parse(json['endTime']);
}
