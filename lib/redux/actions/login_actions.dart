import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fund_app/model/login_viewmodel.dart';
import 'package:fund_app/navigation/navigation.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



ThunkAction loginUser(String username, String password) {
  return (Store store) async {
    new Future(() async{

      store.dispatch(new StartLoginAction());
      final storage = new FlutterSecureStorage();
      await storage.write(key: "username", value: username );
      await storage.write(key: "password", value: password );


      EasyLoading.show(status: 'loading...');
      login(username, password).then((loginResponse) {
        EasyLoading.showSuccess('Login Successful! \n username: $username \n password: $password');
        store.dispatch(new LoginSuccessAction(loginResponse));
      }, onError: (error) {
        print(error);
        EasyLoading.showError('Login Failed');
        store.dispatch(new LoginFailedAction());
      });
    });
  };
}

ThunkAction logoutUser() {
  return (Store store) async {
    new Future(() async{

      store.dispatch(new StartLoginAction());
      final storage = new FlutterSecureStorage();
      await storage.deleteAll();
      EasyLoading.showSuccess('Logout Successful!');
      store.dispatch(new LoginFailedAction());

    });
  };
}

class StartLoginAction {
  StartLoginAction();
}

class LoginSuccessAction {
  final LoginResponse user;
  LoginSuccessAction(this.user);
}

class LoginFailedAction {
  LoginFailedAction();
}


Future<LoginResponse> login(String username, String password) async {

  final storage = new FlutterSecureStorage();
  String? username = await storage.read(key: 'username');
  String? password = await storage.read(key: 'password');

    if (username == "") {
      Error error = new Error();
      return Future.error(error);
    } else {
      LoginResponse response = new LoginResponse(userId: 50, userName: username.toString(), password: password.toString());
      return response;
    }

}