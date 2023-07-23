import 'package:flutter/material.dart';
import 'package:hayame/interface/list_page.dart';
import 'package:hayame/interface/setting_page.dart';
import 'package:hayame/interface/add_todo_page.dart';
import 'package:hayame/interface/statistics_page.dart';

//----------------
//pageUI

class home_page extends StatefulWidget {
  const home_page({super.key});
  @override
  State<StatefulWidget> createState() => home_pageState();
}

class home_pageState extends State<home_page> {
  var pages = [const list_page(), const statistics_page()];
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => setting_page()),
            ); //press [o] button to setting_page
          },
        ),
        title: const Text("HAYAME"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.alarm_add_sharp,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => add_todo_page()),
              ); //press [+] button to add_todo_page
            },
          ),
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "List",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: "Statistics",
          ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
