import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fund_app/model/fundproportion_viewmodel.dart';
import 'package:fund_app/redux/state/app_state.dart';

class MutualFundProportion extends StatelessWidget {
  int touchedIndex = -1;
  var i = 0;
  List colors = [Colors.blue, Colors.redAccent, Colors.greenAccent,Colors.purpleAccent,Colors.deepOrangeAccent,Colors.grey];

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FundProportionViewModel>(
        converter: (store) => FundProportionViewModel.fromStore(store),
        builder: (BuildContext context, FundProportionViewModel viewModel) {
          return Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              padding:
                  EdgeInsets.only(top: 15, left: 25, right: 25, bottom: 25),
              children: <Widget>[
                Container(height: 5),
                Container(child: top5Holding(viewModel)),
              ],
            ),
          );
        });
  }

  Widget top5Holding(viewModel) => Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey.withOpacity(0.4))),
      child: Column(children: <Widget>[
        Container(
            color: Colors.blueGrey.withOpacity(0.2),
            padding: EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            child: Column(children: <Widget>[
              Container(
                  alignment: Alignment.topLeft,
                  child: Text("Top 5 Holding",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25))),
              Container(height: 5),
              Container(
                  alignment: Alignment.topLeft, child: Text('\u{23F1} ${viewModel.dataDate}'))
            ])),
        top5HoldingDonut(viewModel),
        getTextWidgets(viewModel.payload),
        otherHolding(i,"100")
      ]));

  Widget getTextWidgets(List<FundTopHoldClass> list)
  {
    i = 0;
    return Column(children: list.map((item) => Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey.withOpacity(0.4))),
      child: Row(children: <Widget>[
        Container(
          width: 20,
          height: 20,
          decoration: new BoxDecoration(
            color: colors[i++],
            shape: BoxShape.circle,
          ),
        ),
        Container(width: 10),
        Container(
          width: 160,
          child: Text("${item.name} "),
        ),
        Spacer(),
        Container(
            alignment: Alignment.topRight,
            width: 80,
            child: Text("${item.percent.toString()}%"))
      ]),
    )).toList(),
    );
  }

  Widget otherHolding(count,percent) {
    if(count == 5) {
      return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey.withOpacity(0.4))),
        child: Row(children: <Widget>[
          Container(
            width: 20,
            height: 20,
            decoration: new BoxDecoration(
              color: colors[5],
              shape: BoxShape.circle,
            ),
          ),
          Container(width: 10),
          Container(
            width: 150,
            child: Text("Others"),
          ),

        ]),
      );
    } else {
      return Container();
    }
}


  Widget top5HoldingDonut(viewModel) => Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey.withOpacity(0.4))),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: PieChart(
          PieChartData(
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              sections: showingSections(viewModel)),
        ),
      ));

  List<PieChartSectionData> showingSections(viewModel) {

    List list = [];
    for (FundTopHoldClass i in viewModel.payload){
      list.add(i.percent);
    }

    list.add(0.0);
    list.add(0.0);
    list.add(0.0);
    list.add(0.0);

    var sum = list.reduce((a, b) => a + b);

    if(sum>100){
      sum = 0.0;
    }else{
      sum = 100 - sum;
    }

    return List.generate(6, (i) {
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: list[0],
            showTitle: false,
            titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.redAccent,
            value: list[1],
            showTitle: false,
            titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.greenAccent,
            value: list[2],
            showTitle: false,
            titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.purpleAccent,
            value: list[3],
            showTitle: false,
            titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 4:
          return PieChartSectionData(
            color: Colors.deepOrangeAccent,
            value: list[4],
            showTitle: false,
            titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 5:
          return PieChartSectionData(
            color: Colors.grey,
            value: sum,
            showTitle: false,
            titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
