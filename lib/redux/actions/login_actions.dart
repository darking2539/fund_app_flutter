import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fund_app/model/login_viewmodel.dart';
import 'package:fund_app/navigation/navigation.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';


ThunkAction loginUser(String username, String password) {
  return (Store store) async {
    new Future(() async{
      store.dispatch(new StartLoadingAction());
      EasyLoading.show(status: 'loading...');
      login(username, password).then((loginResponse) {
        EasyLoading.showSuccess('Login Successful!');
        store.dispatch(new LoginSuccessAction(loginResponse));
        Keys.navKey.currentState!.pushNamed(Routes.registerScreen);
      }, onError: (error) {
        print(error);
        EasyLoading.showError('Login Failed');
        store.dispatch(new LoginFailedAction());
      });
    });
  };
}

class StartLoadingAction {
  StartLoadingAction();
}

class LoginSuccessAction {
  final LoginResponse user;
  LoginSuccessAction(this.user);
}

class LoginFailedAction {
  LoginFailedAction();
}


Future<LoginResponse> login(String username, String password) async {
  return Future.delayed(const Duration(milliseconds: 2000), () {
    if (username.isEmpty || password.isEmpty) {
      Error error = new Error();
      return Future.error(error);
    } else {
      LoginResponse response = new LoginResponse(userId: 50, userName: username);
      return response;
    }
  });
}