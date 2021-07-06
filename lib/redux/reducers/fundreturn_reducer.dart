
import 'package:fund_app/redux/actions/funddetail_actions.dart';
import 'package:fund_app/redux/state/fundreturn_state.dart';
import 'package:redux/redux.dart';



final fundReturnReducer = combineReducers<FundReturnState>([
  TypedReducer<FundReturnState, LoadReturnAction>(_fundReturnSuccess),

]);

FundReturnState _fundReturnSuccess(FundReturnState state, LoadReturnAction action) {
  return FundReturnState(payload: action.payload, payload2: action.payload2);
}

