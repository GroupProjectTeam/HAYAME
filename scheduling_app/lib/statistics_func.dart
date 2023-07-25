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
      // print("donetask: ${task_DB[i].ifDone}, ${task_DB[i].duration}, ${task_DB[i].realDuration}");
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

//訓練
LinearRegressor train (DataFrame dataframe) {
  const targetName = 'RealDuration';
  final trainData = dataframe;
  final model = LinearRegressor(trainData, targetName);
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
  //データを使って見積もり時間から実際にかかりそうな時間を予測
  LinearRegressor model = train(shuffledDataframe);
  int predicted_duration = predict_duration(durationFromUI, model);
  print("predicted_duration:${predicted_duration}");
  return predicted_duration;
}

//予測時間に応じて警告文を表示
String alert(){
  String alert_message = "終わったデータがないため表示できません。";
  if(my_ratio_average() < 1.0){
    alert_message = "あなたが実際に課題にかけた時間は\n見積もり時間より小さい傾向があります。";
  }
  else if (my_ratio_average() > 1.0){
    alert_message = "あなたが実際に課題にかけた時間は\n見積もり時間より大きい傾向があります。";
  }
  else {
    alert_message = "見積もり時間は適正です。";
  }
  print("alert_message:"+ alert_message);
  return alert_message;
}

String get_predict(int durationFromUI){
  String alert_message = "";
  List<TaskModel> done_task = [];
  done_task = get_done_task_DB(db.task_DB);
  if (durationFromUI == 0){
    alert_message = "見積もり時間が入力されていません";
  }
  else if(done_task.length < 3){
    alert_message = "終わった課題のデータが少ないため\n時間の予測ができません。";
  }
  else{
    int predicted_duration = predict(durationFromUI);
    alert_message = "実際に課題にかかる時間の予想時間は\n${predicted_duration}分です。";
  }
  print(alert_message);
  return alert_message;
}

double my_ratio_average() {
  List<TaskModel> done_task = [];
  done_task = get_done_task_DB(db.task_DB);
  List<double> ratio_list = [];
  double average = 0;
  double ratio = 0;
  print("done_task:${done_task}");
  if (done_task.length == 0){
    average = 0;
  }
  else{
    for (int i = 0; i < done_task.length; i++){
      ratio = done_task[i].realDuration.toDouble()/done_task[i].duration.toDouble();
      ratio_list.add(ratio);
    }
    average = ratio_list.reduce((a,b) => a + b) / ratio_list.length;
  } 
  print("my_ratio_average:${average}",);
  return average;
}

double my_duration_average() {
  List<TaskModel> done_task = [];
  done_task = get_done_task_DB(db.task_DB);
  List<double> duration_list = [];
  double average = 0;
  for (int i = 0; i < done_task.length; i++){
    duration_list.add(done_task[i].duration.toDouble());
  }
  average = duration_list.reduce((a,b) => a + b) / duration_list.length;
  print("my_duration_average:${average}",);
  return average;
}

double my_realduration_average() {
  List<TaskModel> done_task = [];
  done_task = get_done_task_DB(db.task_DB);
  List<double> realduration_list = [];
  double average = 0;
  for (int i = 0; i < done_task.length; i++){
    realduration_list.add(done_task[i].duration.toDouble());
  }
  average = realduration_list.reduce((a,b) => a + b) / realduration_list.length;
  print("my_realduration_average:${average}",);
  return average;
}

double ratio_average() {
  List<double> ratio_list = [];
  double average = 0;
  double ratio = 0;
  for (int i = 0; i < collected_DB.length; i++){
    ratio = collected_DB[i].realDuration.toDouble()/collected_DB[i].duration.toDouble();
    ratio_list.add(ratio);
  }
  average = ratio_list.reduce((a,b) => a + b) / ratio_list.length;
  print("ratio_average:${average}",);
  return average;
}

double duration_average() {
  List<double> duration_list = [];
  double average = 0;
  for (int i = 0; i < collected_DB.length; i++){
    duration_list.add(collected_DB[i].duration.toDouble());
  }
  average = duration_list.reduce((a,b) => a + b) / duration_list.length;
  print("duration_average:${average}",);
  return average;
}

double realduration_average() {
  List<double> realduration_list = [];
  double average = 0;
  for (int i = 0; i < collected_DB.length; i++){
    realduration_list.add(collected_DB[i].duration.toDouble());
  }
  average = realduration_list.reduce((a,b) => a + b) / realduration_list.length;
  print("realduration_average:${average}",);
  return average;
}

double num_small_predict() {
  int num = 0;
  for (int i = 0; i < collected_DB.length; i++){
    if(collected_DB[i].duration > collected_DB[i].realDuration){
      num += 1;
    }
  }
  return num.toDouble();
}

double num_big_predict() {
  int num = 0;
  for (int i = 0; i < collected_DB.length; i++){
    if(collected_DB[i].duration <= collected_DB[i].realDuration){
      num += 1;
    }
  }
  return num.toDouble();
}

List<SortTaskModel> get_sorted_list(List<TaskModel> task) {
  List<TaskModel> sorted_task = [];
  List<SortTaskModel> sorted_list = [];
  sorted_task = task;
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
  print("get_sorted_list:${sorted_list}");
  return sorted_list;
}
  





