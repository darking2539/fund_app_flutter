import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fund_app/screens/authentication/login/login.dart';
import 'package:fund_app/widgets/CustomGestureDetector.dart';

class MyPortfolioScreen extends StatefulWidget {
  @override
  _FolioScreenState createState() => _FolioScreenState();
}

class _FolioScreenState extends State<MyPortfolioScreen> {


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  bool isDealer = true;
  bool status = false;



  @override
  Widget build(BuildContext context) {

    double height= MediaQuery.of(context).size.height;
    double threshold = 100;

    double bottomValue(login) {
      if(login == false){
        return -(height/3);
      }
      else{
        return -height*2;
      }

    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('My Portfolio'),
          leading: Icon(Icons.account_circle_rounded),
          actions: <Widget>[
            IconButton(
                onPressed: () {

                  setState(() {
                    status = !status;
                  });

                },
                icon: Icon(Icons.add))
          ],
        ),
        backgroundColor: Colors.white,
        body: CustomGestureDetector(
          axis: CustomGestureDetector.AXIS_Y,
          velocity: threshold,
          onSwipeUp: (){},
          onSwipeDown: (){},
          onSwipeRight: (){},
          onSwipeLeft: (){},
          child: Container(
            height: height,
            child: Stack(
              children: <Widget>[
                AnimatedPositioned(
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 200),
                    left: 0,
                    bottom: bottomValue(status),
                    child: MenuWidget())

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height * 3;
    double width = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      child: Container(
        color: Colors.blueGrey[200],
        width: width,
        height: height/2.8,
          child: LoginPage(),
      ),
    );
  }
}