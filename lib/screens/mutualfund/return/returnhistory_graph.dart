import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fund_app/model/fundreturn_viewmodel.dart';

class ReturnHistoryGraph extends StatefulWidget {

  ReturnHistoryGraph({
    required this.viewModel,
  });

  FundReturnViewModel viewModel;

  @override
  State<StatefulWidget> createState() => BarChartSample5State();
}

class BarChartSample5State extends State<ReturnHistoryGraph> {

  double minMax = 0;
  double interval  = 0;
  List<int> yearList = [0];

  dataList(){
    List<FundReturnHistoryClass> rawList = widget.viewModel.payload2;
    List<BarChartGroupData> outputList = [];
    List<int> yearListDetail = [0];
    int i = 1;

    for (FundReturnHistoryClass data in rawList){
      if (data.value != null){
        yearListDetail.add(data.year);
        var x =  BarChartGroupData(x: i++, barRods: [
          BarChartRodData(y: data.value, width: 15, colors: [data.value > 0 ? Colors.greenAccent : Colors.redAccent], borderRadius: const BorderRadius.all(Radius.circular(2))),
        ]);
        outputList.add(x);
        if (data.value.abs() > minMax){
          minMax = data.value;
        }
      }

    }
    return outputList;
  }

  void initValue() {

    List<FundReturnHistoryClass> rawList = widget.viewModel.payload2;

    for (FundReturnHistoryClass data in rawList){
      if (data.value != null){
        yearList.add(data.year);
        if (data.value.abs() > minMax){
          minMax = data.value.abs();
        }
      }
      minMax = ((minMax ~/ 5) * 5.0) ;
      interval = 5;
      if (minMax >= 40){
        interval = 10;
      }

      if (minMax >= 80){
        interval = 20;
      }
    }
  }

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
    initValue();
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
                      int index = group.x.toInt();
                      String weekDay = yearList[index].toString();
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
                maxY: minMax,
                minY: -minMax,
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (value) => const TextStyle(color: Colors.black, fontSize: 10),
                    margin: 10,
                    rotateAngle: 0,
                    getTitles: (double value) {
                      int index = value.toInt();
                      return yearList[index].toString();
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
                    interval: interval, //edit interval
                    margin: 8,
                    reservedSize: 30,
                  ),
                ) ,
                gridData: FlGridData(
                  show: true,
                  checkToShowHorizontalLine: (value) => value % interval == 0, //edit interval
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
                barGroups: dataList()))),
      ),
    );
  }
}
