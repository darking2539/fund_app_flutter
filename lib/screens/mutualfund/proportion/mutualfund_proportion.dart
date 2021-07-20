import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fund_app/model/fundproportion_viewmodel.dart';
import 'package:fund_app/redux/state/app_state.dart';
import 'package:fund_app/screens/mutualfund/proportion/investmentproportion.dart';
import 'package:fund_app/screens/mutualfund/proportion/top5holding.dart';

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
                Container(child: Top5Holding(viewModel: viewModel)),
                //Container(height: 20),
                //Container(child: InvestmentProportion(viewModel: viewModel)),  //finomena remove this API
              ],
            ),
          );
        });
  }




}
