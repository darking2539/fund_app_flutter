
import 'package:fund_app/model/mutualfund_viewmodel.dart';
import 'package:fund_app/redux/actions/mutualfund_actions.dart';
import 'package:fund_app/redux/state/mutualfund_state.dart';
import 'package:redux/redux.dart';



final mutualFundReducer = combineReducers<MutualFundState>([
  TypedReducer<MutualFundState, LoadListSuccessAction>(_loadingListSuccess),
  TypedReducer<MutualFundState, LoadListFailedAction>(_loadingListFailed),
  TypedReducer<MutualFundState, LoadListAction>(_loadingListLoading),
  TypedReducer<MutualFundState, ClickFundSuccessAction>(_loadingClickSuccess),
  TypedReducer<MutualFundState, ClickFundFailedAction>(_loadingClickFailed),
  TypedReducer<MutualFundState, ClickFundAction>(_loadingClickLoading),
]);

MutualFundState _loadingListSuccess(MutualFundState state, LoadListSuccessAction action) {
  return MutualFundState.loadList(isLoading: false, loginError: false, payload_1: action.payload);
}

MutualFundState _loadingListFailed(MutualFundState state, LoadListFailedAction action) {
  return MutualFundState.loadList(isLoading: false, loginError: true, payload_1: [] );
}

MutualFundState _loadingListLoading(MutualFundState state, LoadListAction action) {
  return MutualFundState.loadList(isLoading: true, loginError: false, payload_1: [] );
}


MutualFundState _loadingClickSuccess(MutualFundState state, ClickFundSuccessAction action) {
  return MutualFundState.clickFund(isLoading: false, loginError: false, payload_2: action.payload_2, payload_1: action.payload_1  );
}

MutualFundState _loadingClickFailed(MutualFundState state, ClickFundFailedAction action) {
  return MutualFundState.clickFund(isLoading: false, loginError: true, payload_2: "", payload_1: [] );
}

MutualFundState _loadingClickLoading(MutualFundState state, ClickFundAction action) {
  return MutualFundState.clickFund(isLoading: true, loginError: false, payload_2: "", payload_1: []);
}