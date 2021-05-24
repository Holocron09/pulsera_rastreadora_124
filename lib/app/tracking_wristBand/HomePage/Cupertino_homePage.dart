import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pulsera_rastreadora_124/app/tracking_wristBand/About_Us.dart';
import 'package:pulsera_rastreadora_124/app/tracking_wristBand/LocationTracking/CurrentLocation.dart';
import 'package:pulsera_rastreadora_124/app/tracking_wristBand/LocationTracking/LocationHomeScreen.dart';
import 'package:pulsera_rastreadora_124/app/tracking_wristBand/Pairing/Instructions_with_UX.dart';
import 'package:pulsera_rastreadora_124/app/tracking_wristBand/firebase_Database.dart';

import '../Profile.dart';

class CupertinoHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      resizeToAvoidBottomInset: true,
      tabBar: CupertinoTabBar(
        currentIndex: 0,
        //onTap: (context) => _page,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bars),
            label: 'Emparejar',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.location_fill),
            label: 'Ubicar',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.map),
            label: 'Historial',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_fill),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'About us',
          ),
        ],
      ),
      tabBuilder: (context, int index) {
        final database = Provider.of<ReadFirebaseDatabase>(context);
        return CupertinoTabView(
          builder: (context) {
            switch (index) {
              case 0:
                return BandPairing();
              case 1:
                return Provider(
                    create: (context) =>
                        ReadFirebaseDatabase(uid: database.uid),
                    child: CurrentLocation());
              case 2:
                return LocationHomeScreen();
              case 3:
                return ShowProfile();
              case 4:
                return AboutUs();
            }
            return Scaffold();
          },
        );
      },
    );
  }
}
