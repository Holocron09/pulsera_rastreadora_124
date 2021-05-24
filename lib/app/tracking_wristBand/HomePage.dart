import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pulsera_rastreadora_124/app/tracking_wristBand/HomePage/Android_HomePage.dart';
import 'package:pulsera_rastreadora_124/app/tracking_wristBand/HomePage/Cupertino_homePage.dart';
import 'package:pulsera_rastreadora_124/commonWidget/plattform_alert_dialog.dart';
import 'package:pulsera_rastreadora_124/services/Auth.dart';

class HomePage extends StatefulWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Log Out',
      content: 'Are you sure that you want to logout? ',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Log Out',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.red,
              ),
            ),
            onPressed: () => widget._confirmSignOut(context),
          ),
        ],
      ),
      //body: AndroidHomePage(),
      body: Platform.isIOS ? CupertinoHomePage() : AndroidHomePage(),
    );
  }
}
