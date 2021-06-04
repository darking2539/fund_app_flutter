import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fund_app/model/funddetail_viewmodel.dart';
import 'package:fund_app/model/mutualfund_viewmodel.dart';
import 'package:fund_app/redux/state/app_state.dart';
import 'package:intl/intl.dart';

class MutualFundDetail extends StatelessWidget {
  MutualFundDetail({
    required this.viewModel_1,
    required this.viewModel_2,
  });

  FundDetailViewModel viewModel_1;
  MutualFundViewModel viewModel_2;
  var numFormat = NumberFormat("#,###.##");

  init() {
    print(viewModel_2.payload_2);
    //viewModel_1.loadingFund(viewModel_2.payload_2);
  }

  //viewModel.payload_2.value
  //viewModel.payload_2.dayChange

  colorNav(value, dayChange) {
    if (double.parse(dayChange) >= 0)
      return Text("$value (+$dayChange%)",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.green));
    else
      return Text("$value ($dayChange%)",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.red));

  }

  void showAlertDialog(context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text("Please Login"),
          content: Text("คุณต้องเข้าสู่ระบบเพื่อติดตามกองทุน"),
          actions: <Widget>[
            // ignore: deprecated_member_use
            OutlineButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Sign in"),
            ),
            // ignore: deprecated_member_use
            OutlineButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Login"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FundDetailViewModel>(
        onInit: init(),
        converter: (store) => FundDetailViewModel.fromStore(store),
        builder: (BuildContext context, FundDetailViewModel viewModel) {
          return Scaffold(
              appBar: AppBar(
                title: Text('${viewModel.payload_1.engName}'),
                actions: <Widget>[
                  IconButton(
                      onPressed: () {
                        showAlertDialog(context);
                      },
                      icon: Icon(Icons.favorite_border))
                ],
              ),
              body: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(alignment: Alignment.topLeft , child: Text("${viewModel.payload_1.shortCode}",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)), ),
                    topShow(viewModel),
                    Container(height: 10),
                    totalFundValue(viewModel),
                    Container(height: 20),
                    graph()
                  ],
                ),
              ));
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
              colorNav(viewModel.payload_2.value,viewModel.payload_2.dayChange),
            ],
          ),
          Spacer(),
          Column(
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

  Widget graph() => Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            "assets/images/graph2.gif",
          )
        ],
      ));
}
