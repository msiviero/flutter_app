import 'dart:async';

import "package:flutter/material.dart";

class LoginPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: LoginForm()),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;

  String _nonEmpty(value) {
    return value.isEmpty ? "Empty field" : null;
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text("Loading"),
                ),
                CircularProgressIndicator(),
              ],
            ))
        : Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 24.0,
              ),
              children: <Widget>[
                Hero(
                  tag: "hero",
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 48.0,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: _nonEmpty,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: _nonEmpty,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: RaisedButton(
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        form.save();
                        setState(() {
                          _loading = true;
                        });
                        new Timer(const Duration(milliseconds: 4000), () {
                          setState(() {
                            _loading = false;
                          });
                        });
                      }
                    },
                    child: Center(
                      child: Text("LOGIN"),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
