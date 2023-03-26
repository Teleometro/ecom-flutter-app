import 'dart:ui';

import 'package:ecom/view/payment_page.dart';
import 'package:ecom/view/paypal_payment_page.dart';
import 'package:ecom/viewmodel.dart';
import 'package:flutter/material.dart';

class PaymentMethodPage extends StatefulWidget {
  ViewModel vm;
  PaymentMethodPage(this.vm, {super.key});
  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState(vm);
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String _selectedMethod = "";
  ViewModel vm;

  _PaymentMethodPageState(this.vm);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Payment Method"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Choose a Payment Method",
            style: TextStyle(fontSize: 24),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                RadioListTile(
                  title: Row(
                    children: const [
                      Text("Credit Card"),
                      Spacer(),
                      Image(
                        image: AssetImage("assets/credit.png"),
                        height: 24,
                      )
                    ],
                  ),
                  value: "credit_card",
                  groupValue: _selectedMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedMethod = value!;
                    });
                  },
                ),
                RadioListTile(
                  title: Row(
                    children: const [
                      Text("Paypal"),
                      Spacer(),
                      Image(
                        image: AssetImage("assets/paypal.jpg"),
                        height: 24,
                      )
                    ],
                  ),
                  value: "paypal",
                  groupValue: _selectedMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedMethod = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              child: const Text("Continue"),
              onPressed: () {
                if (_selectedMethod.isNotEmpty) {
                  if (_selectedMethod == "paypal") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaypalPaymentPage(vm),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(vm),
                      ),
                    );
                  }
                } else {
                  const snackBar = SnackBar(
                    content: Text('please choose a payment method'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
