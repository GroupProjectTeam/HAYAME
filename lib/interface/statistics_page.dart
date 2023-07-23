import 'package:flutter/material.dart';
import 'package:hayame/statistics_data.dart';
import 'package:hayame/statistics_func.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hayame/model/statistics_model.dart';
import 'package:hayame/model/task_model.dart';
import 'package:hayame/database.dart' as db;

class statistics_page extends StatelessWidget {
  const statistics_page({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(title: 'Flutter Demo Home Page', duration_points: durationPoints, real_duration_points: realDurationPoints),
    );
  }
}

class Home extends StatefulWidget {
  final String title;
  final List<DurationPoint> duration_points;
  final List<DurationPoint> real_duration_points;

  Home({super.key, required this.title, required this.duration_points, required this.real_duration_points});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int duration = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[ 
            Container(
              width: double.infinity,
              height: 70,
              color: Colors.grey[200],
              child:Center(
                child: Text(
                  'かかる時間の予想時間を入力してください。',
                  style: 
                    const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              child: TextField(
                decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'ここに予想時間の数値を入力',
                filled: true,
                ),
                onChanged: (text){
                  setState(() {
                    duration = int.parse(text);
                  });
                }
              ),
            ),
            Container(
              width: double.infinity,
              height: 150,
              color: Colors.grey[200],
              child:Center(
                child: Text(
                      get_predict(duration),
                      style: 
                        const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                )
              ),
            ),
            Container(
              width: double.infinity,
              height: 150,
              color: Colors.grey[200],
              child:Center(
                child: Text(
                      alert(),
                      style: 
                        const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                )
              ),
            ),
            Container(
              height: 500,
              width: MediaQuery.of(context).size.width - 150,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots:widget.duration_points.map((point) => FlSpot(point.x, point.y)).toList(),
                    ),
                    LineChartBarData(
                      color: Colors.red[400],
                      spots:widget.real_duration_points.map((point) => FlSpot(point.x, point.y)).toList(),
                    )
                  ],
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(
                      axisNameWidget:  const Text(
                        "あなたが実際に課題にかけた時間と見積時間の推移\n(赤：実際にかけた時間、青：見積時間)",
                      ),
                      axisNameSize:  70,
                    ),

                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      )
                    ),

                    bottomTitles: AxisTitles(
                      // sideTitles: SideTitles(
                      //   showTitles: true,
                      // ),
                      sideTitles: _bottomTitles,
                      axisNameWidget: Container(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          "title", 
                          style: 
                            TextStyle(fontSize: 10),
                        )
                      ),
                    ),

                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) => Text(
                          value.toInt().toString(),
                          style: 
                          const TextStyle(fontSize: 10),
                        ),
                      ),
                      axisNameWidget: const Text(
                        "duration [m]",
                        style: 
                          TextStyle(fontSize: 10),
                      ),
                      axisNameSize:  10
                    ),
                  ),
                  minY: 0,
                ),
              ),
            ),  
            Container(
              width: double.infinity,
              height: 150,
              color: Colors.grey[200],
              child:Center(
                child: Text(
                    "あなたの実際にかかった時間は\n見積時間のおおよそ${my_average().toStringAsFixed(2)}倍です。\nほかの人の課題にかかった時間は\n見積もり時間のおおよそ${first_predict().toStringAsFixed(2)}倍です。",
                    style: 
                      const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                )
              ),
            ),
            // Container(
            //   height: 500,
            //   width: MediaQuery.of(context).size.width - 150,
            //   child: RadarChart(
            //     RadarChartData(
            //       // read about it in the RadarChartData section
            //       dataSets: [],
            //     ),
            //   ),
            // ),
            //MyChart(durationPoints, realDurationPoints)       
          ],
        ),
      ),
    );
  }
}


SideTitles get _bottomTitles => SideTitles(
  showTitles: true,
  interval: 1,
  getTitlesWidget: (value, meta) {
    String text = '';
    int id = value.toInt();
    List<TaskModel> done_task = get_done_task_DB(db.task_DB);
    List<SortTaskModel> sorted_list = get_sorted_list(done_task);

    for (int i = 0; i < sorted_list.length; i++){
      if (sorted_list[i].id == id){
        String month = sorted_list[i].deadline.month.toString();
        String day = sorted_list[i].deadline.day.toString();
        text = month + "/" + day;
      }
    }
    return Text(text);
  },
);
