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
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
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
              "Home",
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
    );
  }
}

class OtherTab extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Altra pagina"),
              subtitle: Text("un link ad un'altra pagina"),
              onTap: () {
                Navigator.of(context).pushNamed(routes.MORE.toString());
              },
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
            Tab(
              icon: Icon(Icons.home),
            ),
            Tab(
              text: "Altro",
            ),
          ],
        ),
        actions: [_menuActions(context)],
      ),
      body: TabBarView(
        children: [
          FirstTab(),
          OtherTab(),
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
