import 'package:flutter/material.dart';
import 'package:pulsera_rastreadora_124/app/sign%20in/phone/PhoneSignInFormChangeNotifier.dart';

class PhoneSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Card(
          child: PhoneSignInFormChangeNotifier.create(context),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
