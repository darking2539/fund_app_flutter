import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fund_app/model/funddetail_viewmodel.dart';
import 'package:fund_app/model/mutualfund_viewmodel.dart';
import 'package:fund_app/redux/state/app_state.dart';
import 'package:fund_app/screens/mutualfund/proportion/mutualfund_proportion.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'overview/mutualfund_overview.dart';

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

class MutualFundDetail extends StatefulWidget {

  MutualFundDetail({
    required this.viewModel_1,
    required this.viewModel_2,
  });

  FundDetailViewModel viewModel_1;
  MutualFundViewModel viewModel_2;

  @override
  _MutualFundDetailState createState() => _MutualFundDetailState();
}

class _MutualFundDetailState extends State<MutualFundDetail> {
  var padding = EdgeInsets.symmetric(horizontal: 18, vertical: 5);
  double gap = 10;

  int _index = 0;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  List<Widget> _widgetOptions = <Widget>[
    MutualFundOverview(),
    Container(child: Center(child: Text("Return"))),
    MutualFundProportion(),
    Container(child: Center(child: Text("Fee"))),
  ];

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FundDetailViewModel>(
        converter: (store) => FundDetailViewModel.fromStore(store),
        builder: (BuildContext context, FundDetailViewModel viewModel) {
          return Scaffold(
                appBar: AppBar(
                  title: Text('${viewModel.payload_1.shortCode}'),
                  actions: <Widget>[
                    IconButton(
                        onPressed: () {
                          showAlertDialog(context);
                        },
                        icon: Icon(Icons.favorite_border))
                  ],
                ),
                body: Column(children: <Widget>[
                  Container(height: 5),
                  SafeArea(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: -10,
                              blurRadius: 60,
                              color: Colors.black.withOpacity(0.4),
                              offset: Offset(0, 25),
                            )
                          ]),
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: GNav(
                          curve: Curves.fastOutSlowIn,
                          duration: Duration(milliseconds: 900),
                          tabs: [
                            GButton(
                              gap: gap,
                              icon: LineIcons.home,
                              iconColor: Colors.black,
                              iconActiveColor: Colors.purple,
                              text: 'Overview',
                              textColor: Colors.purple,
                              backgroundColor: Colors.purple.withOpacity(0.2),
                              iconSize: 20,
                              padding: padding,
                            ),
                            GButton(
                              gap: gap,
                              icon: LineIcons.dollarSign,
                              iconColor: Colors.black,
                              iconActiveColor: Colors.pink,
                              text: 'Return',
                              textColor: Colors.pink,
                              backgroundColor: Colors.pink.withOpacity(0.2),
                              iconSize: 20,
                              padding: padding,
                            ),
                            GButton(
                              gap: gap,
                              icon: LineIcons.pieChart,
                              iconColor: Colors.black,
                              iconActiveColor: Colors.lightBlueAccent,
                              text: 'Proportion',
                              textColor: Colors.lightBlueAccent,
                              backgroundColor: Colors.lightBlueAccent.withOpacity(0.2),
                              iconSize: 20,
                              padding: padding,
                            ),
                            GButton(
                              gap: gap,
                              icon: LineIcons.commentDollar,
                              iconColor: Colors.black,
                              iconActiveColor: Colors.teal,
                              text: 'Fee',
                              textColor: Colors.teal,
                              backgroundColor: Colors.teal.withOpacity(0.2),
                              iconSize: 20,
                              padding: padding,
                            ),
                          ],
                          selectedIndex: _index,
                          onTabChange: (index) {
                            setState(() {
                              _index = index;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  _widgetOptions.elementAt(_index),


                ])
          );
        }
    );
  }
}
