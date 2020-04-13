import "package:flutter/material.dart";
import "./pages/first_page.dart";
import "./pages/second_page.dart";
import "./pages/login_page.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const loggedIn = false;
    const title = "Learning flutter";

    final theme = ThemeData(
      primarySwatch: Colors.pink,
    );

    return loggedIn
        ? MaterialApp(
            title: title,
            theme: theme,
            initialRoute: "/",
            routes: {
              "/": (context) {
                return FirstPage();
              },
              "/second": (context) {
                return SecondPage();
              },
            },
          )
        : MaterialApp(
            title: title,
            home: LoginPage(),
          );
  }
}
