import 'package:flutter/material.dart';

class Performance extends StatelessWidget {

  Widget header() {
    return Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[
          Container(width: 80),
          Container(width: 10),
          Container(alignment: Alignment.center, width: 80, child: Text("กองนี้",
              style: TextStyle(
                  fontWeight: FontWeight.bold))),
          Container(width: 10),
          Container(alignment: Alignment.center, width: 80, child: Text("เฉลี่ยในกลุ่ม",
              style: TextStyle(
                  fontWeight: FontWeight.bold))),
          Container(width: 10),
        ]));
  }

  Widget detail(one, two, three) {
    return Column(children: <Widget>[
      Divider(
        height: 35,
        thickness: 1,
        indent: 20,
        endIndent: 20,
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[
        Container(alignment: Alignment.center, width: 80, child: Text("$one")),
        Container(width: 10),
        Container(alignment: Alignment.center, width: 80, child: Text("$two")),
        Container(width: 10),
        Container(alignment: Alignment.center, width: 80, child: Text("$three")),
        Container(width: 10),
      ],
      ),
      Container(height: 5),

    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey.withOpacity(0.4))),
        child: Column(children: <Widget>[
          Container(
              height: 460,
              color: Colors.blueGrey.withOpacity(0.15),
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: Column(children: <Widget>[
                Container(
                    alignment: Alignment.topLeft,
                    child: Text("Performance",
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
                header(),
                detail("3M", "-2.20%", "-2.15%"),
                detail("6M", "5.64%", "5.25%"),
                detail("1Y", "5.50%", "5.57%"),
                detail("3Y", "-1.51%", "-1.89%"),
                detail("5Y", "3.17%", "2.77%"),
                detail("10Y", "5.41%", "5.32%"),
              ])),
        ]));
  }
}
