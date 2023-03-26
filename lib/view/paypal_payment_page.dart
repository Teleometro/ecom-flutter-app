import 'package:ecom/viewmodel.dart';
import 'package:flutter/material.dart';

import 'payment_confirmation.dart';

class PaypalPaymentPage extends StatefulWidget {
  ViewModel vm;
  PaypalPaymentPage(this.vm);
  @override
  _PaypalPaymentPageState createState() => _PaypalPaymentPageState(vm);
}

class _PaypalPaymentPageState extends State<PaypalPaymentPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  ViewModel vm;

  _PaypalPaymentPageState(this.vm);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paypal Payment"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
                validator: (value) {
                  if (value == null) {
                    return "Please enter your PayPal email";
                  }
                  return null;
                },
                onSaved: (value) => _email = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null) {
                    return "Please enter your PayPal password";
                  }
                  return null;
                },
                onSaved: (value) => _password = value,
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                child: const Text("Confirm Payment"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentConfirmationPage(vm: vm),
                        ),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
