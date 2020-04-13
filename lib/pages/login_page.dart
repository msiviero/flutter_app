import "package:flutter/material.dart";

class LoginPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

String nonEmptyField(String value) {
  if (value.isEmpty) {
    return "Please enter some text";
  }
  return null;
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: TextFormField(
              validator: nonEmptyField,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {},
              child: Center(
                child: Text('LOGIN'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
