import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database.dart' as db;
import 'model/task_model.dart';
import 'model/appointment_model.dart';
import 'model/schedule_model.dart';

class TaskDataController {
  List<TaskModel> taskData = []; // 保存・読み出し用リスト.
  String taskKey = 'taskKey'; // 保存・読み出し用文字列キー.

  // テストデータの準備.
  Future settingTaskData() async {
    taskData = db.task_DB;
  }

  // 実際に保存を実行する場合はコレを呼ぶ.
  Future setInitialSharedPrefrences() async {
    // テストデータの準備.
    await settingTaskData();
    // sharedPreferencesに保存.
    await saveTaskData();
  }

  // SharedPrefrences保存.
  Future saveTaskData() async {
    // ①Map型変換→②Json形式にエンコード→③リスト化.
    List<String> myTaskData =
        taskData.map((f) => json.encode(f.toJson())).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ④保存.
    await prefs.setStringList(taskKey, myTaskData);

    debugPrint('保存したmyTaskData: $myTaskData');
  }

  // SharedPrefrences読み出し.
  Future readTaskData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ①読み出し.
    var result = prefs.getStringList(taskKey);
    // 読み出し確認.
    if (result != null) {
      // ②デコード→③MapオブジェクトをClockModelに代入→④リストに変換.
      db.task_DB =
          result.map((f) => TaskModel.fromJson(json.decode(f))).toList();
    } else {
      // 必要に応じて初期化.
      debugPrint('読み出し失敗');
    }
  }
}

class AppointmentDataController {
  List<AppointmentModel> appointmentData = []; // 保存・読み出し用リスト.
  String appointmentKey = 'appointmentKey'; // 保存・読み出し用文字列キー.

  // テストデータの準備.
  Future settingAppointmentData() async {
    appointmentData = db.appointment_DB;
  }

  // 実際に保存を実行する場合はコレを呼ぶ.
  Future setInitialSharedPrefrences() async {
    // テストデータの準備.
    await settingAppointmentData();
    // sharedPreferencesに保存.
    await saveAppointmentData();
  }

  // SharedPrefrences保存.
  Future saveAppointmentData() async {
    // ①Map型変換→②Json形式にエンコード→③リスト化.
    List<String> myAppointmentData =
        appointmentData.map((f) => json.encode(f.toJson())).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ④保存.
    await prefs.setStringList(appointmentKey, myAppointmentData);

    debugPrint('保存したmyAppointmentData: $myAppointmentData');
  }

  // SharedPrefrences読み出し
  Future readAppointmentData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ①読み出し.
    var result = prefs.getStringList(appointmentKey);
    // 読み出し確認.
    if (result != null) {
      // ②デコード→③MapオブジェクトをClockModelに代入→④リストに変換.
      db.appointment_DB =
          result.map((f) => AppointmentModel.fromJson(json.decode(f))).toList();
    } else {
      // 必要に応じて初期化.
      debugPrint('読み出し失敗');
    }
  }
}

class ScheduleDataController {
  List<ScheduleModel> scheduleData = []; // 保存・読み出し用リスト.
  String scheduleKey = 'scheduleKey'; // 保存・読み出し用文字列キー.

  // テストデータの準備.
  Future settingScheduleData() async {
    scheduleData = db.schedule_DB;
  }

  // 実際に保存を実行する場合はコレを呼ぶ.
  Future setInitialSharedPrefrences() async {
    // テストデータの準備.
    await settingScheduleData();
    // sharedPreferencesに保存.
    await saveScheduleData();
  }

  // SharedPrefrences保存.
  Future saveScheduleData() async {
    // ①Map型変換→②Json形式にエンコード→③リスト化.
    List<String> myScheduleData =
        scheduleData.map((f) => json.encode(f.toJson())).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ④保存.
    await prefs.setStringList(scheduleKey, myScheduleData);

    debugPrint('保存したmyScheduleData: $myScheduleData');
  }

  // SharedPrefrences読み出し.
  Future readAppointmentData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ①読み出し.
    var result = prefs.getStringList(scheduleKey);
    // 読み出し確認.
    if (result != null) {
      // ②デコード→③MapオブジェクトをClockModelに代入→④リストに変換.
      db.schedule_DB =
          result.map((f) => ScheduleModel.fromJson(json.decode(f))).toList();
    } else {
      // 必要に応じて初期化.
      debugPrint('読み出し失敗');
    }
  }
}
