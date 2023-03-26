import 'package:ecom/view/home_page.dart';
import 'package:ecom/viewmodel.dart';
import 'package:flutter/material.dart';

import '../../Model/user.dart';
import '../templates/templates.dart';

class SignInPage extends StatefulWidget {
  final String username, password;
  final ViewModel vm;

  SignInPage(
      {required this.username, required this.password, required this.vm});

  @override
  State<SignInPage> createState() => _SignInPageState(username, password, vm);
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  ViewModel vm;
  _SignInPageState(String username, String password, this.vm) {
    _username.text = username;
    _password.text = password;
  }

  Future<User?> _authenticate(String username, String password) async {
    return vm.signIn(username, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Hero(
                tag: "splash_icon",
                child: Icon(
                  Icons.public,
                  size: 150,
                )),
            Hero(
              tag: "username",
              child: Material(
                type: MaterialType.transparency,
                child: labelledTextField("Username", _username),
              ),
            ),
            Hero(
              tag: "password",
              child: Material(
                type: MaterialType.transparency,
                child: labelledTextField("Password", _password, true),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  User? user =
                      await _authenticate(_username.text, _password.text);
                  if (user == null) {
                    const snackBar = SnackBar(
                      content: Text('invalid credentials'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        settings: const RouteSettings(name: "/Home"),
                        builder: (context) => HomePage(
                          vm,
                          1,
                        ),
                      ),
                    );
                  }
                },
                child: const Text("Sign In")),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
