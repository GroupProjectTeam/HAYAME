import 'package:intl/intl.dart';

class SortTaskModel {
  int id; // 5桁の数字.
  String title; // タスクの名前.
  DateTime deadline; // タスクの締め切り.
  int duration; // タスクの見積もり時間.
  int realDuration = 0; // タスクの実際にかかった時間.
  bool ifDone = false; // タスクが完了したかどうか.

  SortTaskModel(
    {required this.id,
    required this.title,
    required this.deadline,
    required this.duration,
    required this.realDuration,
    required this.ifDone});
}

class CollectModel {
  final int id; // 5桁の数字.
  String title; // タスクの名前.
  int duration; // タスクの見積もり時間.
  int realDuration = 0; // タスクの実際にかかった時間.

  CollectModel(
      {required this.id,
      required this.title,
      required this.duration,
      required this.realDuration,});
}