import 'package:collection/collection.dart';
import 'model/task_model.dart';
import 'database.dart' as db;

class DurationPoint {
  final double x;
  final double y;

  DurationPoint({required this.x, required this.y});
}

List<DurationPoint> get durationPoints {
  List<double> duration_data = [];
  for (int i = 0; i < db.task_DB.length; i++){
    duration_data.add(db.task_DB[i].duration.toDouble());
  }
  return duration_data
      .mapIndexed(
          ((index, element) => DurationPoint(x: index.toDouble(), y: element)))
      .toList();
}

List<DurationPoint> get realDurationPoints {
  List<double> real_duration_data = [];
  for (int i = 0; i < db.task_DB.length; i++){
    real_duration_data.add(db.task_DB[i].realDuration.toDouble());
  }
  return real_duration_data
      .mapIndexed(
          ((index, element) => DurationPoint(x: index.toDouble(), y: element)))
      .toList();
}