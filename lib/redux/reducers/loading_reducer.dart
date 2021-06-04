import 'package:fund_app/model/loading_viewmodel.dart';
import 'package:fund_app/redux/actions/loading_actions.dart';
import 'package:fund_app/redux/state/loading_state.dart';
import 'package:redux/redux.dart';



final loadingReducer = combineReducers<LoadingState>([
  TypedReducer<LoadingState, LoadingSuccessAction>(_loadingSuccess),
  TypedReducer<LoadingState, LoadingFailedAction>(_loadingFailed),
  TypedReducer<LoadingState, StartLoadingAction>(_loadingLoading),
]);

LoadingState _loadingSuccess(LoadingState state, LoadingSuccessAction action) {
  return LoadingState.copyWith(isLoading: false, loginError: false, payload: LoadingResponse(version: action.payload.version, appName: action.payload.appName));
}

LoadingState _loadingFailed(LoadingState state, LoadingFailedAction action) {
  return LoadingState.copyWith(isLoading: false, loginError: true, payload: LoadingResponse(version: 0, appName: 'FalseApp'));
}

LoadingState _loadingLoading(LoadingState state, StartLoadingAction action) {
  return LoadingState.copyWith(isLoading: true, loginError: false, payload: LoadingResponse(version: 0, appName: 'Loading...'));
}