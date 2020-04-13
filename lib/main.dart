import "package:flutter/material.dart";
import "./pages/first_page.dart";
import "./pages/second_page.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Learning flutter",
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) {
          return FirstPage();
        },
        "/second": (context) {
          return SecondPage();
        },
      },
    );
  }
}
