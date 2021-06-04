import 'package:fund_app/redux/actions/funddetail_actions.dart';
import 'package:fund_app/redux/state/app_state.dart';
import 'package:redux/redux.dart';

class FundDetailViewModel {
  final bool isLoading;
  final bool loadingError;
  final FundDetailClass payload_1;
  final FundNavClass payload_2;

  final Function(String) loadingFund;

  FundDetailViewModel({
    required this.isLoading,
    required this.loadingError,
    required this.payload_1,
    required this.payload_2,
    required this.loadingFund,
  });

  static FundDetailViewModel fromStore(Store<AppState> store) {
    return FundDetailViewModel(
      isLoading: store.state.fundDetailState.isLoading,
      loadingError: store.state.fundDetailState.loadingError,
      payload_1: store.state.fundDetailState.payload_1,
      payload_2: store.state.fundDetailState.payload_2,
      loadingFund: (String finId) {
        store.dispatch(loadingFundAction(finId));
      },
    );
  }
}

class FundDetailClass {
  String finId;
  String shortCode;
  String thName;
  String engName;
  String investmentStrategy;
  String riskSpectrum;
  String engCategory;
  String thCategory;
  double netAsset;
  String diViDeNedPolicy;

  FundDetailClass({
    required this.finId,
    required this.shortCode,
    required this.thName,
    required this.engName,
    required this.investmentStrategy,
    required this.riskSpectrum,
    required this.engCategory,
    required this.thCategory,
    required this.netAsset,
    required this.diViDeNedPolicy,
  });

  factory FundDetailClass.fromJson(Map<String, dynamic> json) =>
      FundDetailClass(
          finId: json["id"],
          shortCode: json["short_code"],
          thName: json["name_th"],
          engName: json["name_en"],
          investmentStrategy: json["investment_strategy"],
          riskSpectrum: json["risk_spectrum"],
          engCategory: json["aimc_category"],
          thCategory: json["aimc_category_th"],
          netAsset: json["net_assets"],
          diViDeNedPolicy: json['dividend_policy']);
}


class FundNavClass {
  String finId;
  String navDate;
  String value;
  String amount;
  String shortCode;
  String dayChange;


  FundNavClass({
    required this.finId,
    required this.navDate,
    required this.value,
    required this.amount,
    required this.shortCode,
    required this.dayChange,

  });

  factory FundNavClass.fromJson(Map<String, dynamic> json) =>
      FundNavClass(
          finId: json["mstar_id"],
          navDate: json["nav_date"],
          value: json["value"],
          amount: json["amount"],
          shortCode: json["short_code"],
          dayChange: json["d_change"]
      );
}