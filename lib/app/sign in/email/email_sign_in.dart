import 'package:flutter/material.dart';
import 'package:pulsera_rastreadora_124/app/sign%20in/email/email_sign_in_form_change_notifier.dart';

class EmailSignInPage extends StatelessWidget {
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
          child: EmailSignInFormChangeNotifier.create(context),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
