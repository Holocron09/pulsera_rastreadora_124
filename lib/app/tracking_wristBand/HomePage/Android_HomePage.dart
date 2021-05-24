import 'package:flutter/material.dart';
import 'package:pulsera_rastreadora_124/app/MainPage.dart';
import 'package:pulsera_rastreadora_124/app/tracking_wristBand/About_Us.dart';
import 'package:pulsera_rastreadora_124/app/tracking_wristBand/LocationTracking/LocationHomeScreen.dart';
import 'package:pulsera_rastreadora_124/app/tracking_wristBand/Pairing/wrist_band_connection.dart';
import 'package:pulsera_rastreadora_124/app/tracking_wristBand/Profile.dart';

class AndroidHomePage extends StatelessWidget {
  Widget _navigationWidget(
      BuildContext context, Widget navigation, String title) {
    return CustomRequestButtons(
      buttonTitle: title,
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) {
            return Scaffold(
              appBar: AppBar(),
              body: navigation,
            );
          },
        ),
      ),
    );
  }

  final _kTabPages = <Widget>[
    BandPair(),
    LocationHomeScreen(),
    ShowProfile(),
    AboutUs(),
  ];
  @override
  Widget build(BuildContext context) {
    final _ktabs = <Tab>[
      Tab(
        icon: Icon(Icons.watch),
        text: 'Emparejar',
      ),
      Tab(
        icon: Icon(Icons.location_on),
        text: 'Ubicacion',
      ),
      Tab(
        icon: Icon(Icons.location_on),
        text: 'Historial',
      ),
      Tab(
        icon: Icon(Icons.person),
        text: 'Perfil',
      ),
      Tab(
        icon: Icon(Icons.person_outline),
        text: 'About Us',
      ),
    ];
    return DefaultTabController(
      length: _ktabs.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: _ktabs,
          ),
        ),
        body: TabBarView(
          children: _kTabPages,
        ),
      ),
    );
  }
}
