import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fund_app/model/login_viewmodel.dart';
import 'package:fund_app/redux/state/app_state.dart';



class MainPortfolio extends StatefulWidget {
  const MainPortfolio({Key? key}) : super(key: key);

  @override
  _MainPortfolioState createState() => _MainPortfolioState();
}

class _MainPortfolioState extends State<MainPortfolio> {

  String? user = 'bb';
  String? password= '';


  void initState() {
    print(user);
    super.initState();
    setState(() {
      getUser();
    });

    print(user);
  }

  void getUser() async {
    final storage = new FlutterSecureStorage();
    user = await storage.read(key: 'username');
    password = await storage.read(key: "password");

  }

  void logout(LoginViewModel viewModel) async {

    viewModel.logout(); //force dispatch
    print(viewModel.loginError);
  }

  Widget _submitButton(LoginViewModel viewModel) {
    return Container(
      padding:  EdgeInsets.all(30),
      child: InkWell(
        onTap: () {
          logout(viewModel);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.blueGrey.shade400,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xfffbb448), Color(0xfff7892b)])),
          child: Text(
            'Logout',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginViewModel>(
        converter: (store) => LoginViewModel.fromStore(store),
        builder: (BuildContext context, LoginViewModel viewModel) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: 50),
              Container(child: Text("User Login")),
              Container(height: 5),
              Container(child: Text("Username: ${viewModel.user.userName}")),
              Container(height: 5),
              Container(child: Text("password: ${viewModel.user.password}")),
              Container(height: 30),
              _submitButton(viewModel)
            ],
          );
        });
  }
}




class SecureStorage {
  final String user;
  final String password;
  SecureStorage({
    required this.user,
    required this.password,
  });
}