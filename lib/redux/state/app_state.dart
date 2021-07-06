import 'package:fund_app/redux/state/funddetail_state.dart';
import 'package:fund_app/redux/state/fundproportion_state.dart';
import 'package:fund_app/redux/state/fundreturn_state.dart';
import 'package:fund_app/redux/state/mutualfund_state.dart';
import 'package:fund_app/redux/state/user_state.dart';
import 'package:meta/meta.dart';

import 'loading_state.dart';

@immutable
class AppState {
  final UserState userState;
  final LoadingState loadingState;
  final MutualFundState mutualFundState;
  final FundDetailState fundDetailState;
  final FundProportionState fundProportionState;
  final FundReturnState fundReturnState;

  AppState({
    required this.userState,
    required this.loadingState,
    required this.mutualFundState,
    required this.fundDetailState,
    required this.fundProportionState,
    required this.fundReturnState,
  });

  factory AppState.initial() {
    return AppState(
        userState: UserState.initial(),
        loadingState: LoadingState.initial(),
        mutualFundState: MutualFundState.initial(),
        fundDetailState: FundDetailState.initial(),
        fundProportionState: FundProportionState.initial(),
        fundReturnState: FundReturnState.initial());
  }
}
