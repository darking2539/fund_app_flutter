import 'package:flutter/material.dart';
import 'package:fund_app/model/mutualfund_viewmodel.dart';
import 'package:fund_app/navigation/navigation.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'funddetail_actions.dart';


ThunkAction loadingListAction() {
  return (Store store) async {
    new Future(() async{
      EasyLoading.show(status: 'Downloading...');
      store.dispatch(LoadListAction());

      var response = await fetchFund();
      var rb = response.body;
      var list = json.decode(rb) ;
      List<FundClass> data = List<FundClass>.from(list.map((model)=> FundClass.fromJson(model)));

      Future.delayed(const Duration(milliseconds: 1000), () {
        store.dispatch(LoadListSuccessAction(data));
        EasyLoading.showSuccess('Loading Data Successful!');
      });


    });
  };
}

ThunkAction cLickFundAction(fundClass) {
  return (Store store) async {
    new Future(() async{
      store.dispatch(new ClickFundAction());
      var response = await fetchFund();
      var rb = response.body;
      var list = json.decode(rb) ;
      List<FundClass> data = List<FundClass>.from(list.map((model)=> FundClass.fromJson(model)));
      store.dispatch(ClickFundSuccessAction(data,fundClass));
      Keys.navKey.currentState!.pushNamed(Routes.fundDetail);

    });
  };
}

class LoadListAction {
  LoadListAction();
}

class LoadListSuccessAction {
  final List<FundClass> payload;
  LoadListSuccessAction(this.payload);
}

class LoadListFailedAction {
  LoadListFailedAction();
}


class ClickFundAction {
  ClickFundAction();
}

class ClickFundSuccessAction {
  final List<FundClass> payload_1;
  final String payload_2;
  ClickFundSuccessAction(this.payload_1,this.payload_2);
}

class ClickFundFailedAction {
  ClickFundFailedAction();
}


Future<http.Response> fetchFund() {
  return http.get(Uri.parse('https://www.finnomena.com/fn3/api/fund/public/list'));
}

