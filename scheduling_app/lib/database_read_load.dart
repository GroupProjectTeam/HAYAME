import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database.dart' as db;
import 'model/test_model.dart';
import 'model/task_model.dart';
import 'model/appointment_model.dart';
import 'model/schedule_model.dart';

class TestDataController {
  List<TestModel> testData = []; // 保存・読み出し用リスト
  String testKey = 'testKey'; // 保存・読み出し用文字列キー

  // テストデータの準備
  void settingTestData() {
    testData = db.testData;
  }

  // 実際に保存を実行する場合はコレを呼ぶ
  void setInitialSharedPrefrences() {
    // テストデータの準備
    settingTestData();
    // sharedPreferencesに保存
    saveTestData();
  }

  // SharedPrefrences保存
  Future saveTestData() async {
    // ①Map型変換→②Json形式にエンコード→③リスト化
    List<String> myData = testData.map((f) => json.encode(f.toJson())).toList();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ④保存
    await prefs.setStringList(testKey, myData);

    debugPrint('保存したmyData: $myData');
  }

  // SharedPrefrences読み出し
  Future readTestData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ①読み出し
    var result = prefs.getStringList(testKey);

    debugPrint('読み出したresult:$result');

    // 読み出し確認
    if (result != null) {
      // ②デコード→③MapオブジェクトをClockModelに代入→④リストに変換
      testData = result.map((f) => TestModel.fromJson(json.decode(f))).toList();
    } else {
      // 必要に応じて初期化
      debugPrint('読み出し失敗');
    }
  }
}

class TaskDataController {
  List<TaskModel> taskData = []; // 保存・読み出し用リスト
  String taskKey = 'taskKey'; // 保存・読み出し用文字列キー
  static int currentID = 0;

  // テストデータの準備
  void settingTaskData() {
    taskData = db.task_DB;
  }

  // 実際に保存を実行する場合はコレを呼ぶ
  void setInitialSharedPrefrences() {
    // テストデータの準備
    settingTaskData();
    // sharedPreferencesに保存
    saveTaskData();
  }

  // SharedPrefrences保存
  Future saveTaskData() async {
    // ①Map型変換→②Json形式にエンコード→③リスト化
    List<String> myTaskData =
        taskData.map((f) => json.encode(f.toJson())).toList();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ④保存
    await prefs.setStringList(taskKey, myTaskData);

    debugPrint('保存したmyTaskData: $myTaskData');
  }

  // SharedPrefrences読み出し
  Future readTaskData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ①読み出し
    var result = prefs.getStringList(taskKey);

    debugPrint('読み出したresult:$result');

    // 読み出し確認
    if (result != null) {
      // ②デコード→③MapオブジェクトをClockModelに代入→④リストに変換
      taskData = result.map((f) => TaskModel.fromJson(json.decode(f))).toList();
    } else {
      // 必要に応じて初期化
      debugPrint('読み出し失敗');
    }
  }
}

class AppointmentDataController {
  List<AppointmentModel> appointmentData = []; // 保存・読み出し用リスト
  String appointmentKey = 'appointmentKey'; // 保存・読み出し用文字列キー
  static int currentID = 0;

  // テストデータの準備
  void settingAppointmentData() {
    appointmentData = db.appointment_DB;
  }

  // 実際に保存を実行する場合はコレを呼ぶ
  void setInitialSharedPrefrences() {
    // テストデータの準備
    settingAppointmentData();
    // sharedPreferencesに保存
    saveAppointmentData();
  }

  // SharedPrefrences保存
  Future saveAppointmentData() async {
    // ①Map型変換→②Json形式にエンコード→③リスト化
    List<String> myAppointmentData =
        appointmentData.map((f) => json.encode(f.toJson())).toList();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ④保存
    await prefs.setStringList(appointmentKey, myAppointmentData);

    debugPrint('保存したmyAppointmentData: $myAppointmentData');
  }

  // SharedPrefrences読み出し
  Future readAppointmentData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ①読み出し
    var result = prefs.getStringList(appointmentKey);

    debugPrint('読み出したresult:$result');

    // 読み出し確認
    if (result != null) {
      // ②デコード→③MapオブジェクトをClockModelに代入→④リストに変換
      appointmentData =
          result.map((f) => AppointmentModel.fromJson(json.decode(f))).toList();
    } else {
      // 必要に応じて初期化
      debugPrint('読み出し失敗');
    }
  }
}

class ScheduleDataController {
  List<ScheduleModel> scheduleData = []; // 保存・読み出し用リスト
  String scheduleKey = 'scheduleKey'; // 保存・読み出し用文字列キー

  // テストデータの準備
  void settingScheduleData() {
    scheduleData = db.schedule_DB;
  }

  // 実際に保存を実行する場合はコレを呼ぶ
  void setInitialSharedPrefrences() {
    // テストデータの準備
    settingScheduleData();
    // sharedPreferencesに保存
    saveScheduleData();
  }

  // SharedPrefrences保存
  Future saveScheduleData() async {
    // ①Map型変換→②Json形式にエンコード→③リスト化
    List<String> myScheduleData =
        scheduleData.map((f) => json.encode(f.toJson())).toList();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ④保存
    await prefs.setStringList(scheduleKey, myScheduleData);

    debugPrint('保存したmyScheduleData: $myScheduleData');
  }

  // SharedPrefrences読み出し
  Future readAppointmentData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ①読み出し
    var result = prefs.getStringList(scheduleKey);

    debugPrint('読み出したresult:$result');

    // 読み出し確認
    if (result != null) {
      // ②デコード→③MapオブジェクトをClockModelに代入→④リストに変換
      scheduleData =
          result.map((f) => ScheduleModel.fromJson(json.decode(f))).toList();
    } else {
      // 必要に応じて初期化
      debugPrint('読み出し失敗');
    }
  }
}
