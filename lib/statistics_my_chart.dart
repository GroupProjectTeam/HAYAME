// import 'package:fl_chart_app/presentation/widgets/legend_widget.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'statistics_data.dart';
import 'statistics_func.dart' as sf;

import 'package:hayame/model/task_model.dart';
import 'database.dart' as db;
import 'package:hayame/model/statistics_model.dart';

class MyChart extends StatelessWidget {
  final List<DurationPoint> duration_points;
  final List<DurationPoint> real_duration_points;

  const MyChart(this.duration_points, this.real_duration_points, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[   
            Container(
              width: double.infinity,
              height: 150,
              color: Colors.grey[200],
              child:Center(
                child: Text(
                      sf.alert(),
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
                      spots:duration_points.map((point) => FlSpot(point.x, point.y)).toList(),
                    ),
                    LineChartBarData(
                      color: Colors.red[400],
                      spots:real_duration_points.map((point) => FlSpot(point.x, point.y)).toList(),
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
                    "あなたの実際にかかった時間は\n見積時間のおおよそ${sf.my_average().toStringAsFixed(2)}倍です。\nほかの人の課題にかかった時間は\n見積もり時間のおおよそ${sf.first_predict().toStringAsFixed(2)}倍です。",
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
    List<TaskModel> done_task = sf.get_done_task_DB(db.task_DB);
    List<SortTaskModel> sorted_list = sf.get_sorted_list(done_task);

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