// matsuo
import 'dart:math' as math;

import 'package:ml_algo/ml_algo.dart';

import 'model/task_model.dart';
import 'database.dart' as db;

import 'statistics_func.dart' as sf;

// import 'dart:io';

// import 'package:flutter/material.dart';
import 'package:hayame/statistics_charts.dart';
import 'package:hayame/statistics_data.dart';

//database_function.dartより------------------------------------------------
// ランダムに数字生成.
int randomIntWithRange(int min, int max) {
  int value = math.Random().nextInt(max - min);
  return value + min;
}

// task_DBに同じIDがあるか判定.
bool judge_task_id(int targetId) {
  for (int i = 0; i < db.task_DB.length; i++) {
    if (db.task_DB[i].id == targetId) {
      return false;
    }
  }
  return true;
}

// task追加. 
void add_task(String titleFromUI, DateTime deadlineFromUI, int durationFromUI) {
  //int newTaskID = TaskDataController.currentID + 1;
  //TaskDataController.currentID = newTaskID;
  int newTaskID = randomIntWithRange(10000, 99999);
  while (!judge_task_id(newTaskID)) {
    int newTaskID = randomIntWithRange(10000, 99999);
  }
  var newTask = TaskModel(
      id: newTaskID,
      title: titleFromUI,
      deadline: deadlineFromUI,
      duration: durationFromUI,
      realDuration: 0,
      ifDone: false);
  db.task_DB.add(newTask);
}
//------------------------------------------------


void main() async {
  //デバッグ用データの作成
  add_task("1", DateTime(2023, 6, 2, 12, 0), 40);
  add_task("1", DateTime(2023, 6, 2, 12, 0), 10);
  add_task("1", DateTime(2023, 6, 2, 12, 0), 50);
  add_task("1", DateTime(2023, 6, 2, 12, 0), 20);
  add_task("1", DateTime(2023, 6, 2, 12, 0), 40);
  // add_task("1", DateTime(2023, 6, 2, 12, 0), 50);
  // add_task("1", DateTime(2023, 6, 2, 12, 0), 60);
  // add_task("1", DateTime(2023, 6, 2, 12, 0), 20);
  // add_task("1", DateTime(2023, 6, 2, 12, 0), 40);
  // add_task("1", DateTime(2023, 6, 2, 12, 0), 80);

  sf.alert(50);
  print(MyChart(durationPoints, realDurationPoints));
  // List<TaskModel> doneTaskDB = sf.get_done_task_DB(db.task_DB); 
  // final shuffledDataframe = sf.get_train_dataframe(doneTaskDB);

  // //データを使って見積時間から実際にかかりそうな時間を予測
  // String fileName = "duration_model.json";
  // LinearRegressor model = sf.train(shuffledDataframe, fileName);
  // await model.saveAsJson(fileName);
  // print("model saved.");

  // final file = File(fileName);
  // final encodedModel = await file.readAsString();
  // final load_model = LinearRegressor.fromJson(encodedModel);
  // sf.predict_duration(30, load_model);
}