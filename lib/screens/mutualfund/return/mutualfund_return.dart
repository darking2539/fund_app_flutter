import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fund_app/model/fundreturn_viewmodel.dart';
import 'package:fund_app/redux/state/app_state.dart';
import 'package:fund_app/screens/mutualfund/return/performance.dart';
import 'package:fund_app/screens/mutualfund/return/returnhistory.dart';

class MutualFundReturn extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FundReturnViewModel>(
        converter: (store) => FundReturnViewModel.fromStore(store),
        builder: (BuildContext context, FundReturnViewModel viewModel) {
          return Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              padding:
              EdgeInsets.only(top: 15, left: 25, right: 25, bottom: 25),
              children: <Widget>[
                Container(height: 5),
                Container(child: Performance(viewModel: viewModel)),
                Container(height: 20),
                Container(child: ReturnHistory(viewModel: viewModel)),
              ],
            ),
          );
        });
  }
}
