import 'package:flutter/material.dart';
import 'package:hayame/database.dart' as db;
import 'package:hayame/database_function.dart';

//----------------
//buttonUI

void add_appointment_buttonUI(
    String titleFromUI, DateTime beginTimeFromUI, DateTime endTimeFromUI) {
  add_appointment(titleFromUI, beginTimeFromUI, endTimeFromUI);
  print(db.appointment_DB);
}

//----------------
//fromUI

String appointment_title_fromUI() {
  return appointment_1_controller.text;
}

DateTime appointment_begin_time_fromUI() {
  DateTime begin_time_fromUI = DateTime(
    select_date.year,
    select_date.month,
    select_date.day,
    int.parse(appointment_24_controller.text),
    int.parse(appointment_25_controller.text),
  );
  return begin_time_fromUI;
}

DateTime appointment_end_time_fromUI() {
  DateTime end_time_fromUI = DateTime(
    select_date.year,
    select_date.month,
    select_date.day,
    int.parse(appointment_34_controller.text),
    int.parse(appointment_35_controller.text),
  );
  return end_time_fromUI;
}

DateTime select_date = DateTime(2023, 7, 4, 8, 00);
final appointment_1_controller = TextEditingController();
final appointment_24_controller = TextEditingController();
final appointment_25_controller = TextEditingController();
final appointment_34_controller = TextEditingController();
final appointment_35_controller = TextEditingController();

//----------------
//pageUI

class add_appointment_page extends StatefulWidget {
  const add_appointment_page({super.key});
  @override
  State<StatefulWidget> createState() => add_appointment_pageState();
}

class add_appointment_pageState extends State<add_appointment_page> {
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
          title: const Text("Add Appointment"),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          children: [
            const SizedBox(height: 40),
            const Text("Tittle"),
            TextField(
              controller: appointment_1_controller,
              decoration: const InputDecoration(
                filled: true,
                labelText: "tittle",
              ),
            ),
            const SizedBox(height: 20),
            const Text("Date"),
            const SizedBox(height: 5),
            Row(children: [
              show_select_date(context),
              const SizedBox(width: 5),
              Text(
                select_date.toString().substring(0, 10),
                style: const TextStyle(fontSize: 20),
              ),
            ]),

            const SizedBox(height: 20),
            const Text("Begin time"),
            const SizedBox(height: 5),
            TextField(
              controller: appointment_24_controller,
              decoration: const InputDecoration(
                filled: true,
                labelText: "hour",
              ),
            ),
            const SizedBox(width: 5),
            TextField(
              controller: appointment_25_controller,
              decoration: const InputDecoration(
                filled: true,
                labelText: "minute",
              ),
            ),
            const SizedBox(height: 20),
            const Text("End time"),
            const SizedBox(height: 5),

            TextField(
              controller: appointment_34_controller,
              decoration: const InputDecoration(
                filled: true,
                labelText: "hour",
              ),
            ),
            const SizedBox(width: 5),
            TextField(
              controller: appointment_35_controller,
              decoration: const InputDecoration(
                filled: true,
                labelText: "minute",
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              child: const Text(
                "Add",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                add_appointment_buttonUI(
                    appointment_title_fromUI(),
                    appointment_begin_time_fromUI(),
                    appointment_end_time_fromUI());
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ), //press [Add] button
            const SizedBox(height: 100),
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

          errorFormatText:
              "The date you entered is in the wrong format.", // 格式错误提示
          errorInvalidText:
              "The date you entered is in the wrong format.", // 输入不在 first 与 last 之间日期提示

          fieldLabelText: " ", // 输入框上方提示
          fieldHintText: "date", // 输入框为空时内部提示

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
