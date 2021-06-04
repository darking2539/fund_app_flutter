import 'package:fund_app/model/login_viewmodel.dart';
import 'package:fund_app/redux/actions/login_actions.dart';
import 'package:fund_app/redux/state/user_state.dart';
import 'package:redux/redux.dart';



final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, LoginSuccessAction>(_loginSuccess),
  TypedReducer<UserState, LoginFailedAction>(_loginFailed),
  TypedReducer<UserState, StartLoadingAction>(_startLoading),
]);

UserState _loginSuccess(UserState state, LoginSuccessAction action) {
  return UserState.copyWith(user: LoginResponse(userName: action.user.userName, userId: action.user.userId), isLoading: false, loginError: false);
}

UserState _loginFailed(UserState state, LoginFailedAction action) {
  return UserState.copyWith(user: LoginResponse(userName: '', userId: 0), isLoading: false, loginError: true);
}

UserState _startLoading(UserState state, StartLoadingAction action) {
  return UserState.copyWith(user: LoginResponse(userName: '', userId: 0), isLoading: false, loginError: true);
}