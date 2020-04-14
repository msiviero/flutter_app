import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "./pages/first_page.dart";
import "./pages/login_page.dart";
import "./pages/second_page.dart";
import './state/login_objects.dart';
import "./state/login_state.dart";

void main() => runApp(
      ChangeNotifierProvider<LoginState>(
        child: Root(),
        create: (BuildContext context) => LoginState(),
      ),
    );

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LoginInfo>(
      future: Provider.of<LoginState>(context).getAuthToken(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final LoginInfo loginInfo = snapshot.data;
          return MaterialApp(
            title: "Learning flutter",
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
            ),
            home: loginInfo.loggedIn ? FirstPage() : LoginPage(),
            routes: <String, WidgetBuilder>{
              '/second': (context) => SecondPage(),
            },
          );
        } else {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
            ),
            home: Center(
              child: Hero(
                tag: "hero_loading",
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 64.0,
                  child: Image.asset("assets/images/logo.png"),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
