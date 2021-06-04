
import 'package:fund_app/model/mutualfund_viewmodel.dart';
import 'package:meta/meta.dart';

@immutable
class MutualFundState {
  final bool isLoading;
  final bool loadingError;
  final List<FundClass> payload_1;
  final String payload_2;

  MutualFundState({
    required this.isLoading,
    required this.loadingError,
    required this.payload_1,
    required this.payload_2,
  });

  factory MutualFundState.initial() {
    return new MutualFundState(isLoading: true, loadingError: false, payload_1: [], payload_2: "" );
  }

  factory MutualFundState.loadList({required bool isLoading, required bool loginError, required List<FundClass> payload_1}) {
    return new MutualFundState(isLoading: true, loadingError: false, payload_1: payload_1, payload_2: "" );
  }

  factory MutualFundState.clickFund({required bool isLoading, required bool loginError, required List<FundClass> payload_1, required String payload_2}) {
    return new MutualFundState(isLoading: true, loadingError: false, payload_1: payload_1, payload_2: payload_2 );
  }


}
