import 'package:fund_app/model/funddetail_viewmodel.dart';
import 'package:fund_app/model/fundproportion_viewmodel.dart';
import 'package:meta/meta.dart';

@immutable
class FundProportionState {

  final String dataDate;
  final List<FundTopHoldClass> payload;
  final List<InvestmentProportionClass> payload2;


  FundProportionState({
    required this.dataDate,
    required this.payload,
    required this.payload2

  });

  factory FundProportionState.initial() {
    return new FundProportionState(
        dataDate: "",
        payload: [],
        payload2: []
    );
  }

  factory FundProportionState.loadFund({
    required String dataDate,
    required List<FundTopHoldClass> payload,
    required List<InvestmentProportionClass> payload2}) {
    return new FundProportionState(
        dataDate: dataDate,
        payload: payload,
        payload2: payload2);
  }
}



