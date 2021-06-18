import 'package:fund_app/model/funddetail_viewmodel.dart';
import 'package:fund_app/model/fundproportion_viewmodel.dart';
import 'package:meta/meta.dart';

@immutable
class FundProportionState {

  final String dataDate;
  final List<FundTopHoldClass> payload;


  FundProportionState({
    required this.dataDate,
    required this.payload,

  });

  factory FundProportionState.initial() {
    return new FundProportionState(
        dataDate: "",
        payload: []);
  }

  factory FundProportionState.loadFund({
    required String dataDate,
    required List<FundTopHoldClass> payload}) {
    return new FundProportionState(
        dataDate: dataDate,
        payload: payload );
  }
}



