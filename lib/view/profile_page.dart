import 'package:ecom/view/settings_page.dart';
import 'package:ecom/view/updateInfo.dart';
import 'package:ecom/viewmodel.dart';
import 'package:flutter/material.dart';

import '../Model/user.dart';
import 'update_password.dart';

class ProfilePage extends StatelessWidget {
  ViewModel vm;
  final User user;
  ProfilePage(this.vm, {super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DropdownButton(
                      alignment: Alignment.topRight,
                        isDense: true,
                        items: [
                          DropdownMenuItem<String>(
                            child: Icon(Icons.edit),
                          ),
                          DropdownMenuItem<String>(
                            value: "aaa",
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UserUpdatePage(vm, user),
                                    ),
                                  );
                                },
                                child: Text("Edit Profile")),
                          ),
                          DropdownMenuItem<String>(
                            value: "aaa",
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PasswordUpdate(vm, user),
                                    ),
                                  );
                                },
                                child: Text("Change Password")),
                          ),
                        ],
                        onChanged: (_) {}),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${user.firstName} ${user.lastName}",
                        style: const TextStyle(fontSize: 24),
                      ),
                      Text(
                        "${user.username}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        width: 120,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("${user.phoneNumber}"),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        width: 120,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_city,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("${user.address}")
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        width: 160,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.email_outlined,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text("${user.email}")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _button(
                    const Icon(
                      Icons.favorite_border,
                      color: Color(0xFF115599),
                    ),
                    "Your Favorites", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (a) => SettingsPage(user, vm: vm)));
                }),
                _button(
                    const Icon(
                      Icons.payment_outlined,
                      color: Color(0xFF115599),
                    ),
                    "Payment", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (a) => SettingsPage(user, vm: vm)));
                }),
                _button(
                    const Icon(
                      Icons.share,
                      color: Color(0xFF115599),
                    ),
                    "Tell Your Friends", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (a) => SettingsPage(user, vm: vm)));
                }),
                _button(
                    const Icon(
                      Icons.discount_outlined,
                      color: Color(0xFF115599),
                    ),
                    "Promotions", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (a) => SettingsPage(user, vm: vm)));
                }),
                const Spacer(),
                _button(
                  const Icon(
                    Icons.logout,
                    color: Colors.redAccent,
                  ),
                  "Log Out",
                  () {
                    vm.signOut();
                    Navigator.popUntil(
                      context,
                      ModalRoute.withName('/RegisterPage'),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _button(Icon icon, String text, Function() onPress) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 233, 236, 246)),
    onPressed: onPress,
    child: Row(
      children: [
        icon,
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
      ],
    ),
  );
}
