import 'package:ecom/Model/user.dart';
import 'package:ecom/viewmodel.dart';
import 'package:ecom/viewmodel_impl.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../templates/templates.dart';
import 'signin_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  ViewModel vm = ViewModelImpl();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _address = TextEditingController();

  Future<bool> _register(String email, username, password, confirmPassword, firstName,
      lastName, phoneNumber, address) async {
    if (password != confirmPassword) return false;
    if (email == "" || username == "" || password == "" || firstName == "" || lastName == "" || phoneNumber == "" || address == "") return false;
    User newUser = User(username, password, address, firstName, lastName, phoneNumber, email);
    return vm.registerUser(newUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Hero(
                  tag: "splash_icon",
                  child: Icon(
                    Icons.public,
                    size: 100,
                  )),
              labelledTextField("Email", _email),
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
              labelledTextField("confirm password", _confirmPassword, true),
              labelledTextField("First Name", _firstName),
              labelledTextField("Last Name", _lastName),
              labelledTextField("Phone Number", _phoneNumber),
              labelledTextField("Address", _address),
              ElevatedButton(
                onPressed: () async {
                  if (await _register(_email.text, _username.text, _password.text, _confirmPassword.text,
                      _firstName.text, _lastName.text, _phoneNumber.text, _address.text)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInPage(
                            username: _username.text, password: _password.text, vm: vm,),
                      ),
                    );
                  } else {
                    const snackBar = SnackBar(
                      content: Text('invalid credentials'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    
                  }
                },
                child: const Text("Register"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInPage(
                          username: _username.text, password: _password.text, vm:vm),
                    ),
                  );
                },
                child: const Text("Sign in"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
