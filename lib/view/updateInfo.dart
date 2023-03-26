import 'package:ecom/Model/user.dart';
import 'package:ecom/view/initial_screens/register_page.dart';
import 'package:ecom/view/initial_screens/splashscreen.dart';
import 'package:ecom/view/templates/appbar.dart';
import 'package:ecom/viewmodel.dart';
import 'package:ecom/viewmodel_impl.dart';
import 'package:flutter/material.dart';

import 'templates/templates.dart';
import 'initial_screens/signin_page.dart';

class UserUpdatePage extends StatefulWidget {
  ViewModel vm;
  User oldUser;

  UserUpdatePage(this.vm, this.oldUser, {super.key});
  @override
  State<UserUpdatePage> createState() => _UserUpdatePageState(vm, oldUser);
}

class _UserUpdatePageState extends State<UserUpdatePage> {
  ViewModel vm;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _address = TextEditingController();
  User oldUser;

  _UserUpdatePageState(this.vm, this.oldUser);

  bool _update(
      String email, username, firstName, lastName, phoneNumber, address) {
    if (username == "") username = oldUser.username;
    if (email == "") email = oldUser.email;
    if (address == "") address = oldUser.address;
    if (firstName == "") firstName = oldUser.firstName;
    if (lastName == "") lastName = oldUser.lastName;
    if (phoneNumber == "") phoneNumber = oldUser.phoneNumber;

    User newUser = User(username, oldUser.password, address, firstName,
        lastName, phoneNumber, email);
    vm.updateUser(oldUser, newUser);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithBackButton(context, vm),
      body: Column(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(32, 16, 0, 16),
                height: 375,
                width: 100,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Email"),
                      Text("Username"),
                      Text("First Name"),
                      Text("Last Name"),
                      Text("Phone Number"),
                      Text("Address")
                    ]),
              ),
              SizedBox(
                height: 350,
                width: MediaQuery.of(context).size.width/2+105,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    labelledTextField("New Email", _email),
                    labelledTextField("New Username", _username),
                    labelledTextField("New First Name", _firstName),
                    labelledTextField("New Last Name", _lastName),
                    labelledTextField("New Phone Number", _phoneNumber),
                    labelledTextField("New Address", _address),
                  ],
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_update(_email.text, _username.text, _firstName.text,
                _lastName.text, _phoneNumber.text, _address.text)) {
              vm.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SplashScreen(),
                ),
              );
            } else {
              const snackBar = SnackBar(
                content: Text('please fill all fields'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: Text("Update"),
        ),
      ]),
    );
  }
}
