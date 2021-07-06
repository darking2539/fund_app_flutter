import 'package:fund_app/model/fundreturn_viewmodel.dart';
import 'package:meta/meta.dart';

@immutable
class FundReturnState {

  final List<FundPerformanceClass> payload;
  final List<FundReturnHistoryClass> payload2;


  FundReturnState({
    required this.payload,
    required this.payload2

  });

  factory FundReturnState.initial() {
    return new FundReturnState(
        payload: [],
        payload2: []
    );
  }

  factory FundReturnState.loadFund({
    required String dataDate,
    required List<FundPerformanceClass> payload,
    required List<FundReturnHistoryClass> payload2}) {
    return new FundReturnState(
        payload: payload,
        payload2: payload2);
  }
}



