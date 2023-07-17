import 'package:flutter/material.dart';
import 'package:hayame/database.dart' as db;
import 'package:hayame/database_function.dart';

//----------------
//buttonUI

void delete_task_buttonUI(id) {
  delete_task(id);
  print(db.task_DB);
}

void done_task_buttonUI(id, real_duration) {
  done_task(id, real_duration);
}

//----------------
//fromUI

int select_task_real_duration_fromUI() {
  return int.parse(real_duration_controller.text);
}

String task_title_fromUI() {
  return task_1_controller.text;
}

DateTime task_deadline_fromUI() {
  DateTime deadline_fromUI = DateTime(
    select_date.year,
    select_date.month,
    select_date.day,
    int.parse(task_24_controller.text),
    int.parse(task_25_controller.text),
  );
  return deadline_fromUI;
}

int task_duration_fromUI() {
  return int.parse(task_3_controller.text);
}

final real_duration_controller = TextEditingController();
DateTime select_date = DateTime(2023, 7, 4, 8, 00);
final task_1_controller = TextEditingController();
final task_24_controller = TextEditingController();
final task_25_controller = TextEditingController();
final task_3_controller = TextEditingController();

//----------------
//pageUI

class select_task_page extends StatefulWidget {
  const select_task_page({super.key});
  @override
  State<StatefulWidget> createState() => select_task_pageState();
}

class select_task_pageState extends State<select_task_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("task_select_page"),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            const SizedBox(height: 40),
            const Text("Real duration of time to finish the task"),
            TextField(
              controller: real_duration_controller,
              decoration: const InputDecoration(
                filled: true,
                labelText: "duration (minutes)",
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text(
                "Done",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                done_task_buttonUI(
                    db.todo_select, select_task_real_duration_fromUI());
                Navigator.pop(context);
              },
            ),
            // const SizedBox(height: 40),
            // const Text("Tittle"),
            // TextField(
            //   controller: task_1_controller,
            //   decoration: const InputDecoration(
            //     filled: true,
            //     labelText: "tittle",
            //   ),
            // ),
            // const SizedBox(height: 20),
            // const Text("Deadline"),
            // const SizedBox(height: 5),
            // Row(children: [
            //   show_select_date(context),
            //   const SizedBox(width: 5),
            //   Text(
            //     select_date.toString().substring(0, 10),
            //     style: const TextStyle(fontSize: 20),
            //   ),
            // ]),
            // const SizedBox(height: 10),
            // TextField(
            //   controller: task_24_controller,
            //   decoration: const InputDecoration(
            //     filled: true,
            //     labelText: "hour",
            //   ),
            // ),
            // const SizedBox(width: 5),
            // TextField(
            //   controller: task_25_controller,
            //   decoration: const InputDecoration(
            //     filled: true,
            //     labelText: "minute",
            //   ),
            // ),
            // const SizedBox(height: 20),
            // const Text("Estimated duration of time to finish the task"),
            // const SizedBox(height: 5),
            // TextField(
            //   controller: task_3_controller,
            //   decoration: const InputDecoration(
            //     filled: true,
            //     labelText: "duration (minutes)",
            //   ),
            // ),
            // const SizedBox(height: 30),
            // ElevatedButton(
            //   child: const Text(
            //     "change",
            //     style: TextStyle(fontSize: 20),
            //   ),
            //   onPressed: () {
            //     change_task_buttonUI(task_title_fromUI(),
            //         task_deadline_fromUI(), task_duration_fromUI());
            //     Navigator.pop(context);
            //   },
            // ), //press [Change] button
            const SizedBox(height: 80),
            ElevatedButton(
              child: const Text(
                "Delete",
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
              onPressed: () {
                print(db.todo_select);
                delete_task_buttonUI(db.todo_select);
                Navigator.pop(context);
              }, //press [Delete] button
            ),
          ],
        ));
  }

  ElevatedButton show_select_date(context) {
    return ElevatedButton(
      child: Text("Select Date"),
      onPressed: () {
        showDatePicker(
          context: context,
          initialDate: DateTime(2023, 7, 4, 8, 00), // 初始化选中日期
          firstDate: DateTime(2022, 1), // 开始日期
          lastDate: DateTime(2024, 1), // 结束日期
          // initialEntryMode: DatePickerEntryMode.input,  // 日历弹框样式

          textDirection: TextDirection.ltr, // 文字方向

          currentDate: DateTime(2023, 7, 4), // 当前日期

          cancelText: "Cancel", // 取消按钮文案
          confirmText: "OK", // 确认按钮文案

          errorFormatText: "The date you entered is in wrong format", // 格式错误提示
          errorInvalidText: "errorInvalidText", // 输入不在 first 与 last 之间日期提示

          fieldLabelText: "fieldLabelText", // 输入框上方提示
          fieldHintText: "fieldHintText", // 输入框为空时内部提示

          initialDatePickerMode: DatePickerMode.day, // 日期选择模式，默认为天数选择
          useRootNavigator: true, // 是否为根导航器
        ).then((value) {
          setState(() {
            select_date = value ?? DateTime(2023, 7, 4, 8, 00);
          });
        });
      },
    );
  }
}
