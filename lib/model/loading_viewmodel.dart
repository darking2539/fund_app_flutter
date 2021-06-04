import 'package:fund_app/redux/actions/loading_actions.dart';
import 'package:fund_app/redux/state/app_state.dart';
import 'package:redux/redux.dart';


class LoadingViewModel {
  final bool isLoading;
  final bool loadingError;
  final LoadingResponse payload;

  final Function() loading;

  LoadingViewModel({
    required this.isLoading,
    required this.loadingError,
    required this.payload,
    required this.loading,
  });

  static LoadingViewModel fromStore(Store<AppState> store) {
    return LoadingViewModel(
      isLoading: store.state.loadingState.isLoading,
      loadingError: store.state.loadingState.loadingError,
      payload: store.state.loadingState.payload,
      loading: () {
        store.dispatch(loadingAction());
      },
    );
  }
}

class LoadingResponse {
  double version;
  String appName;

  LoadingResponse({
    required this.version,
    required this.appName
  });
}