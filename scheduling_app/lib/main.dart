import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'database_function.dart' as fc;
import 'database_read_load.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // DatabaseHelper クラスのインスタンス取得
  final dbHelper = DatabaseHelper.instance;
  TestDataController testDataController = TestDataController();
  TaskDataController taskDataController = TaskDataController();
  AppointmentDataController appointmentDataController =
      AppointmentDataController();

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLiteデモ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: _insertTask,
              child: const Text(
                'Task追加',
                style: TextStyle(fontSize: 35),
              ),
            ),
            ElevatedButton(
              onPressed: _insertAppointment,
              child: const Text(
                'Appointment追加',
                style: TextStyle(fontSize: 35),
              ),
            ),
            ElevatedButton(
              onPressed: _readTest,
              child: const Text(
                'Test読み込み',
                style: TextStyle(fontSize: 35),
              ),
            ),
            ElevatedButton(
              onPressed: _saveTest,
              child: const Text(
                'Test保存',
                style: TextStyle(fontSize: 35),
              ),
            ),
            ElevatedButton(
              onPressed: _readTask,
              child: const Text(
                'Task読み込み',
                style: TextStyle(fontSize: 35),
              ),
            ),
            ElevatedButton(
              onPressed: _saveTask,
              child: const Text(
                'Task保存',
                style: TextStyle(fontSize: 35),
              ),
            ),
            ElevatedButton(
              onPressed: _readAppointment,
              child: const Text(
                'Appointment読み込み',
                style: TextStyle(fontSize: 35),
              ),
            ),
            ElevatedButton(
              onPressed: _saveAppointment,
              child: const Text(
                'Appointment保存',
                style: TextStyle(fontSize: 35),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 登録ボタンクリック
  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: '山田 太郎',
      DatabaseHelper.columnAge: 35
    };
    final id = await dbHelper.insert(row);
    debugPrint('登録しました。id: $id');
  }

  void _insertTask() async {
    String titleFromUI = "task1";
    DateTime deadlineFromUI = DateTime(2023, 6, 30, 12, 00);
    int durationFromUI = 60;
    fc.add_task(titleFromUI, deadlineFromUI, durationFromUI);
    debugPrint('登録しました。TaskTitle: $titleFromUI');
  }

  void _insertAppointment() async {
    String titleFromUI = "appointment1";
    DateTime beginTimeFromUI = DateTime(2023, 6, 20, 13, 00);
    DateTime endTimeFromUI = DateTime(2023, 6, 20, 14, 00);
    fc.add_appointment(titleFromUI, beginTimeFromUI, endTimeFromUI);
    debugPrint('登録しました。AppointmentTitle: $titleFromUI');
  }

  // 照会ボタンクリック
  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    debugPrint('全てのデータを照会しました。');
    for (var element in allRows) {
      debugPrint(element.toString());
    }
  }

  // 更新ボタンクリック
  void _update() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: 1,
      DatabaseHelper.columnName: '鈴木 一郎',
      DatabaseHelper.columnAge: 48
    };
    final rowsAffected = await dbHelper.update(row);
    debugPrint('更新しました。 ID: $rowsAffected ');
  }

  // 削除ボタンクリック
  void _delete() async {
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id!);
    debugPrint('削除しました。 $rowsDeleted ID: $id');
  }

  void _readTest() async {
    testDataController.readTestData();
  }

  void _saveTest() async {
    testDataController.setInitialSharedPrefrences();
  }

  void _readTask() async {
    taskDataController.readTaskData();
  }

  void _saveTask() async {
    taskDataController.setInitialSharedPrefrences();
  }

  void _readAppointment() async {
    appointmentDataController.readAppointmentData();
  }

  void _saveAppointment() async {
    appointmentDataController.setInitialSharedPrefrences();
  }
}
