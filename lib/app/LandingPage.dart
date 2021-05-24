import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pulsera_rastreadora_124/app/sign%20in/signInPage.dart';
import 'package:pulsera_rastreadora_124/app/tracking_wristBand/HomePage.dart';
import 'package:pulsera_rastreadora_124/app/tracking_wristBand/firebase_Database.dart';
import 'package:pulsera_rastreadora_124/services/Auth.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<UserAuth>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          UserAuth user = snapshot.data;
          if (user == null) {
            return SignInPage.create(context);
          }
          return Provider<ReadFirebaseDatabase>(
            //create: (_) => FireStoreDatabase(uid: user.uid),
            create: (_) => ReadFirebaseDatabase(uid: user.uid),
            child: HomePage(),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
