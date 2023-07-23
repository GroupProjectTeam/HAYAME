import 'database.dart' as db;
import 'model/task_model.dart';
// import 'package:flutter/services.dart' show rootBundle;
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'statistics_database.dart';
import 'package:hayame/model/statistics_model.dart';

//終わったタスクのデータをとる
List<TaskModel> get_done_task_DB(List <TaskModel> task_DB) {
  List<TaskModel> done_task_DB = [];
  for (int i = 0; i < task_DB.length; i++){
    if (db.task_DB[i].ifDone == true) {
      done_task_DB.add(db.task_DB[i]);
      print("donetask: ${task_DB[i].ifDone}, ${task_DB[i].duration}, ${task_DB[i].realDuration}");
    }
  }
  return done_task_DB;
}

//訓練用にデータを加工してシャッフルして返す
get_train_dataframe (List<TaskModel> taskModelData){
  List<List> listData = [['Duration', 'RealDuration'],];
  for (int i = 0; i < taskModelData.length; i++){
    List data = [taskModelData[i].duration, taskModelData[i].realDuration];
    listData.add(data);
  }
  final dataframe = DataFrame(listData);
  final shuffledDataframe = dataframe.shuffle();
  return shuffledDataframe;
}

//テスト用にデータを加工して返す(シャッフルしない)
get_test_dataframe (List<TaskModel> testTaskModelData){
  List<List> listData = [['Duration', 'RealDuration'],];
  for (int i = 0; i < testTaskModelData.length; i++){
    List data = [testTaskModelData[i].duration, testTaskModelData[i].realDuration];
    listData.add(data);
  }
  final dataframe = DataFrame(listData);
  return dataframe;
}

//訓練
LinearRegressor train (DataFrame dataframe) {
  const targetName = 'RealDuration';
  final splits = splitData(dataframe, [0.8]);
  final trainData = splits[0];
  final testData = splits[1];
  final model = LinearRegressor(trainData, targetName);
  final error = model.assess(testData, MetricType.mape);
  print("error");
  print(error);
  return model;
}

//かかる時間の予測。予測時間を返す
int predict_duration (int durationFromUI, LinearRegressor loadModel) {
  final unlabelledData = DataFrame([
    ['Duration'],
    [durationFromUI],
  ]);
  final prediction = loadModel.predict(unlabelledData);
  final rows = prediction.rows;
  final list_rows = List.from(rows);
  final predict_duration = List.from(list_rows[0]);
  int predicted_duration = predict_duration[0].toInt();
  return predicted_duration;
}

int predict(int durationFromUI) {
  final shuffledDataframe = get_train_dataframe(get_done_task_DB(db.task_DB));
  //データを使って見積時間から実際にかかりそうな時間を予測
  LinearRegressor model = train(shuffledDataframe);
  int predicted_duration = predict_duration(durationFromUI, model);
  print(predicted_duration);
  return predicted_duration;
}

//予測時間に応じて警告文を表示
String alert(){
  String alert_message = "";
  if(my_average() < 1.0){
    alert_message = "あなたが実際に課題にかけた時間は\n見積時間より小さい傾向があります。";
  }
  else if (my_average() > 1.0){
    alert_message = "あなたが実際に課題にかけた時間は\n見積時間より大きい傾向があります。";
  }
  else {
    alert_message = "見積時間は適正です。";
  }
  print(alert_message);
  return alert_message;
}

String get_predict(int durationFromUI){
  String alert_message = "";
  int? predicted_duration = predict(durationFromUI);
  print(predicted_duration);
  alert_message = "実際に課題にかかる時間の予想時間は\n${predicted_duration}です。\n";
  print(alert_message);
  return alert_message;
}

double first_predict() {
  List<double> ratio_list = [];
  for (int i = 0; i < collected_DB.length; i++){
    double ratio = collected_DB[i].realDuration.toDouble()/collected_DB[i].duration.toDouble();
    ratio_list.add(ratio);
  }
  double average = ratio_list.reduce((a,b) => a + b) / ratio_list.length;
  print("average:${average}",);
  return average;
}

double my_average() {
  List<TaskModel> done_task = get_done_task_DB(db.task_DB);
  List<double> ratio_list = [];
  for (int i = 0; i < done_task.length; i++){
    double ratio = done_task[i].realDuration.toDouble()/done_task[i].duration.toDouble();
    ratio_list.add(ratio);
  }
  double average = ratio_list.reduce((a,b) => a + b) / ratio_list.length;
  print("average:${average}",);
  return average;
}

List<SortTaskModel> get_sorted_list(List<TaskModel> task) {
  List<TaskModel> sorted_task = task;
  List<SortTaskModel> sorted_list = [];
  sorted_task.sort(((a, b) => a.deadline.compareTo(b.deadline)));

  for (int i = 0; i < sorted_task.length; i++){
    sorted_list.add(SortTaskModel(
    id: i,
    title: sorted_task[i].title,
    deadline: sorted_task[i].deadline,
    duration: sorted_task[i].duration,
    realDuration: sorted_task[i].realDuration,
    ifDone: sorted_task[i].ifDone,
    ));
  }
  return sorted_list;
}
  





