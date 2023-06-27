//appointment_DB = [ [appointment_id, title, begin_time, end_time] ]
import 'package:intl/intl.dart';

class AppointmentModel {
  final int id;
  String title;
  DateTime beginTime;
  DateTime endTime;

  AppointmentModel(
      {required this.id,
      required this.title,
      required this.beginTime,
      required this.endTime});

  /// Map型に変換
  Map toJson() => {
        'id': id,
        'title': title,
        'beginTime': beginTime.toString(),
        'endTime': endTime.toString(),
      };

  /// JSONオブジェクトを代入
  AppointmentModel.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        beginTime = DateFormat('y-M-d h:m:00.000').parse(json['beginTime']),
        endTime = DateFormat('y-M-d h:m:00.000').parse(json['endTime']);
}
