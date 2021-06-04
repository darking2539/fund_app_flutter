import 'package:flutter/material.dart';
import 'package:fund_app/model/funddetail_viewmodel.dart';
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

      var response = await fetchFund(finId);
      var data_rb = jsonDecode(response.body);

      var response2 = await fetchFund2(finId);
      var nav_rb = jsonDecode(response2.body);


      FundDetailClass result_data = FundDetailClass.fromJson(data_rb);
      FundNavClass result_nav = FundNavClass.fromJson(nav_rb);

      var f = NumberFormat("#,###.##");
      print(f.format(result_data.netAsset));


      Future.delayed(const Duration(milliseconds: 1000), () {
        store.dispatch(LoadFundSuccessAction(result_data,result_nav));
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



Future<http.Response> fetchFund(finId) {
  return http.get(Uri.parse('https://www.finnomena.com/fn3/api/fund/public/$finId/overview'));
}

Future<http.Response> fetchFund2(finId) {
  return http.get(Uri.parse('https://www.finnomena.com/fn3/api/fund/nav/latest?fund=$finId'));
}
