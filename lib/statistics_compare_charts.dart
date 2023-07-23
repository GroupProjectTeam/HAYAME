// import 'package:fl_chart_app/presentation/widgets/legend_widget.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'statistics_data.dart';
import 'statistics_func.dart' as sf;

import 'package:hayame/model/task_model.dart';
import 'database.dart' as db;
import 'statistics_func.dart' as sf;
import 'package:hayame/interface/statistics_page.dart';

class CompareData extends StatelessWidget {
  const CompareData({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(title: 'Flutter Demo Home Page'),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
    );
  }

  Widget content() {
    return Center(
      child: CompareChart(),
    );
  }
}

class CompareChart extends StatelessWidget {
  const CompareChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 150,
            color: Colors.grey[200],
            child:Center(
              child: Text(
                    "ほかの人の課題にかかった時間は見積もり時間の平均${sf.first_predict()}倍です。",
                    style: 
                      const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
              )
            ),
          ),
          Container(
            height: 500,
            width: MediaQuery.of(context).size.width - 150,
            child: RadarChart(
              RadarChartData(
                // read about it in the RadarChartData section
                dataSets: [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<RawDataSet> rawDataSets() {
  return [
    RawDataSet(
      title: 'Fashion',
      color:  Color.fromRGBO(100, 24, 80, 0.498),
      values: [
        300,
        50,
        250,
      ],
    ),
    RawDataSet(
      title: 'Art & Tech',
      color: Color.fromRGBO(40, 100, 24, 0.5),
      values: [
        250,
        100,
        200,
      ],
    ),
    RawDataSet(
      title: 'Entertainment',
      color: Color.fromRGBO(40, 100, 24, 0.5),
      values: [
        200,
        150,
        50,
      ],
    ),
    RawDataSet(
      title: 'Off-road Vehicle',
      color: Color.fromRGBO(40, 100, 24, 0.5),
      values: [
        150,
        200,
        150,
      ],
    ),
    RawDataSet(
      title: 'Boxing',
      color: Color.fromRGBO(40, 100, 24, 0.5),
      values: [
        100,
        250,
        100,
      ],
    ),
  ];
}

class RawDataSet {
  RawDataSet({
    required this.title,
    required this.color,
    required this.values,
  });

  final String title;
  final Color color;
  final List<double> values;
}