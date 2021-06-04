import 'package:fund_app/model/funddetail_viewmodel.dart';
import 'package:fund_app/redux/actions/funddetail_actions.dart';
import 'package:fund_app/redux/state/funddetail_state.dart';
import 'package:redux/redux.dart';


final fundDetailReducer = combineReducers<FundDetailState>([
  TypedReducer<FundDetailState, LoadFundSuccessAction>(_loadingFundSuccess),
  TypedReducer<FundDetailState, LoadFundFailedAction>(_loadingFundFailed),
  TypedReducer<FundDetailState, LoadFundAction>(_loadingFundLoading),
]);

FundDetailState _loadingFundSuccess(FundDetailState state,
    LoadFundSuccessAction action) {
  return FundDetailState.loadFund(isLoading: false,
      loginError: false,
      payload_1: action.payload_1,
      payload_2: action.payload_2);
}

FundDetailState _loadingFundFailed(FundDetailState state,
    LoadFundFailedAction action) {
  return FundDetailState.loadFund(isLoading: false,
      loginError: true,
      payload_1: initValue,
      payload_2: initValue2);
}

FundDetailState _loadingFundLoading(FundDetailState state,
    LoadFundAction action) {
  return FundDetailState.loadFund(isLoading: true,
      loginError: false,
      payload_1: initValue,
      payload_2: initValue2);
}


FundDetailClass initValue = FundDetailClass(finId: "",
    shortCode: "",
    thName: "",
    engName: "",
    investmentStrategy: "",
    riskSpectrum: "",
    engCategory: "",
    thCategory: "",
    diViDeNedPolicy: "",
    netAsset: 0.0);

FundNavClass initValue2 = FundNavClass(finId: "",
    navDate: '',
    value: '',
    amount: '',
    shortCode: '',
    dayChange: '');