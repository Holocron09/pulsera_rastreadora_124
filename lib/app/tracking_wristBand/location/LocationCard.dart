import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pulsera_rastreadora_124/app/tracking_wristBand/firebase_Database.dart';

class ChildCurrentLocation extends StatefulWidget {
  const ChildCurrentLocation({
    @required this.childName,
  });
  final String childName;

  @override
  _ChildCurrentLocationState createState() => _ChildCurrentLocationState();
}

class _ChildCurrentLocationState extends State<ChildCurrentLocation> {
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<Marker> allMarkers = [];

  void dispose() {
    super.dispose();
    allMarkers.clear();
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<ReadFirebaseDatabase>(context);

    Future<List> getCurrentChildLocation() async {
      final _location = await database.getLocation(widget.childName);
      return _location;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Ubicación de: ${widget.childName}'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              getCurrentChildLocation();
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: FutureBuilder<List>(
        future: getCurrentChildLocation(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            final _latitude = snapshot.data[0];
            final _longitude = snapshot.data[1];
            final LatLng _center = LatLng(_latitude, _longitude);
            allMarkers.clear();
            allMarkers.add(Marker(
              markerId: MarkerId('${widget.childName}'),
              draggable: false,
              position: _center,
            ));
            print(allMarkers.first);
            return InkWell(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Card(
                      elevation: 5,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          'Latitud: $_latitude \nLongitud: $_longitude',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GoogleMap(
                        zoomControlsEnabled: true,
                        zoomGesturesEnabled: true,
                        markers: Set.from(allMarkers),
                        myLocationEnabled: true,
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: _center,
                          zoom: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * .5,
                  child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}
