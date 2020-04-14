import "package:flutter/material.dart";
import 'package:flutter_learning/state/login_state.dart';
import 'package:provider/provider.dart';

import "./pages/home_page.dart";
import "./pages/more_page.dart";

void main() => runApp(Root());

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Learning flutter",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: ChangeNotifierProvider<LoginState>(
        create: (BuildContext context) {
          return LoginState();
        },
        child: HomePage(),
      ),
      routes: <String, WidgetBuilder>{
        '/more': (context) => MorePage(),
      },
    );
  }
}
