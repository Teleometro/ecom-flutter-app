import 'package:ecom/view/updateInfo.dart';
import 'package:ecom/view/update_password.dart';
import 'package:ecom/viewmodel.dart';
import 'package:flutter/material.dart';

import '../Model/user.dart';
import 'templates/appbar.dart';
import 'templates/templates.dart';

class SettingsPage extends StatelessWidget {
  final ViewModel vm;
  User user;
  SettingsPage(this.user, {super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithBackButton(context, vm),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 77, 188, 134)),
              onPressed: () {
                Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserUpdatePage(vm, user),
                          ),
                        );
              },
              child: Text("Edit Profile"),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 77, 188, 134)),
              onPressed: () {
                Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PasswordUpdate(vm, user),
                          ),
                        );
              },
              child: Text("Change Password"),
            ),
            
          ],
        ),
      ),
    );
  }
}
