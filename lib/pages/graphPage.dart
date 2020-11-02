import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jackpot/style.dart'as style;

class graphPage extends StatefulWidget {
  @override
  _graphPageState createState() => _graphPageState();
}

class _graphPageState extends State<graphPage> {

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jackpot',
          style: style.titleStyle,
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black26),
        centerTitle: true,
      ),
      backgroundColor: style.backgroundSkyBlue,
      body: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('주간 그래프',textAlign: TextAlign.center,),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: const Color(0xff37434d),
                          strokeWidth: 1,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: const Color(0xff37434d),
                          strokeWidth: 1,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        textStyle: TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
                        getTitles: (value) {
                          switch (value.toInt()) {
                            case 2:
                              return 'MAR';
                            case 5:
                              return 'JUN';
                            case 8:
                              return 'SEP';
                          }
                          return '';
                        },
                        margin: 8,
                      ),
                      leftTitles: SideTitles(
                        showTitles: true,
                        textStyle : const TextStyle(
                          color: Color(0xff67727d),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        getTitles: (value) {
                          switch (value.toInt()) {
                            case 1:
                              return '10k';
                            case 3:
                              return '30k';
                            case 5:
                              return '50k';
                          }
                          return '';
                        },
                        reservedSize: 28,
                        margin: 12,
                      ),
                    ),
                    borderData:
                    FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
                    minX: 0,
                    maxX: 11,
                    minY: 0,
                    maxY: 6,
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 3),
                          FlSpot(2.6, 2),
                          FlSpot(4.9, 5),
                          FlSpot(6.8, 3.1),
                          FlSpot(8, 4),
                          FlSpot(9.5, 3),
                          FlSpot(11, 4),
                        ],
                        isCurved: true,
                        colors: gradientColors,
                        barWidth: 5,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                          show: false,
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ],
        ),
      )
    );
  }
}
