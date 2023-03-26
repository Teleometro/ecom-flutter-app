import 'package:ecom/view/home_page.dart';
import 'package:ecom/view/templates/appbar.dart';
import 'package:ecom/viewmodel.dart';
import 'package:flutter/material.dart';

import '../../Model/user.dart';

class PaymentConfirmationPage extends StatefulWidget {
  final ViewModel vm;

  PaymentConfirmationPage({required this.vm}) {
    vm.cartClear();
  }

  @override
  State<PaymentConfirmationPage> createState() =>
      _PaymentConfirmationPageState(vm);
}

class _PaymentConfirmationPageState extends State<PaymentConfirmationPage> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  ViewModel vm;
  _PaymentConfirmationPageState(this.vm);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithoutBackButton(context, vm),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.public,
              size: 150,
            ),
            const Material(
              type: MaterialType.transparency,
              child: Text("Order Successfully Placed!"),
            ),
            ElevatedButton(
                onPressed: () async {
                  Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(vm, 1),
                        ),
                      );
                },
                child: const Text("Return To Home")),
          ],
        ),
      ),
    );
  }
}
