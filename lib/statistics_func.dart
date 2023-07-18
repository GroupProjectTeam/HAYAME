import 'database.dart' as db;
import 'model/task_model.dart';
// import 'package:flutter/services.dart' show rootBundle;
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';

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
get_test_dataframe (List<TaskModel> taskModelData){
  List<List> listData = [['Duration', 'RealDuration'],];
  for (int i = 0; i < taskModelData.length; i++){
    List data = [taskModelData[i].duration, taskModelData[i].realDuration];
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
  // print(prediction.header);
  // print(prediction.rows);
  // int predicted_duration = prediction.rows[0];
  final rows = prediction.rows;
  final list_rows = List.from(rows);
  final predict_duration = List.from(list_rows[0]);
  // print(predict_duration);
  int predicted_duration = predict_duration[0].toInt();
  // print(predicted_duration);
  return predicted_duration;
}

int predict(int durationFromUI) {
  List<TaskModel> doneTaskDB = get_done_task_DB(db.task_DB); 
  final shuffledDataframe = get_train_dataframe(doneTaskDB);

  //データを使って見積時間から実際にかかりそうな時間を予測
  LinearRegressor model = train(shuffledDataframe);
  int predicted_duration = predict_duration(durationFromUI, model);
  print(predicted_duration);
  return predicted_duration;
}

//予測時間に応じて警告文を表示
String alert(int durationFromUI){
  String alert_message = "";
  int? predicted_duration = predict(durationFromUI);
  print(predicted_duration);
  if(predicted_duration > durationFromUI * 1.5){
    alert_message = "あなたが実際に課題にかけた時間は\n見積時間より小さい傾向があります。";
  }
  else if (predicted_duration < durationFromUI * 0.5){
    alert_message = "あなたが実際に課題にかけた時間は\n見積時間より大きい傾向があります。";
  }
  else {
    alert_message = "見積時間は適正です。";
  }
  print(alert_message);
  return alert_message;
}




