
import 'package:fund_app/redux/actions/funddetail_actions.dart';
import 'package:fund_app/redux/state/fundproportion_state.dart';
import 'package:redux/redux.dart';



final fundProportionReducer = combineReducers<FundProportionState>([
  TypedReducer<FundProportionState, LoadProportionAction>(_fundProportionSuccess),

]);

FundProportionState _fundProportionSuccess(FundProportionState state, LoadProportionAction action) {
  return FundProportionState(dataDate: action.navDate, payload: action.payload, payload2: action.payload2);
}

