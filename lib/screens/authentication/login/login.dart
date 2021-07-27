import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fund_app/model/login_viewmodel.dart';
import 'package:fund_app/navigation/navigation.dart';
import 'package:fund_app/redux/state/app_state.dart';
import 'package:fund_app/screens/authentication/register/register.dart';
import 'package:fund_app/widgets/bezierContainer.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  late String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String email = "";
  String password = "";
  var _userNameController = TextEditingController();
  var _passwordController = TextEditingController();

  Widget _entryField(String title, controller, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextFormField(
              controller: controller ,
              onChanged: (text){
                if(title == 'Email'){
                  email = text;
                }
                else if(title == 'Password'){
                  password = text;
                }
              },
                obscureText: isPassword,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "$title",
                )),
          ),
        ],
      ),
    );
  }

  Widget _submitButton(LoginViewModel viewModel) {
    return InkWell(
      onTap: () {
        viewModel.login(email, password);
        print('email = $email && password = $password');
        email = "";
        password = "";
        _userNameController.clear();
        _passwordController.clear();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
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
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Keys.navKey.currentState!.pushNamed(Routes.registerScreen);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'A',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xff24578D),
          ),
          children: [
            TextSpan(
              text: 'boss',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'Fund',
              style: TextStyle(color: Color(0xff24578D), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email", _userNameController),
        _entryField("Password", _passwordController,  isPassword: true),
      ],
    );
  }

  Widget socialLogin() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Container(
        width: 150,
        child: SignInButton(
          Buttons.Google,
          text: "Google",
          onPressed: () {},
        ),
      ),
      SizedBox(
        width: 15,
      ),
      Container(
        width: 150,
        child: SignInButton(
          Buttons.Facebook,
          text: "Facebook",
          onPressed: () {},
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return StoreConnector<AppState, LoginViewModel>(
        converter: (store) => LoginViewModel.fromStore(store),
        builder: (BuildContext context, LoginViewModel viewModel) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                color: Colors.blueGrey[200],
                height: height,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: -height * .15,
                        right: -MediaQuery.of(context).size.width * 0.4,
                        child: BezierContainer()),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 15),
                            _title(),
                            SizedBox(height: 20),
                            _emailPasswordWidget(),
                            SizedBox(height: 20),
                            _submitButton(viewModel),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.centerRight,
                              child: Text('Forgot Password ?',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                            _divider(),
                            socialLogin(),
                            _createAccountLabel(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
