import 'package:fund_app/redux/actions/mutualfund_actions.dart';
import 'package:fund_app/redux/state/app_state.dart';
import 'package:redux/redux.dart';


class MutualFundViewModel {
  final bool isLoading;
  final bool loadingError;
  final List<FundClass> payload_1;
  final String payload_2;

  final Function() loadingList;
  final Function(String) clickFund;

  MutualFundViewModel({
    required this.isLoading,
    required this.loadingError,
    required this.payload_1,
    required this.payload_2,
    required this.loadingList,
    required this.clickFund,
  });

  static MutualFundViewModel fromStore(Store<AppState> store) {
    return MutualFundViewModel(
      isLoading: store.state.mutualFundState.isLoading,
      loadingError: store.state.mutualFundState.loadingError,
      payload_1: store.state.mutualFundState.payload_1,
      payload_2: store.state.mutualFundState.payload_2,
      loadingList: () {
        store.dispatch(loadingListAction());
      },
      clickFund: (String fundClass) {
        store.dispatch(cLickFundAction(fundClass));
      },
    );
  }
}


class FundClass {
  String finId;
  String shortCode;
  String thName;

  FundClass({
    required this.finId,
    required this.shortCode,
    required this.thName
  });

  factory FundClass.fromJson(Map<String, dynamic> json) => FundClass(
    finId: json["id"],
    shortCode: json["short_code"],
    thName: json["name_th"],
  );

  factory FundClass.fromJson2(Map<String, dynamic> json) {

  return FundClass(
    finId: json["mstar_id"],
    shortCode: json["thailand_fund_code"],
    thName: json["amc_name"],
  );
  }


}

