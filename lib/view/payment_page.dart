import 'package:ecom/view/payment_confirmation.dart';
import 'package:ecom/viewmodel.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  ViewModel vm;

  PaymentPage(this.vm);
  @override
  _PaymentPageState createState() => _PaymentPageState(vm);
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  ViewModel vm;

  String? _cardNumber;
  String? _expDate;
  String? _cvv;
  String? _nameOnCard;

  _PaymentPageState(this.vm);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Payment Information'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  hintText: '1234 1234 1234 1234',
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter a card number';
                  }
                  return null;
                },
                onSaved: (value) => _cardNumber = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Expiration Date',
                  hintText: 'MM/YY',
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter an expiration date';
                  }
                  return null;
                },
                onSaved: (value) => _expDate = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'CVV',
                  hintText: '123',
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter a CVV';
                  }
                  return null;
                },
                onSaved: (value) => _cvv = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name on Card',
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter the name on the card';
                  }
                  return null;
                },
                onSaved: (value) => _nameOnCard = value,
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  child: const Text('Confirm Payment'),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
