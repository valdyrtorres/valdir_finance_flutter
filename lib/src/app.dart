import 'package:flutter/material.dart';
import 'package:valdir_finance/src/blocs/authentication/authentication_bloc_provider.dart';
import 'package:valdir_finance/src/root_page.dart';
import 'package:valdir_finance/src/ui/authentication/login_page.dart';
import 'package:valdir_finance/src/ui/home/home_page.dart';

class NuFinance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthenticationBlocProvider(
      child: MaterialApp(
      title: "NuFinance",
      theme: ThemeData(
        accentColor: Colors.purpleAccent
      ),
      initialRoute: RootPage.routeName,
      routes: {
        RootPage.routeName: (context) => RootPage(),
        LoginPage.routeName: (context) => LoginPage(),
        HomePage.routeName: (context) => HomePage(),
      }
      ),
    );;
  }
}
