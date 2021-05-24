import 'package:flutter/cupertino.dart';

class Children {
  Children(
      {@required this.id,
      @required this.name,
      @required this.latitude,
      @required this.longitude});

  final String id;
  final String name;
  final double latitude;
  final double longitude;

  factory Children.fromMap(Map<String, dynamic> data, String documentID) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    final double latitude = data['latitude'];
    final double longitude = data['longitude'];
    return Children(
      id: documentID,
      name: name,
      latitude: latitude,
      longitude: longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
