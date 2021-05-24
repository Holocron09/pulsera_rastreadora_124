import 'package:flutter/material.dart';
import 'package:pulsera_rastreadora_124/app/MainPage.dart';
import 'package:pulsera_rastreadora_124/app/tracking_wristBand/LocationTracking/CurrentLocation.dart';

class LocationHomeScreen extends StatefulWidget {
  @override
  _LocationHomeScreenState createState() => _LocationHomeScreenState();
}

class _LocationHomeScreenState extends State<LocationHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomRequestButtons(
            buttonTitle: 'Última ubicación',
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CurrentLocation())),
          ),
          CustomRequestButtons(
            buttonTitle: 'Ver Historial de Ubicaciones\n Comming Soon',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
