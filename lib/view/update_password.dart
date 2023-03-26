import 'package:ecom/Model/user.dart';
import 'package:ecom/view/initial_screens/register_page.dart';
import 'package:ecom/view/initial_screens/splashscreen.dart';
import 'package:ecom/view/templates/appbar.dart';
import 'package:ecom/viewmodel.dart';
import 'package:ecom/viewmodel_impl.dart';
import 'package:flutter/material.dart';

import 'templates/templates.dart';
import 'initial_screens/signin_page.dart';

class PasswordUpdate extends StatefulWidget {
  ViewModel vm;
  User oldUser;

  PasswordUpdate(this.vm, this.oldUser, {super.key});
  @override
  State<PasswordUpdate> createState() => _PasswordUpdateState(vm, oldUser);
}

class _PasswordUpdateState extends State<PasswordUpdate> {
  ViewModel vm;
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  TextEditingController _oldPassword = TextEditingController();
  User oldUser;

  _PasswordUpdateState(this.vm, this.oldUser);

  bool _update(String oldPassword, password, confirmPassword) {
    if (oldPassword == "" || password == "" || confirmPassword == "") return false;
    if (oldPassword != oldUser.password) return false;
    if (password != confirmPassword) return false;
    
    User newUser = User(oldUser.username, password, oldUser.address, oldUser.firstName,
        oldUser.lastName, oldUser.phoneNumber, oldUser.email);
    vm.updateUser(oldUser, newUser);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithBackButton(context, vm),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
              labelledTextField("Old Password", _oldPassword),
              labelledTextField("New Password", _password),
              labelledTextField("Confirm New Password", _confirmPassword),
              ElevatedButton(
                onPressed: () async {
                  if (_update(
                      _oldPassword.text,
                      _password.text,
                      _confirmPassword.text)) {
                    vm.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SplashScreen(),
                      ),
                    );
                  } else {
                    const snackBar = SnackBar(
                      content: Text('please fill all fields correctly'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
