import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fund_app/model/loading_viewmodel.dart';
import 'package:fund_app/redux/state/app_state.dart';

class LoadingScreen extends StatelessWidget {
  LoadingScreen({required this.viewModel});

  LoadingViewModel viewModel;

  initState() {
    viewModel.loading();
  }

  Widget spinkit() => SpinKitCircle(
    color: Colors.black,
    size: 50.0,
  );

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoadingViewModel>(
        converter: (store) => LoadingViewModel.fromStore(store),
        onInitialBuild: initState() ,
        builder: (BuildContext context, LoadingViewModel viewModel) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/funding.png", width: 300, height: 150,
                  ),
                  Container(height: 10,),
                  Text('Loading screen...'),
                  Text('Version: ${viewModel.payload.version} '),
                  Text('App name: ${viewModel.payload.appName}'),
                  Container(height: 10 ),
                  spinkit()
                ],
              ),
            ),
          );
        });
  }
}


