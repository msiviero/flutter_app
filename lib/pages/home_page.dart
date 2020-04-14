import "package:flutter/material.dart";
import 'package:flutter_learning/pages/login_page.dart';
import 'package:provider/provider.dart';

import '../global/routes.dart';
import '../state/login_objects.dart';
import '../state/login_state.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LoginInfo>(
      future: Provider.of<LoginState>(context).getLoginInfo(),
      builder: (BuildContext context, AsyncSnapshot<LoginInfo> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data.loggedIn ? _tabWidget(context) : LoginPage();
        }

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: "hero_loading",
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 96.0,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Text("Caricamento..."),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FirstTab extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "First tab text",
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
    );
  }
}

class SecondTab extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "First page text",
              style: Theme.of(context).textTheme.display1,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, routes.MORE.toString());
              },
              child: Text('Go to second screen'),
            ),
          ],
        ),
      ),
    );
  }
}

_tabWidget(BuildContext context) {
  return DefaultTabController(
    length: 2,
    child: Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_transit)),
          ],
        ),
        title: Text('Tabs Demo'),
        actions: [_menuActions(context)],
      ),
      body: TabBarView(
        children: [
          FirstTab(),
          SecondTab(),
        ],
      ),
    ),
  );
}

_menuActions(BuildContext context) {
  return PopupMenuButton<String>(
    onSelected: (selected) {
      switch (selected) {
        case "logout":
          Provider.of<LoginState>(context, listen: false).logout();
          break;
      }
    },
    itemBuilder: (BuildContext context) {
      return [
        PopupMenuItem<String>(
          value: "logout",
          child: Text("Logout"),
        ),
      ];
    },
  );
}
