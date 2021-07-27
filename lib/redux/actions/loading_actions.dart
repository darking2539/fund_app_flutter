import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fund_app/model/loading_viewmodel.dart';
import 'package:fund_app/model/login_viewmodel.dart';
import 'package:fund_app/navigation/navigation.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'login_actions.dart';


ThunkAction loadingAction() {
  return (Store store) async {
    new Future(() async{

      store.dispatch(new StartLoadingAction());

      //check user login
      checkLogin().then((loginResponse) {
        store.dispatch(new LoginSuccessAction(loginResponse));
      }, onError: (error) {
        print(error);
        store.dispatch(new LoginFailedAction());
      });

      loading(4.0 , "Funding AbossZz App").then((loginResponse) {
        store.dispatch(new LoadingSuccessAction(loginResponse));
        Future.delayed(const Duration(milliseconds: 1000), () {
          Keys.navKey.currentState!.pushReplacementNamed(Routes.homeScreen);
        }
        );
      }, onError: (error) {
        print(error);
        store.dispatch(new LoadingFailedAction());
      });
    });
  };
}

class StartLoadingAction {
  StartLoadingAction();
}

class LoadingSuccessAction {
  final LoadingResponse payload;
  LoadingSuccessAction(this.payload);
}

class LoadingFailedAction {
  LoadingFailedAction();
}

Future<LoadingResponse> loading(double version, String name) async {
  return Future.delayed(const Duration(milliseconds: 1000), () {
    LoadingResponse response = new LoadingResponse(version: version , appName: name);
    return response;
    }
  );
}

Future<LoginResponse> checkLogin() async {

  final storage = new FlutterSecureStorage();
  String? username = await storage.read(key: 'username');
  String? password = await storage.read(key: 'password');

  if (username == null) {
    Error error = new Error();
    return Future.error(error);
  } else {
    LoginResponse response = new LoginResponse(userId: 50, userName: username.toString(), password: password.toString());
    return response;
  }

}