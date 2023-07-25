import 'package:intl/intl.dart';

// 適宜変更お願いします.

class ScheduleModel {
  final int id; // 5桁の数字.
  DateTime beginTime; // スケジュールの開始時刻.
  DateTime endTime; // スケジュールの終了時刻.

  ScheduleModel(
      {required this.id, required this.beginTime, required this.endTime});

  // Map型に変換.
  Map toJson() => {
        'id': id,
        'beginTime': beginTime.toString(),
        'endTime': endTime.toString(),
      };

  // JSONオブジェクトを代入.
  ScheduleModel.fromJson(Map json)
      : id = json['id'],
        beginTime = DateFormat('y-M-d h:m:00.000').parse(json['beginTime']),
        endTime = DateFormat('y-M-d h:m:00.000').parse(json['endTime']);
}