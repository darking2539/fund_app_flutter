import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fund_app/model/mutualfund_viewmodel.dart';
import 'package:fund_app/redux/actions/funddetail_actions.dart';
import 'package:http/http.dart' as http;

class TopFund extends StatefulWidget {

  TopFund({required this.store,required this.viewModel});
  MutualFundViewModel viewModel;
  final store;

  @override
  _TopFundState createState() => _TopFundState();
}

class _TopFundState extends State<TopFund> {

  final List<bool> isSelected = [
    true,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<TopFundClass> data = [];
  final valueSelected = [
    "YTD",
    "1D",
    "1W",
    "1M",
    "3M",
    "6M",
    "1Y",
    "3Y",
    "5Y",
    "10Y"
  ];
  var length = 0;

  void initState() {
    loadingTopFund(0);
    super.initState();
  }

  clickFund(finId) {

    widget.store.dispatch(loadingFundAction(finId));
    //widget.viewModel.clickFund(finId);

  }

  void loadingTopFund(index) async {
    var response = await http.get(Uri.parse(
        'https://www.finnomena.com/fn3/api/fund/public/filter/overview?page=1&period=${valueSelected[index]}'));
    var list = json.decode(response.body)['data'];
    data = List<TopFundClass>.from(
        list.map((model) => TopFundClass.fromJson(model)));
    length = data.length;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(height: 10),
        Container(
            padding: const EdgeInsets.all(10.0),
            child: Center(child: selectedTime())),
        Expanded(child: topFundScreen()),
      ],
    );
  }

  Widget selectedTime() => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ToggleButtons(
        borderColor: Colors.blueGrey[400],
        fillColor: Colors.lightBlueAccent[100],
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderWidth: 2,
        selectedBorderColor: Colors.blueGrey[800],
        selectedColor: Colors.blueGrey[800],
        splashColor: Colors.blueGrey,
        children: <Widget>[
          // first button
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'YTD',
            ),
          ),
          // second button
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '1D',
            ),
          ),
          // third button
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '1W',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '1M',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '3M',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '6M',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '1Y',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '3Y',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '5Y',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '10Y',
            ),
          ),
        ],
        // logic for button selection below
        onPressed: (int index) {
          setState(() {
            for (int i = 0; i < isSelected.length; i++) {
              isSelected[i] = i == index;
            }
            loadingTopFund(index);
          });
        },
        isSelected: isSelected,
      ));

  Widget topFundScreen() => ListView.builder(
      padding: EdgeInsets.all(10.0) ,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: fundTemplate(data[index].shortCode, data[index].fundManager,
              data[index].finId, data[index].nav, data[index].returnPerf),
        );
      });

  Widget fundTemplate(shortCode, fundManager, finId, nav, returnPerf) => Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.green, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.greenAccent[100],
      child: InkWell(
        onTap: () {
        clickFund(finId);
      },
      child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(children: <Widget>[
            Icon(Icons.thumb_up, color: Colors.green),
            Container(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(shortCode, style: TextStyle(color: Colors.green[800])),
                Container(height: 5),
                Text(fundManager, style: TextStyle(color: Colors.grey[800])),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text("Nav: ${nav.toString()}",
                    style: TextStyle(color: Colors.green[800])),
                Text("%Abs Return",
                    style: TextStyle(color: Colors.black)),
                Text("${returnPerf.toString()}%",
                    style: TextStyle(color: Colors.green[800]))
              ],
            ),
          ]))));
}

class TopFundClass {
  String finId;
  String shortCode;
  String fundManager;
  String navDate;
  double nav;
  double returnPerf;

  TopFundClass(
      {required this.finId,
      required this.shortCode,
      required this.fundManager,
      required this.navDate,
      required this.nav,
      required this.returnPerf});

  factory TopFundClass.fromJson(Map<String, dynamic> json) => TopFundClass(
      finId: json["mstar_id"],
      shortCode: json["thailand_fund_code"],
      navDate: json["nav_date"],
      nav: json["nav"],
      returnPerf: json["return_perf"],
      fundManager: json["amc_name"]);
}
