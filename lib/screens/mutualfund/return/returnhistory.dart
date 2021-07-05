import 'package:flutter/material.dart';
import 'package:fund_app/screens/mutualfund/return/returnhistory_graph.dart';

class ReturnHistory extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey.withOpacity(0.4))),
        child: Column(children: <Widget>[
          Container(
              height: 450,
              color: Colors.blueGrey.withOpacity(0.15),
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: Column(children: <Widget>[
                Container(
                    alignment: Alignment.topLeft,
                    child: Text("Return History (Annual)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25))),
                Container(height: 5),
                Container(
                    alignment: Alignment.topLeft,
                    child: Text('(K-SET50)',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.grey[600]))),
                Container(height: 20),
                ReturnHistoryGraph()

              ])),
        ]));
  }
}
