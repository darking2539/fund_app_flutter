import 'package:fund_app/redux/reducers/fundpropotion_reducer.dart';
import 'package:fund_app/redux/reducers/fundreturn_reducer.dart';
import 'package:fund_app/redux/reducers/mutualfund_reducer.dart';
import 'package:fund_app/redux/reducers/user_reducer.dart';
import 'package:fund_app/redux/state/app_state.dart';
import 'funddetail_reducer.dart';
import 'loading_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    userState: userReducer(state.userState, action),
    loadingState: loadingReducer(state.loadingState, action),
    mutualFundState: mutualFundReducer(state.mutualFundState, action),
    fundDetailState: fundDetailReducer(state.fundDetailState, action),
    fundProportionState: fundProportionReducer(state.fundProportionState, action),
    fundReturnState: fundReturnReducer(state.fundReturnState, action)
  );
}