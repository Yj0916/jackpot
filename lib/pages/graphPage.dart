import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jackpot/style.dart' as style;
import 'package:jackpot/service/data.dart';
import 'package:fl_chart/fl_chart.dart';

class GraphPage extends StatefulWidget {
  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex;
  int dataIndex = 3;
  bool isPlaying = false;
  List<String> stringList = ["습도", "광량", "토양 습도", "온도", "수위"];
  int cnt = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FutureBuilder(
            future: reportRetrieve(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData == false) {
                return Container(
                  padding: EdgeInsets.all(200),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(fontSize: 15),
                  ),
                );
              } else {
                List<List<String>> reportInfo = [];
                snapshot.data.data.forEach((key, value) {
                  reportInfo.add(parseText(value));
                });
                reportInfo = reportInfo.sublist(reportInfo.length - 7);
                reportInfo.sort((a, b) => (DateTime(
                        int.parse(a[0]), int.parse(a[1]), int.parse(a[2])))
                    .compareTo(DateTime(
                        int.parse(b[0]), int.parse(b[1]), int.parse(b[2]))));
                return Container(
                    margin: EdgeInsets.only(top: 80, left: 20, right: 20),
                    child: AspectRatio(
                      aspectRatio: 0.8,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        color: Colors.white,
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    'JackPot 상태',
                                    style: TextStyle(
                                        color: style.mainBlue,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    stringList[dataIndex - 3],
                                    style: TextStyle(
                                        color: style.lightBlue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 38,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: BarChart(
                                        mainBarData(reportInfo),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FlatButton(
                                          onPressed: () {
                                            setState(() {
                                              if (dataIndex > 3) {
                                                dataIndex--;
                                                print(dataIndex);
                                              }
                                            });
                                          },
                                          child: Container(
                                              color: style.lightBlue,
                                              child: Icon(Icons.arrow_left,
                                                  color: Colors.white))),
                                      Text(
                                          (dataIndex - 2).toString() +
                                              '/' +
                                              '5',
                                          style: TextStyle(
                                              color: style.mainBlue,
                                              fontWeight: FontWeight.bold)),
                                      FlatButton(
                                          onPressed: () {
                                            setState(() {
                                              if (dataIndex < 7) {
                                                dataIndex++;
                                                print(dataIndex);
                                              }
                                            });
                                          },
                                          child: Container(
                                              color: style.lightBlue,
                                              child: Icon(
                                                Icons.arrow_right,
                                                color: Colors.white,
                                              ))),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
              }
            },
          )
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = const Color(0xffb4deff),
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          color: isTouched ? Colors.yellow : barColor,
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups(List<List<String>> reportInfo) =>
      List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, double.parse(reportInfo[0][dataIndex]),
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, double.parse(reportInfo[1][dataIndex]),
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, double.parse(reportInfo[2][dataIndex]),
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, double.parse(reportInfo[3][dataIndex]),
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, double.parse(reportInfo[4][dataIndex]),
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, double.parse(reportInfo[5][dataIndex]),
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, double.parse(reportInfo[6][dataIndex]),
                isTouched: i == touchedIndex);
          default:
            return null;
        }
      });

  BarChartData mainBarData(List<List<String>> reportInfo) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = reportInfo[group.x.toInt()][1] +
                      '/' +
                      reportInfo[group.x.toInt()][2];
                  break;
                case 1:
                  weekDay = reportInfo[group.x.toInt()][1] +
                      '/' +
                      reportInfo[group.x.toInt()][2];
                  break;
                case 2:
                  weekDay = reportInfo[group.x.toInt()][1] +
                      '/' +
                      reportInfo[group.x.toInt()][2];
                  break;
                case 3:
                  weekDay = reportInfo[group.x.toInt()][1] +
                      '/' +
                      reportInfo[group.x.toInt()][2];
                  break;
                case 4:
                  weekDay = reportInfo[group.x.toInt()][1] +
                      '/' +
                      reportInfo[group.x.toInt()][2];
                  break;
                case 5:
                  weekDay = reportInfo[group.x.toInt()][1] +
                      '/' +
                      reportInfo[group.x.toInt()][2];
                  break;
                case 6:
                  weekDay = reportInfo[group.x.toInt()][1] +
                      '/' +
                      reportInfo[group.x.toInt()][2];
                  break;
              }
              return BarTooltipItem(weekDay + '\n' + (rod.y - 1).toString(),
                  TextStyle(color: Colors.yellow));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(
                color: style.greyText,
                fontWeight: FontWeight.bold,
                fontSize: 12),
            margin: 16,
            getTitles: (double value) {
              print(value);
              int idx = value.toInt();
              if(cnt%3 ==0){
                cnt++;
                return idx.toString();
              }
              else{
                cnt++;
                return "";
              }
            }),
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
              color: style.greyText, fontWeight: FontWeight.bold, fontSize: 12),
          margin: 16,
          getTitles: (double value) {
            int idx = value.toInt();
            switch (idx) {
              case 0:
                return reportInfo[idx][1] + '/' + reportInfo[idx][2];
              case 1:
                return reportInfo[idx][1] + '/' + reportInfo[idx][2];
              case 2:
                return reportInfo[idx][1] + '/' + reportInfo[idx][2];
              case 3:
                return reportInfo[idx][1] + '/' + reportInfo[idx][2];
              case 4:
                return reportInfo[idx][1] + '/' + reportInfo[idx][2];
              case 5:
                return reportInfo[idx][1] + '/' + reportInfo[idx][2];
              case 6:
                return reportInfo[idx][1] + '/' + reportInfo[idx][2];
              default:
                return '';
            }
          },
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(reportInfo),
    );
  }
}
