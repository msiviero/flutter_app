import "package:flutter/material.dart";

class FirstPage extends StatelessWidget {
  Widget build(BuildContext context) {
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
                Navigator.pushNamed(context, '/second');
              },
              child: Text('Go to second screen'),
            ),
          ],
        ),
      ),
    );
  }
}
