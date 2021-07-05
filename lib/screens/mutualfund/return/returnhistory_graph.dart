import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ReturnHistoryGraph extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSample5State();
}

class BarChartSample5State extends State<ReturnHistoryGraph> {

  exampleList() {
    return [
    BarChartGroupData(x: 1, barRods: [
      BarChartRodData(y: -5.23, width: 15, colors: [Colors.redAccent], borderRadius: const BorderRadius.all(Radius.circular(2))),
    ]),
    BarChartGroupData(x: 2, barRods: [
      BarChartRodData(y: 8.45, width: 15, colors: [Colors.greenAccent], borderRadius: const BorderRadius.all(Radius.circular(2))),
    ]),
    BarChartGroupData(x: 3, barRods: [
      BarChartRodData(y: -7.65, width: 15, colors: [Colors.redAccent], borderRadius: const BorderRadius.all(Radius.circular(2))),
    ]),
    BarChartGroupData(x: 4, barRods: [
      BarChartRodData(y: 2.41, width: 15, colors: [Colors.greenAccent], borderRadius: const BorderRadius.all(Radius.circular(2))),
    ]),
    BarChartGroupData(x: 5, barRods: [
      BarChartRodData(y: 9.20, width: 15, colors: [Colors.greenAccent], borderRadius: const BorderRadius.all(Radius.circular(2))),
    ]),
    BarChartGroupData(x: 6, barRods: [
      BarChartRodData(y: 5.4, width: 15, colors: [Colors.greenAccent], borderRadius: const BorderRadius.all(Radius.circular(2))),
    ]),
    BarChartGroupData(x: 7, barRods: [
      BarChartRodData(y: -7.6, width: 15, colors: [Colors.redAccent], borderRadius: const BorderRadius.all(Radius.circular(2))),
    ]),
  ];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: Colors.blueGrey[300],
        child: Padding(
            padding: const EdgeInsets.only(top: 40, right: 30, bottom: 30),
            child: BarChart(BarChartData(
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.black38,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      String weekDay;
                      switch (group.x.toInt()) {
                        case 1:
                          weekDay = '2014';
                          break;
                        case 2:
                          weekDay = '2015';
                          break;
                        case 3:
                          weekDay = '2016';
                          break;
                        case 4:
                          weekDay = '2017';
                          break;
                        case 5:
                          weekDay = '2018';
                          break;
                        case 6:
                          weekDay = '2019';
                          break;
                        case 7:
                          weekDay = '2020';
                          break;
                        default:
                          throw Error();
                      }
                      return BarTooltipItem(
                        weekDay + '\n',
                        TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: (rod.y).toString() + '%',
                            style: TextStyle(
                              color: rod.y > 0 ? Colors.greenAccent : Colors.redAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    }),

              ),
                maxY: 10,
                minY: -10,
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (value) => const TextStyle(color: Colors.black, fontSize: 10),
                    margin: 10,
                    rotateAngle: 0,
                    getTitles: (double value) {
                      switch (value.toInt()) {
                        case 1:
                          return '2014';
                        case 2:
                          return '2015';
                        case 3:
                          return '2016';
                        case 4:
                          return '2017';
                        case 5:
                          return '2018';
                        case 6:
                          return '2019';
                        case 7:
                          return '2020';
                        default:
                          return '';
                      }
                    },
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (value) => const TextStyle(color: Colors.black, fontSize: 10),
                    rotateAngle: 0,
                    getTitles: (double value) {
                      if (value == 0) {
                        return '0';
                      }
                      return '${value.toInt()}%';
                    },
                    interval: 5,
                    margin: 8,
                    reservedSize: 30,
                  ),
                ) ,
                gridData: FlGridData(
                  show: true,
                  checkToShowHorizontalLine: (value) => value % 5 == 0,
                  getDrawingHorizontalLine: (value) {
                    if (value == 0) {
                      return FlLine(color: Color(0xff2a2747), strokeWidth: 0.4);
                    }
                    return FlLine(
                      color: const Color(0xff2a2747),
                      strokeWidth: 0.2,
                    );
                  },
                ),
                borderData: FlBorderData(
                    show: true,
                    border: Border(
                        bottom: BorderSide(width: 0.5, color: Color(0xff2a2747) ))),
                groupsSpace: 10,
                barGroups: exampleList()))),
      ),
    );
  }
}
