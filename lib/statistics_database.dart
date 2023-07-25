//ここはもう変更しない。データは22個(2023/7/25 4:04)
import 'model/task_model.dart';
import 'model/appointment_model.dart';
import 'model/schedule_model.dart';
import 'model/statistics_model.dart';

int todo_select = 0;
int SYS_START_TIME = DateTime(2023, 7, 4, 8).millisecondsSinceEpoch;
int SYS_END_TIME = DateTime(2023, 7, 30, 22).millisecondsSinceEpoch;

// TaskModel => {task_id, title, deadline, duration, real_duration, if_done}.
List<CollectModel> collected_DB = [
  CollectModel(
      id: -1,
      title: "レポート",
      duration: 30,
      realDuration: 43,
  ),
  CollectModel(
      id: -2,
      title: "火2 レポート",
      duration: 90,
      realDuration: 105,
  ),
  CollectModel(
      id: -3,
      title: "レポート",
      duration: 60,
      realDuration: 120,
  ),
  CollectModel(
      id: -4,
      title: "レポート",
      duration: 60,
      realDuration: 45,
  ),
  CollectModel(
      id: -5,
      title: "レポート",
      duration: 60,
      realDuration: 50,
  ),
  CollectModel(
      id: -6,
      title: "情報システム分析論",
      duration: 30,
      realDuration: 30,
  ),
  CollectModel(
      id: -7,
      title: "レポート",
      duration: 90,
      realDuration: 60,
  ),
  CollectModel(
      id: -8,
      title: "レポート",
      duration: 120,
      realDuration: 150,
  ),
  CollectModel(
      id: -9,
      title: "特別講義レポート",
      duration: 90,
      realDuration: 120,
  ),
  CollectModel(
      id: -10,
      title: "レポート(火曜2限ブレインストーミング)",
      duration: 90,
      realDuration: 110,
  ),
  CollectModel(
      id: -11,
      title: "レポート",
      duration: 180,
      realDuration: 240,
  ),
  CollectModel(
      id: -12,
      title: "レポート",
      duration: 60,
      realDuration: 60,
  ),
  CollectModel(
      id: -13,
      title: "レポート",
      duration: 60,
      realDuration: 55,
  ),
    CollectModel(
      id: -14,
      title: "グループ実習のレポート",
      duration: 60,
      realDuration: 120,
  ),
    CollectModel(
      id: -15,
      title: "レポート",
      duration: 60,
      realDuration: 115,
  ),
    CollectModel(
      id: -16,
      title: "slides",
      duration: 60,
      realDuration: 120,
  ),
    CollectModel(
      id: -17,
      title: "ハッカソン",
      duration: 60,
      realDuration: 120,
  ),
    CollectModel(
      id: -18,
      title: "レポート",
      duration: 10,
      realDuration: 20,
  ),
    CollectModel(
      id: -19,
      title: "レポート",
      duration: 60,
      realDuration: 120,
  ),
    CollectModel(
      id: -20,
      title: "特別講義のレポート",
      duration: 60,
      realDuration: 45,
  ),
    CollectModel(
      id: -21,
      title: "特別講義のレポート",
      duration: 90,
      realDuration: 120,
  ),
    CollectModel(
      id: -22,
      title: "レポート",
      duration: 60,
      realDuration: 60,
  ),
];
  