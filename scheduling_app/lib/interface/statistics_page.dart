import 'package:flutter/material.dart';
import 'package:hayame/statistics_duration_data.dart';
import 'package:hayame/statistics_func.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hayame/model/statistics_model.dart';
import 'package:hayame/model/task_model.dart';
import 'package:hayame/database.dart' as db;

class statistics_page extends StatelessWidget {
  const statistics_page({super.key});

  @override
  Widget build(BuildContext context) {
    print("${durationPoints}, ${realDurationPoints}");
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(
          title: 'Flutter Demo Home Page',
          duration_points: durationPoints,
          real_duration_points: realDurationPoints),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  final String title;
  final List<DurationPoint> duration_points;
  final List<DurationPoint> real_duration_points;
  final gridColor = Color.fromRGBO(0, 0, 0, 0.486);
  final titleColor = Color.fromRGBO(0, 0, 0, 0.486);
  final myColor = Colors.red;
  final othersColor = Colors.blue;

  Home(
      {super.key,
      required this.title,
      required this.duration_points,
      required this.real_duration_points});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int duration = 0;

  int selectedDataSetIndex = -1;
  double angleValue = 0;
  bool relativeAngleMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 100,
              color: Colors.grey[200],
              child: Center(
                child: Text(
                  '課題にかかる時間を予想します。\nやる予定の課題にかかりそうな時間を\n入力してください',
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              height: 50,
              color: Colors.white,
              child: TextField(
                  decoration: InputDecoration(
                    hintText: 'ここに予想時間の数値を入力',
                    filled: true,
                  ),
                  onChanged: (text) {
                    setState(() {
                      duration = int.parse(text);
                    });
                  }),
            ),
            Container(
              width: double.infinity,
              height: 160,
              color: Colors.grey[200],
              child: Center(
                  child: Text(
                get_predict(duration) + '\n\n' + alert(),
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              )),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 350,
              width: MediaQuery.of(context).size.width - 150,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: widget.duration_points
                          .map((point) => FlSpot(point.x, point.y))
                          .toList(),
                    ),
                    LineChartBarData(
                      color: Colors.red[400],
                      spots: widget.real_duration_points
                          .map((point) => FlSpot(point.x, point.y))
                          .toList(),
                    )
                  ],
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(
                      axisNameWidget: const Text(
                        "あなたが実際に課題にかけた時間と\n見積もり時間の推移\n\n赤：実際にかけた時間\n青：見積もり時間\n",
                      ),
                      axisNameSize: 110,
                    ),
                    rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                      showTitles: false,
                    )),
                    bottomTitles: AxisTitles(
                      // sideTitles: SideTitles(
                      //   showTitles: true,
                      // ),
                      sideTitles: _bottomTitles,
                      axisNameWidget: Container(
                          alignment: Alignment.centerRight,
                          child: const Text(
                            "day",
                            style: TextStyle(fontSize: 10),
                          )),
                    ),
                    leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) => Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                        axisNameWidget: const Text(
                          "duration [m]",
                          style: TextStyle(fontSize: 10),
                        ),
                        axisNameSize: 10),
                  ),
                  minY: 0,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 150,
              color: Colors.grey[200],
              child: Center(
                  child: Text(
                "あなたの実際に課題にかけた時間は\n見積もり時間のおおよそ${my_ratio_average().toStringAsFixed(2)}倍です。\n\nほかの人の実際に課題にかけた時間は\n見積もり時間のおおよそ${ratio_average().toStringAsFixed(2)}倍です。",
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              )),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    "自分と他の人のデータの比較結果",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "他の人のデータを1.0とする\n自分のデータは他の人のデータに対する倍率とする",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: rawDataSets()
                    .asMap()
                    .map((index, value) {
                      final isSelected = index == selectedDataSetIndex;
                      return MapEntry(
                        index,
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDataSetIndex = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            height: 26,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.green
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(46),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 6,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInToLinear,
                                  padding: EdgeInsets.all(isSelected ? 8 : 6),
                                  decoration: BoxDecoration(
                                    color: value.color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInToLinear,
                                  style: TextStyle(
                                    color: isSelected
                                        ? value.color
                                        : widget.gridColor,
                                  ),
                                  child: Text(value.title),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                    .values
                    .toList(),
              ),
            ),
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width - 150,
              child: RadarChart(
                RadarChartData(
                  // read about it in the RadarChartData section
                  titleTextStyle:
                      TextStyle(color: widget.titleColor, fontSize: 14),
                  dataSets: showingDataSets(),
                  radarBorderData: const BorderSide(color: Colors.transparent),
                  titlePositionPercentageOffset: 0.2,
                  getTitle: (index, angle) {
                    final usedAngle =
                        relativeAngleMode ? angle + angleValue : angleValue;
                    switch (index) {
                      case 0:
                        return RadarChartTitle(
                          text: '倍率',
                          angle: usedAngle,
                        );
                      case 2:
                        return RadarChartTitle(
                          text: '見積もり時間',
                          angle: usedAngle,
                        );
                      case 1:
                        return RadarChartTitle(
                            text: '実際にかけた時間', angle: usedAngle);
                      default:
                        return const RadarChartTitle(text: '');
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                width: double.infinity,
                height: 100,
                color: Colors.grey[200],
                child: Center(
                  child: Text(
                    '他の人のデータ',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                )),
            SizedBox(
              height: 100,
            ),
            Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    '他の人の見積もり時間と\n実際にかけた時間の関係',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    '(見積もり時間)<=(実際にかけた時間)となる課題の個数',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    '(見積もり時間)>(実際にかけた時間)となる課題の個数',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width - 150,
              child: PieChart(
                PieChartData(
                  sections: showingSections(),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      final index = entry.key;
      final rawDataSet = entry.value;

      final isSelected = index == selectedDataSetIndex
          ? true
          : selectedDataSetIndex == -1
              ? true
              : false;

      return RadarDataSet(
        fillColor: isSelected
            ? rawDataSet.color.withOpacity(0.2)
            : rawDataSet.color.withOpacity(0.05),
        borderColor:
            isSelected ? rawDataSet.color : rawDataSet.color.withOpacity(0.25),
        entryRadius: isSelected ? 3 : 2,
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: isSelected ? 2.3 : 2,
      );
    }).toList();
  }

  List<RawDataSet> rawDataSets() {
    return [
      RawDataSet(
        title: '自分の平均',
        color: widget.myColor,
        values: [
          my_ratio_average() / ratio_average(),
          my_duration_average() / duration_average(),
          my_realduration_average() / realduration_average(),
        ],
      ),
      RawDataSet(
        title: '他の人の平均',
        color: widget.othersColor,
        values: [
          1.0,
          1.0,
          1.0,
        ],
      ),
    ];
  }

  List<PieChartSectionData> showingSections() {
    return [
      PieChartSectionData(
        color: Colors.green,
        value: num_big_predict(),
        title: '${num_big_predict().toInt()}個',
        titleStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.purple,
        value: num_small_predict(),
        title: '${num_small_predict().toInt()}個',
        titleStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }
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

SideTitles get _bottomTitles => SideTitles(
      showTitles: true,
      interval: 1,
      getTitlesWidget: (value, meta) {
        String text = '';
        int id = value.toInt();
        List<TaskModel> done_task = get_done_task_DB(db.task_DB);
        List<SortTaskModel> sorted_list = get_sorted_list(done_task);

        for (int i = 0; i < sorted_list.length; i++) {
          if (sorted_list[i].id == id) {
            String month = sorted_list[i].deadline.month.toString();
            String day = sorted_list[i].deadline.day.toString();
            text = month + "/" + day;
          }
        }
        return Text(text);
      },
    );
