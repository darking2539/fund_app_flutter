import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fund_app/model/funddetail_viewmodel.dart';
import 'package:fund_app/model/mutualfund_viewmodel.dart';
import 'package:fund_app/redux/reducers/app_reducer.dart';
import 'package:fund_app/redux/state/app_state.dart';
import 'package:fund_app/screens/authentication/register/register.dart';
import 'package:fund_app/screens/home/homescreen.dart';
import 'package:fund_app/screens/loading/loadingscreen.dart';
import 'package:fund_app/screens/mutualfund/mutualfund_detail.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_logging/redux_logging.dart';
import 'model/loading_viewmodel.dart';
import 'navigation/navigation.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final store = Store<AppState>(
      appReducer,
      initialState: new AppState.initial(),
      middleware: [thunkMiddleware, new LoggingMiddleware.printer()]
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Fund App',
        navigatorKey: Keys.navKey,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: LoadingScreen(viewModel: LoadingViewModel.fromStore(store)),
        builder: EasyLoading.init(),
        routes: {
          Routes.homeScreen: (context) {
            return HomeScreen(store: store);
          },
          Routes.fundDetail: (context) {
            return MutualFundDetail(viewModel_1: FundDetailViewModel.fromStore(store), viewModel_2: MutualFundViewModel.fromStore(store));
          },
          Routes.registerScreen: (context) {
            return SignUpPage();
          },
        },
      ),
    );
  }
}
