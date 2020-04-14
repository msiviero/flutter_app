import "package:flutter/material.dart";
import "package:flutter_learning/pages/login_page.dart";
import "package:provider/provider.dart";

import "../global/routes.dart";
import "../state/login_objects.dart";
import "../state/login_state.dart";

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

class CalendarTab extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                "Menu here",
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Container(
                    child: Center(
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            const ListTile(
                              leading: Icon(Icons.event),
                              title: Text("Event"),
                              subtitle: Text("event description"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
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
        title: Text("My App"),
        bottom: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.event),
              text: "Agenda",
            ),
            Tab(
              icon: Icon(Icons.list),
              text: "Altro",
            ),
          ],
        ),
        actions: [_menuActions(context)],
      ),
      body: TabBarView(
        children: [
          CalendarTab(),
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
