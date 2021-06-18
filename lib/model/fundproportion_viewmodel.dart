
import 'package:fund_app/redux/state/app_state.dart';
import 'package:redux/redux.dart';

class FundProportionViewModel {

  final String dataDate;
  final List<FundTopHoldClass> payload;


  FundProportionViewModel({
    required this.dataDate,
    required this.payload,
  });

  static FundProportionViewModel fromStore(Store<AppState> store) {
    return FundProportionViewModel(
        dataDate: store.state.fundProportionState.dataDate,
        payload: store.state.fundProportionState.payload,
    );
  }
}


class FundTopHoldClass {
  String name;
  var percent;
  String shortCode;
  String linkUrl;


  FundTopHoldClass({
    required this.name,
    required this.percent,
    required this.shortCode,
    required this.linkUrl,
  });

  factory FundTopHoldClass.fromJson(Map<String, dynamic> json) =>
      FundTopHoldClass(
        name: json["name"],
        percent: json["percent"],
        shortCode: json["short_code"],
        linkUrl: json["link_url"],
      );
}