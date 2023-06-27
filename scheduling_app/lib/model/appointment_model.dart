//appointment_DB = [ [appointment_id, title, begin_time, end_time] ]

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
        'beginTime': beginTime,
        'endTime': endTime,
      };

  /// JSONオブジェクトを代入
  AppointmentModel.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        beginTime = json['beginTime'],
        endTime = json['endTime'];
}
