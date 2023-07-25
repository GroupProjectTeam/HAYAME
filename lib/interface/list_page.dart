import 'package:flutter/material.dart';
import 'package:hayame/interface/select_appointment_page.dart';
import 'package:hayame/interface/select_task_page.dart';
import 'package:hayame/database.dart' as db;
import 'package:hayame/schedule_function.dart';

//----------------
//data

List todo_list_today = [];

List todo_list_tomorrow = [];

List todo_list_others = [];

//----------------
//pageUI

class list_page extends StatefulWidget {
  const list_page({super.key});
  @override
  State<StatefulWidget> createState() => list_pageState();
}

class list_pageState extends State<list_page> {
  Card show_todo_card(var0, var1, var2, var3, var4, var5, var6) {
    String deadline = "";
    for (int i = 0; i < db.task_DB.length; i++) {
      if (db.task_DB[i].id == var0) {
        var deadline0 = db.task_DB[i].deadline;
        deadline = "deadline: " +
            deadline0.month.toString() +
            "/" +
            deadline0.day.toString() +
            " " +
            deadline0.hour.toString() +
            ":" +
            deadline0.minute.toString().padLeft(2, "0");
      }
    }
    Card task_card = Card(
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 18.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_circle_up),
                    onPressed: () {
                      db.todo_select = var0;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => select_task_page()),
                      );
                    }, //press [^] button to select_task_page
                  ),
                  const SizedBox(width: 10),
                  Column(children: [
                    Text(
                      var2.substring(5),
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      var3,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      var4,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ]),
                  const SizedBox(width: 10),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          var1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              const TextStyle(fontSize: 20, color: Colors.red),
                        ),
                        const SizedBox(height: 5),
                        Row(children: [
                          Text(
                            var5, //.substring(0, 5),
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(width: 15),
                          Text(deadline),
                        ]),
                      ]),
                ],
              )),
          const SizedBox(width: 12),
        ],
      ),
    );
    Card appointment_card = Card(
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 18.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_circle_up),
                    onPressed: () {
                      db.todo_select = var0;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => select_appointment_page()),
                      );
                    }, //press [^] button to select_task_page
                  ),
                  const SizedBox(width: 10),
                  Column(children: [
                    Text(
                      var2.substring(5),
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      var3,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      var4,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ]),
                  const SizedBox(width: 10),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          var1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              const TextStyle(fontSize: 20, color: Colors.blue),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          var5, //.substring(0, 5),
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 10),
                      ]),
                ],
              )),
          const SizedBox(width: 12),
        ],
      ),
    );
    if (var6 == 0) {
      return task_card;
    } else {
      return appointment_card;
    }
  }

  Widget show_todo_card_list(todo_list) {
    List<Card> todo_card_list = [];
    for (int i = 0; i < todo_list.length; i++) {
      if (todo_list[i][1] != "rest") {
        todo_card_list.add(show_todo_card(
          todo_list[i][0],
          todo_list[i][1],
          todo_list[i][2],
          todo_list[i][3],
          todo_list[i][4],
          todo_list[i][5],
          todo_list[i][6],
        ));
      }
    }
    return Column(children: todo_card_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Divider(
          height: 10.0,
          indent: 10.0,
          color: Colors.black,
        ),
        const SizedBox(height: 10),
        Expanded(
            child: ListView(
          children: [
            const SizedBox(height: 5),
            Row(children: [
              const SizedBox(width: 15),
              const Text("Today", style: TextStyle(fontSize: 30)),
            ]),
            show_todo_card_list(todo_list_today),
            const Divider(
              height: 10.0,
              indent: 10.0,
              color: Colors.black,
            ),
            const SizedBox(height: 5),
            Row(children: [
              const SizedBox(width: 15),
              const Text("Tomorrow", style: TextStyle(fontSize: 30)),
            ]),
            show_todo_card_list(todo_list_tomorrow),
            const Divider(
              height: 10.0,
              indent: 10.0,
              color: Colors.black,
            ),
            const SizedBox(height: 5),
            Row(children: [
              const SizedBox(width: 15),
              const Text("Others", style: TextStyle(fontSize: 30)),
            ]),
            show_todo_card_list(todo_list_others),
            const Divider(
              height: 10.0,
              indent: 10.0,
              color: Colors.black,
            ),
            const SizedBox(height: 40),
          ],
        )),
        Center(
          child: IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              //refresh_buttonUI();

              List all_list = schedule_arranger();
              print(all_list);
              setState(() {
                if (all_list[0].isNotEmpty) {
                  todo_list_today = all_list[0];
                } else {
                  todo_list_today = [];
                }
                if (all_list[1].isNotEmpty) {
                  todo_list_tomorrow = all_list[1];
                } else {
                  todo_list_tomorrow = [];
                }
                if (all_list[2].isNotEmpty) {
                  todo_list_others = all_list[2];
                } else {
                  todo_list_others = [];
                }
              });
              print(db.appointment_DB);
              print(db.task_DB);
            }, //press【refresh】button to apply schedule_function
          ),
        ),
      ],
    ));
  }
}
