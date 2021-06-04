import 'package:fund_app/model/funddetail_viewmodel.dart';
import 'package:meta/meta.dart';

@immutable
class FundDetailState {
  final bool isLoading;
  final bool loadingError;
  final FundDetailClass payload_1;
  final FundNavClass payload_2;

  FundDetailState({
    required this.isLoading,
    required this.loadingError,
    required this.payload_1,
    required this.payload_2,
  });

  factory FundDetailState.initial() {
    return new FundDetailState(
        isLoading: true,
        loadingError: false,
        payload_1: initValue,
        payload_2: initValue2);
  }

  factory FundDetailState.loadFund({required bool isLoading,
    required bool loginError,
    required FundDetailClass payload_1,
    required FundNavClass payload_2}) {
    return new FundDetailState(
        isLoading: true,
        loadingError: false,
        payload_1: payload_1,
        payload_2: payload_2);
  }
}

FundDetailClass initValue = FundDetailClass(
    finId: "",
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