import 'package:fund_app/model/loading_viewmodel.dart';
import 'package:meta/meta.dart';

@immutable
class LoadingState {
  final bool isLoading;
  final bool loadingError;
  final LoadingResponse payload;

  LoadingState({
    required this.isLoading,
    required this.loadingError,
    required this.payload,
  });

  factory LoadingState.initial() {
    return new LoadingState(isLoading: false, loadingError: false, payload: LoadingResponse(version: 0, appName: "Loading...") );
  }
  factory LoadingState.copyWith({required bool isLoading, required bool loginError, required LoadingResponse payload}) {
    return new LoadingState(
        isLoading: isLoading, loadingError: loginError, payload: payload);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LoadingState &&
              runtimeType == other.runtimeType &&
              isLoading == other.isLoading &&
              loadingError == other.loadingError &&
              payload == other.payload;

  @override
  int get hashCode => isLoading.hashCode ^ payload.hashCode;
}
