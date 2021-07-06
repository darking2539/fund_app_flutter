import 'package:flutter/material.dart';
import 'package:fund_app/model/funddetail_viewmodel.dart';
import 'package:fund_app/model/fundproportion_viewmodel.dart';
import 'package:fund_app/model/fundreturn_viewmodel.dart';
import 'package:fund_app/navigation/navigation.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import "package:intl/intl.dart";


ThunkAction loadingFundAction(finId) {
  return (Store store) async {
    new Future(() async{
      EasyLoading.show(status: 'Downloading...');
      store.dispatch(LoadFundAction());

      var response = await fetchFund(finId); //fund detail overview page
      var data_rb = jsonDecode(response.body);

      var response2 = await fetchFund2(finId); //fund nav overview page
      var nav_rb = jsonDecode(response2.body);

      var response3 = await fetchFund3(finId); //fund nav proportion page
      var list3 = json.decode(response3.body)['top_holdings'][0]['assets'];
      var dataDate3 = json.decode(response3.body)['top_holdings'][0]['data_date'];

      var response4 = await fetchFund4(finId); //proportion page
      var list4 = json.decode(response4.body)['assetallocationbreakdown']['assets'];

      var response5 = await fetchFund5(finId); //proportion page
      var list5 = json.decode(response5.body)['return'];

      //overview
      FundDetailClass result_data = FundDetailClass.fromJson(data_rb);
      FundNavClass result_nav = FundNavClass.fromJson(nav_rb);

      //proportion
      List<FundTopHoldClass> topHoldings = List<FundTopHoldClass>.from(list3.map((model)=> FundTopHoldClass.fromJson(model)));
      List<InvestmentProportionClass> investmentProportion = List<InvestmentProportionClass>.from(list4.map((model)=> InvestmentProportionClass.fromJson(model)));

      //return
      List<FundPerformanceClass> performance = [];
      List<FundReturnHistoryClass> returnHistory = List<FundReturnHistoryClass>.from(list5.map((model)=> FundReturnHistoryClass.fromJson(model)));


      var f = NumberFormat("#,###.##");


      Future.delayed(const Duration(milliseconds: 100), () {
        store.dispatch(LoadProportionAction(dataDate3, topHoldings, investmentProportion));
        store.dispatch(LoadReturnAction(performance, returnHistory));
        store.dispatch(LoadFundSuccessAction(result_data, result_nav));
        EasyLoading.showSuccess('Loading Data Successful!');
        Keys.navKey.currentState!.pushNamed(Routes.fundDetail);
      });


    });
  };
}


class LoadFundAction {
  LoadFundAction();
}

class LoadFundSuccessAction {
  final FundDetailClass payload_1;
  final FundNavClass payload_2;
  LoadFundSuccessAction(this.payload_1,this.payload_2);
}

class LoadFundFailedAction {
  LoadFundFailedAction();
}

class LoadProportionAction {
  final String navDate;
  final List<FundTopHoldClass> payload;
  final List<InvestmentProportionClass> payload2;
  LoadProportionAction(this.navDate,this.payload, this.payload2);
}

class LoadReturnAction {
  final List<FundPerformanceClass> payload;
  final List<FundReturnHistoryClass> payload2;
  LoadReturnAction(this.payload, this.payload2);
}


Future<http.Response> fetchFund(finId) {
  return http.get(Uri.parse('https://www.finnomena.com/fn3/api/fund/public/$finId/overview'));
}

Future<http.Response> fetchFund2(finId) {
  return http.get(Uri.parse('https://www.finnomena.com/fn3/api/fund/nav/latest?fund=$finId'));
}

Future<http.Response> fetchFund3(finId) {
  return http.get(Uri.parse('https://www.finnomena.com/fn3/api/fund/public/topholdings/$finId'));
}

Future<http.Response> fetchFund4(finId) {
  return http.get(Uri.parse('https://www.finnomena.com/fn3/api/fund/public/$finId/breakdown'));
}

Future<http.Response> fetchFund5(finId) {
  return http.get(Uri.parse('https://www.finnomena.com/fn3/api/fund/public/$finId/performance'));
}