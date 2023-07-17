import 'package:flutter/material.dart';
import 'package:hayame/statistics_charts.dart';
import 'package:hayame/statistics_data.dart';

class statistics_page extends StatelessWidget {
  const statistics_page({super.key});

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
      appBar: AppBar(
        title: Text("Statistics"),
      ),
      body: content(),
    );
  }

  Widget content() {
    return Center(
      child: MyChart(durationPoints, realDurationPoints),
    );
  }
}
