import "package:flutter/material.dart";
import 'package:flutter_learning/state/login_state.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import "./global/routes.dart";
import "./pages/home_page.dart";
import "./pages/more_page.dart";

void main() => runApp(Root());

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Learning flutter",
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: ChangeNotifierProvider<LoginState>(
        create: (BuildContext context) => LoginState(http.Client()),
        child: HomePage(),
      ),
      routes: <String, WidgetBuilder>{
        routes.MORE.toString(): (context) => MorePage(),
      },
    );
  }
}
