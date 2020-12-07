import 'package:flutter/material.dart';
import 'package:valdir_finance/src/utils/values/colors.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = 'login_page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorMainPurple,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children:<Widget>[
          Center(
            child: Text(
              "Login Page",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
