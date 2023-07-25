import 'package:intl/intl.dart';

class AppointmentModel {
  final int id; // 5桁の数字.
  String title; // 予定名.
  DateTime beginTime; // 予定の開始時刻.
  DateTime endTime; // 予定の終了時刻.

  AppointmentModel(
      {required this.id,
      required this.title,
      required this.beginTime,
      required this.endTime});

  // Map型に変換.
  Map toJson() => {
        'id': id,
        'title': title,
        'beginTime': beginTime.toString(),
        'endTime': endTime.toString(),
      };

  // JSONオブジェクトを代入.
  AppointmentModel.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        beginTime = DateFormat('y-M-d h:m:00.000').parse(json['beginTime']),
        endTime = DateFormat('y-M-d h:m:00.000').parse(json['endTime']);
}