import 'package:fund_app/model/login_viewmodel.dart';
import 'package:meta/meta.dart';

@immutable
class UserState {
  final bool isLoading;
  final bool loginError;
  final LoginResponse user;

  UserState({
    required this.isLoading,
    required this.loginError,
    required this.user,
  });

  factory UserState.initial() {
    int userId;
    String userName;
    return new UserState(isLoading: false, loginError: false, user: LoginResponse(userName: '', userId: 0)  );
  }

  factory UserState.copyWith({required bool isLoading, required bool loginError, required LoginResponse user}) {
    return new UserState(
        isLoading: isLoading, loginError: loginError, user: user);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is UserState &&
              runtimeType == other.runtimeType &&
              isLoading == other.isLoading &&
              loginError == other.loginError &&
              user == other.user;

  @override
  int get hashCode => isLoading.hashCode ^ user.hashCode;
}
