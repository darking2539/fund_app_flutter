import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fund_app/model/funddetail_viewmodel.dart';
import 'package:fund_app/redux/state/app_state.dart';
import 'package:intl/intl.dart';

import 'graph_detail.dart';

class MutualFundOverview extends StatelessWidget {
  var numFormat = NumberFormat("#,###.##");

  colorNav(value, dayChange) {
    if (double.parse(dayChange) >= 0)
      return Text("$value (+$dayChange%)",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.green));
    else
      return Text("$value ($dayChange%)",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FundDetailViewModel>(
        converter: (store) => FundDetailViewModel.fromStore(store),
        builder: (BuildContext context, FundDetailViewModel viewModel) {
          return Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.only(top: 15 ,left: 25,right: 25,bottom: 25),
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("${viewModel.payload_1.shortCode}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                ),
                topShow(viewModel),
                Container(height: 10),
                totalFundValue(viewModel),
                Container(height: 20),
                GraphDetail(),
                Container(height: 20),
                strategy(viewModel),
              ],
            ),
          );
        });
  }

  Widget topShow(viewModel) => Container(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(height: 5),
              Container(
                width: 160,
                child: Text('${viewModel.payload_1.thName}',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 12)),
              ),
              Container(height: 5),
              Text("NAV (${viewModel.payload_2.navDate})",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: Colors.blueGrey[800])),
              Container(height: 5),
              colorNav(
                  viewModel.payload_2.value, viewModel.payload_2.dayChange),
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.only(left: 10),
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(height: 5),
                Container(
                    width: 160,
                    child: Text("Risk: ${viewModel.payload_1.riskSpectrum}",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 12))),
                Container(height: 5),
                Text("${viewModel.payload_1.engCategory}",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 12)),
                Text("(${viewModel.payload_1.thCategory})",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 10)),
                Container(height: 5),
                Text("Dividend: ${viewModel.payload_1.diViDeNedPolicy}",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 12)),
                Container(height: 5),
              ],
            ),
          ),
        ],
      ));

  Widget totalFundValue(viewModel) => Container(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Total Fund Value:",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: Colors.blueGrey[800])),
          Container(width: 5),
          Text("${numFormat.format(viewModel.payload_1.netAsset)}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.blueGrey[800])),
        ],
      ));

  Widget strategy(viewModel) => Container(
          child: Column(children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            child: Text("Investment Strategy",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black))),
        Container(height: 5),
        Container(
            child: Center(
                child: Text("${viewModel.payload_1.investmentStrategy}",
                    style: TextStyle(
                        color: Colors.black),
                  textAlign: TextAlign.start
                ))),
      ]));
}
