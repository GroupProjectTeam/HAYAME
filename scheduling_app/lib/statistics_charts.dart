import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:scheduling_app/statistics_data.dart';
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
              height: 60,
              color: Colors.grey[200],
              child: Column(
                children: <Widget>[
                  Text(sf.alert(durationFromUI)),
                  // Text(sf.alert(durationFromUI, loadModel)),
                ],
              ),
            ),
            Container(
              height: 200,
              child: LineChart(
                LineChartData(lineBarsData: [
                  LineChartBarData(
                    spots:duration_points.map((point) => FlSpot(point.x, point.y)).toList(),
                  ),
                  LineChartBarData(
                    color: Colors.red[400],
                    spots:real_duration_points.map((point) => FlSpot(point.x, point.y)).toList(),
                  )
              ],
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                )),
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                minY: 0,
                ),
              ),
            ),
          ],
        ),
      ),  
    );
  }
}