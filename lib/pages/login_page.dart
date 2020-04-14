import "package:flutter/material.dart";
import 'package:flutter_learning/state/login_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
            ),
          )
        : Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 24.0,
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Hero(
                    tag: "hero",
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 48.0,
                      child: Image.asset("assets/images/logo.png"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    controller: _emailController,
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
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    controller: _passwordController,
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
                  padding: const EdgeInsets.only(top: 16.0),
                  child: RaisedButton(
                    onPressed: () async {
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        form.save();
                        setState(() => _loading = true);
                        try {
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          final response = await Provider.of<LoginState>(
                                  context,
                                  listen: false)
                              .login(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                          await preferences.setString(
                              'authToken', response.token);
                        } catch (e) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Request failed with code ${e.code}"),
                          ));
                          setState(() => _loading = false);
                        }
                      }
                    },
                    child: Center(child: Text("LOGIN")),
                  ),
                ),
              ],
            ),
          );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
