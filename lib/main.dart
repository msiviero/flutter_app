import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'package:shared_preferences/shared_preferences.dart';

import "./pages/first_page.dart";
import "./pages/login_page.dart";
import "./pages/second_page.dart";
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
    return FutureBuilder<String>(
      future: new Future<String>(() async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String token = preferences.get("token");
        return token != null ? token : "";
      }),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          String token = snapshot.data;
          print("token => $token");
        } else {
          return MaterialApp(
            home: Center(child: CircularProgressIndicator()),
          );
        }
        return MaterialApp(
          title: "Learning flutter",
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: Provider.of<LoginState>(context).loggedIn()
              ? FirstPage()
              : LoginPage(),
          routes: <String, WidgetBuilder>{
            '/second': (context) => SecondPage(),
          },
        );
      },
    );
  }
}
