import "package:flutter/material.dart";
import "package:provider/provider.dart";

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
  Widget build(BuildContext context) => MaterialApp(
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
}
