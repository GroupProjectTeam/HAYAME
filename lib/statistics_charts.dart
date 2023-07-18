// import 'package:fl_chart_app/presentation/widgets/legend_widget.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'statistics_data.dart';
import 'statistics_func.dart' as sf;

import 'package:hayame/model/task_model.dart';
import 'database.dart' as db;
import 'statistics_func.dart' as sf;

int durationFromUI = 30;

class MyChart extends StatelessWidget {
  final List<DurationPoint> duration_points;
  final List<DurationPoint> real_duration_points;

  const MyChart(this.duration_points, this.real_duration_points, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 150,
              color: Colors.grey[200],
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      sf.alert(durationFromUI),
                      style: 
                        const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    )
                  ),
                  // Text(sf.alert(durationFromUI, loadModel)),
                ],
              ),
            ),
            Center(
              child: Container(
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
            )  
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
        for (int i = 0; i < done_task.length; i++){
          if (done_task[i].id == id){
            text = done_task[i].title;
          }
        }
        return Text(text);
      },
    );