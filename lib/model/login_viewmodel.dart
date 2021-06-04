import 'package:fund_app/redux/actions/login_actions.dart';
import 'package:redux/redux.dart';


import '../redux/state/app_state.dart';

class LoginViewModel {
  final bool isLoading;
  final bool loginError;
  final LoginResponse user;

  final Function(String, String) login;

  LoginViewModel({
    required this.isLoading,
    required this.loginError,
    required this.user,
    required this.login,
  });

  static LoginViewModel fromStore(Store<AppState> store) {
    return LoginViewModel(
      isLoading: store.state.userState.isLoading,
      loginError: store.state.userState.loginError,
      user: store.state.userState.user,
      login: (String username, String password) {
        store.dispatch(loginUser(username, password));
      },
    );
  }
}

class LoginResponse {
  int userId;
  String userName;

  LoginResponse({
    required this.userId,
    required this.userName
  });
}
