
import 'package:fund_app/redux/state/app_state.dart';
import 'package:redux/redux.dart';

class FundReturnViewModel {

  final List<FundPerformanceClass> payload;
  final List<FundReturnHistoryClass> payload2;


  FundReturnViewModel({
    required this.payload,
    required this.payload2,
  });

  static FundReturnViewModel fromStore(Store<AppState> store) {
    return FundReturnViewModel(
      payload: store.state.fundReturnState.payload,
      payload2: store.state.fundReturnState.payload2,
    );
  }
}


class FundPerformanceClass {
  var datePeriod;
  var thisPercent;
  var avgPercent;


  FundPerformanceClass({
    required this.datePeriod,
    required this.thisPercent,
    required this.avgPercent,
  });

  factory FundPerformanceClass.fromJson(Map<String, dynamic> json) =>
      FundPerformanceClass(
        datePeriod: json["name"],
        thisPercent: json["percent"],
        avgPercent: json["short_code"],
      );
}

class FundReturnHistoryClass {
  var year;
  var value;


  FundReturnHistoryClass({
    required this.year,
    required this.value,
  });

  factory FundReturnHistoryClass.fromJson(Map<String, dynamic> json) =>
      FundReturnHistoryClass(
        year: json["year"],
        value: json["value"],
      );
}